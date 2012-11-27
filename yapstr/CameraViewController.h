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
#import "CaptureSessionManager.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import <ImageIO/ImageIO.h>

@interface CameraViewController : UIViewController;


@property (retain) CaptureSessionManager *captureManager;
@property (nonatomic, retain) UILabel *scanningLabel;

- (void) saveImageToPhotoAlbum;
- (void) scanButtonPressed;
- (void) takePhotoButtonPressed;
- (void) hideLabel;
- (void) image;

@end
