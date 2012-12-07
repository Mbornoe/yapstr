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
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import "PreviewPhotoViewController.h"

@interface CameraViewController : UIViewController;

/** Reference to a parameter that is used to let the user view the video feed. */
@property (retain) AVCaptureVideoPreviewLayer *previewLayer;

/** Reference to the actual camera method that are used to */
@property (retain) AVCaptureSession *captureSession;

/** Reference to a AVCaptureStillImageOutput that is used to configure the cameras output. */
@property (retain) AVCaptureStillImageOutput *stillImageOutput;

/** Refernce to a UIImage which is called snappedPhoto. This parameter is used for the captured photo. */
@property (strong) UIImage* snappedPhoto;

/** Method for instantiate and start the integrated camera. The Camera is instantiated with no buttons and only a overlay screen. */
- (void) startCamera;

/** Method for taking a photo. The overlay screen is used for determine when the user has tapped the screen, which results in a take photo action. */
- (void) takePhoto;

@end
