/**
 * @file ViewPhotoViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles presentation photos, both photos stored locally on the phone and externally on a server. Photos can furthermore be flagged for deletion.
 */

#import <UIKit/UIKit.h>

@interface ViewPhotoViewController : UIViewController

- (void) requestPhotosFromCameraRoll;
- (void) requestPhotosFromServer;
- (void) selectPhotoFromCameraRoll;
- (void) showPhoto;
- (void) setDeleteFlag;

@end
