/**
 * @file CameraViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles the iPhones integrated camera, taking, storing photos and uploading them to the server.
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface CameraViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    UIImagePickerController*imagePicker;
}

- (void) startCamera;
- (void) takePhoto;
- (void) uploadPhoto;

- (IBAction)revealSideMenu:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

// Transform values for full screen support:
#define CAMERA_TRANSFORM_X 1
//#define CAMERA_TRANSFORM_Y 1.12412 // this was for iOS 3.x
#define CAMERA_TRANSFORM_Y 1.24299 // this works for iOS 4.x

// iPhone screen dimensions:
#define SCREEN_WIDTH  320
#define SCREEN_HEIGTH 480

//#define SCREEN_WIDTH  640
//#define SCREEN_HEIGTH 1136

@end
