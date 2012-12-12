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
#import "CameraViewController.h"


@interface CameraViewController ()
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@end

@implementation CameraViewController

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
    
    /** Adding video Preview Layer */
    self.PreviewLayer=[[AVCaptureVideoPreviewLayer alloc] initWithSession:[self captureSession]];
	[previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    /** Setting Preview Layer */
    CGRect layerRect = [[[self view] layer] bounds];
	[previewLayer setBounds:layerRect];
	[previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                          CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:previewLayer];
    
    
    /** Setting Take Photo Button */
    UIButton *takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePhotoButton setImage:[UIImage imageNamed:@"takePhoto_seeThroughButton2.png"] forState:UIControlStateNormal];
    [takePhotoButton setFrame:CGRectMake(0, 65, 320, 640)];
    [takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:takePhotoButton];
    
    /** Configuring camera */
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
    /** Starts the camera.*/
	[captureSession startRunning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /** shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController. */
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

/** Method for taking a photo. The overlay screen is used for determine when the user has tapped the screen, which results in a take photo action. */
- (void) takePhoto{
    
    /** Configuring the take photo place to be the Camera output. */
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
    
    /** Taking a photo by making a request to the camera output. And tage an image from the video buffer.*/
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

/** Method for storing captured image, to be passed on to PreviewPhotoViewController afterwards. */
-(void)doSegue:(UIImage*)img {
    snappedPhoto=img;
    [self performSegueWithIdentifier:@"cameraToPreview" sender:self];
}

/** Segue sending the captured image to PreviewPhotoViewController for user confirmation. */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"cameraToPreview"]){
        PreviewPhotoViewController *vc = (PreviewPhotoViewController *)[segue destinationViewController];
        vc.snappedPhoto=self.snappedPhoto;
    }
}

@end

