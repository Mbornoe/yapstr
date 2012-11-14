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

@interface CameraViewController : UIViewController

- (void) startCamera;
- (void) takePhoto;
- (void) uploadPhoto;

@end
