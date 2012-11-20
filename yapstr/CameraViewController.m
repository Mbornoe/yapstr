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

@end

@implementation CameraViewController
@synthesize imageView;


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    NSLog(@"Hej! Jeg har er viewWillAppear");
    
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

- (void)viewDidLoad
{
    imagePicker=[[UIImagePickerController alloc]init];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
 
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //imageView.image=nil;
    [self startCameraControllerFromViewController: self
     
                                    usingDelegate: self];
    

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //NSLog(@"Jeg gemmer billede");
    UIImage *image;
    image =(UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
    imageView.image=image;
    UIImage *imageToSave;
    imageToSave=imageView.image;
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    //[self dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"Jeg gemmer billede");
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
    
    
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
        [picker dismissViewControllerAnimated:NO completion:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller

                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   
                                                   UINavigationControllerDelegate>) delegate {
    
    
    
    if (([UIImagePickerController isSourceTypeAvailable:
          
          UIImagePickerControllerSourceTypeCamera] == NO)
        
        || (delegate == nil)
        
        || (controller == nil))
        
        return NO;
    
    
    
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    
    // Displays a control that allows the user to choose picture or
    
    // movie capture, if both are available:
    
    //cameraUI.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    
    
    // Hides the controls for moving & scaling pictures, or for
    
    // trimming movies. To instead show the controls, use YES.
    cameraUI.showsCameraControls = YES;
	cameraUI.navigationBarHidden = YES;
    cameraUI.allowsEditing = NO;
    
    // Make camera view full screen:
	cameraUI.wantsFullScreenLayout = YES;
	//cameraUI.cameraViewTransform = CGAffineTransformScale(cameraUI.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
    
    cameraUI.delegate = delegate;
    
    //  cameraUI.cameraOverlayView = ;
    
    [controller presentModalViewController: cameraUI animated: YES];
    //[self imagePickerController: self
      //                              usingDelegate: self];
    
    return YES;
    
}


- (void) startCamera
{
    
}
- (void) takePhoto
{
    
}
- (void) uploadPhoto
{
    
}
- (IBAction)revealSideMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}


@end
