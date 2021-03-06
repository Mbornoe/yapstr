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
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "SelectEventViewController.h"
#import "Photo.h"

@interface PreviewPhotoViewController : UIViewController <CLLocationManagerDelegate>
@property IBOutlet UIImageView* imageView;
@property (strong) UIImage* snappedPhoto;

@end
