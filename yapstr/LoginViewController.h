/**
 * @file LoginViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles user login. This includes validating the user against Facebook and YAPSTR's own user database.
 */

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "User.h"
#import "AppDelegate.h"

@interface LoginViewController : UIViewController{
    //    User* myUser;
    FacebookUser* myFacebook;
    AppDelegate *mainDelegate;
    
}
//@property (strong, nonatomic) User* myUser;
@property (strong, nonatomic) FacebookUser* myFacebook;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;

    
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end
