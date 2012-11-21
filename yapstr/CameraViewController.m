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
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@end

@implementation CameraViewController

@synthesize captureManager;
@synthesize scanningLabel;

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        [[self scanningLabel] setHidden:YES];
    }
}

- (void)viewDidLoad {
    
	[self setCaptureManager:[[CaptureSessionManager alloc] init]];
    
    
	[[self captureManager] addVideoInput];
    
	[[self captureManager] addVideoPreviewLayer];
	CGRect layerRect = [[[self view] layer] bounds];
	[[[self captureManager] previewLayer] setBounds:layerRect];
	[[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                  CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:[[self captureManager] previewLayer]];
    
    UIButton *overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [overlayButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [overlayButton setFrame:CGRectMake(-5, 0, 65, 50)];
    [overlayButton addTarget:self action:@selector(scanButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:overlayButton];
    
    UIButton *takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePhotoButton setImage:[UIImage imageNamed:@"takePhoto_seeThroughButton2.png"] forState:UIControlStateNormal];
    [takePhotoButton setFrame:CGRectMake(0, 65, 320, 640)];
    [takePhotoButton addTarget:self action:@selector(takePhotoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:takePhotoButton];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 140, 40)];
    [self setScanningLabel:tempLabel];
	[scanningLabel setBackgroundColor:[UIColor clearColor]];
	[scanningLabel setFont:[UIFont fontWithName:@"Courier" size: 18.0]];
	[scanningLabel setTextColor:[UIColor whiteColor]];
	[scanningLabel setText:@"Saving Image"];
    [scanningLabel setHidden:YES];
	[[self view] addSubview:scanningLabel];
    
    
   // UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 120, 30)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveImageToPhotoAlbum) name:kImageCapturedSuccessfully object:nil];
    [[self captureManager] addStillImageOutput];
	[[captureManager captureSession] startRunning];
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

- (void) takePhotoButtonPressed {

	[[self scanningLabel] setHidden:NO];
	[self performSelector:@selector(hideLabel:) withObject:[self scanningLabel] afterDelay:2];
    [[self scanningLabel] setHidden:NO];
    [[self captureManager] captureStillImage];

}

- (void)saveImageToPhotoAlbum
{
    UIImageWriteToSavedPhotosAlbum([[self captureManager] stillImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)hideLabel:(UILabel *)label {
	[label setHidden:YES];
}


@end

