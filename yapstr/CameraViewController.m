/**
 * @file CameraViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles the iPhones integrated camera, taking, storing photos and uploading them to the server.
 */
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

#import "CameraViewController.h"
#import "PreviewPhotoViewController.h"

@interface CameraViewController ()
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@end
@implementation UIImage (Extras)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
@end

@implementation CameraViewController

@synthesize scanningLabel;
@synthesize captureSession;
@synthesize previewLayer;
@synthesize stillImageOutput;
@synthesize snappedPhoto;

- (void)viewDidLoad {
    [self startCamera];
}

-(void)startCamera {
    //Adding video Input device!!
    self.CaptureSession=[[AVCaptureSession alloc] init];
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [captureSession setSessionPreset:AVCaptureSessionPreset1280x720];
	if (videoDevice) {
		NSError *error;
		AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		if (!error) {
			if ([[self captureSession] canAddInput:videoIn])
				[[self captureSession] addInput:videoIn];
			else
				NSLog(@"Couldn't add video input");
		}
		else
			NSLog(@"Couldn't create video input");
	}
	else
		NSLog(@"Couldn't create video capture device");
    
    //Adding video Preview Layer!!!
    self.PreviewLayer=[[AVCaptureVideoPreviewLayer alloc] initWithSession:[self captureSession]];
	[previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //Setting Preview Layer!!
    CGRect layerRect = [[[self view] layer] bounds];
	[previewLayer setBounds:layerRect];
	[previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                  CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:previewLayer];
    
    
    //Setting Take photo Button
    UIButton *takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePhotoButton setImage:[UIImage imageNamed:@"takePhoto_seeThroughButton2.png"] forState:UIControlStateNormal];
    [takePhotoButton setFrame:CGRectMake(0, 65, 320, 640)];
    [takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:takePhotoButton];
    
    //Setting the taking photo label!
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 140, 40)];
    [self setScanningLabel:tempLabel];
	[scanningLabel setBackgroundColor:[UIColor clearColor]];
	[scanningLabel setFont:[UIFont fontWithName:@"Courier" size: 18.0]];
	[scanningLabel setTextColor:[UIColor whiteColor]];
	[scanningLabel setText:@"Saving Image"];
    [scanningLabel setHidden:YES];
	[[self view] addSubview:scanningLabel];
    
    //Configuring camera
    [self setStillImageOutput:[[AVCaptureStillImageOutput alloc] init]];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [[self stillImageOutput] setOutputSettings:outputSettings];
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    [captureSession addOutput:[self stillImageOutput]];

    
    //Starting everyThing!
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveImageToPhotoAlbum) name:kImageCapturedSuccessfully object:nil];
	[captureSession startRunning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void) scanButtonPressed {
	[[self scanningLabel] setHidden:NO];
    
	[self performSelector:@selector(hideLabel:) withObject:[self scanningLabel] afterDelay:2];
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void) takePhoto{
	AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) {
            break;
        }
	}
	NSLog(@"about to request a capture from: %@", [self stillImageOutput]);
	[[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection
                                                         completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
                                                             CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
                                                             if (exifAttachments) {
                                                                 NSLog(@"attachements: %@", exifAttachments);
                                                             } else {
                                                                 NSLog(@"no attachments");
                                                             }
                                                             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
                                                             UIImage *img = [[UIImage alloc] initWithData:imageData];
                                                             [self performSelectorOnMainThread:@selector(doSegue:) withObject:img waitUntilDone:NO];
                                                             }];
}

-(void)doSegue:(UIImage*)img {
    snappedPhoto=[img imageByScalingAndCroppingForSize:CGSizeMake(640, 920)];
    [self performSegueWithIdentifier:@"cameraToPreview" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"cameraToPreview"]){
        PreviewPhotoViewController *vc = (PreviewPhotoViewController *)[segue destinationViewController];
        vc.snappedPhoto=self.snappedPhoto;
    }
}




@end

