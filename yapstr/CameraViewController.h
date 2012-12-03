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
#import <ImageIO/ImageIO.h>

@interface CameraViewController : UIViewController;


@property (nonatomic, retain) UILabel *scanningLabel;
@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureStillImageOutput *stillImageOutput;
@property (strong) UIImage* snappedPhoto;

- (void) saveImageToPhotoAlbum;
- (void) scanButtonPressed;
- (void) takePhotoButtonPressed;
- (void) takePhoto;
- (void) hideLabel;
- (void) image;
- (void) startCamera;

@end
