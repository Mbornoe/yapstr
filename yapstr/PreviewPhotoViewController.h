/**
 * @file  PreviewPhotoViewController.h
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

@interface PreviewPhotoViewController : UIViewController
@property IBOutlet UIImageView* imageView;
@property (strong) UIImage* snappedPhoto;

@end
