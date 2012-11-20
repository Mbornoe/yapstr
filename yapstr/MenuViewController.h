/**
 * @file MenuViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles navigation between the applications functionalities.
 */

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITabBarControllerDelegate>
- (IBAction)takePhotoButton:(id)sender;

@end
