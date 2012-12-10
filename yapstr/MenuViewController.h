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
#import "LoginViewController.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITabBarControllerDelegate>

/** An IBAction button that is used to navigate to the Take Photo View. */
- (IBAction)takePhotoButton:(id)sender;

/** An IBAction button that is used to navigate to the View Event View. */
- (IBAction)viewEventButton:(id)sender;

/** An IBAction button that is used to navigate to the Upload Photo View. */
- (IBAction)uploadPhotoButton:(id)sender;

/** An IBAction button that is used to navigate to the Login View. */
- (IBAction)logout:(id)sender;


@end
