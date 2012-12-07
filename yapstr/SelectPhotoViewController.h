/**
 * @file SelectPhotoViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import <UIKit/UIKit.h>
#import "PreviewPhotoViewController.h"

@interface SelectPhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UIImage *img;
	UIImagePickerController *imgPicker;
}

/** Reference to the image picker controller, enabling access to the iPhones cameraroll. */
@property (nonatomic, retain) UIImagePickerController *imgPicker;

/** Reference to the image chosen from the iPhones cameraroll. */
@property (nonatomic, retain) UIImage *img;

/** Reference to . */
@property BOOL *firstTime;

@end
