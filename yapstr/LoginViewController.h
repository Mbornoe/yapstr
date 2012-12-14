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
#import "NetworkDriver.h"

/** The LoginViewController is a viewcontroller that is used to handle the login session with Facebook and the server */
@interface LoginViewController : UIViewController{
    FacebookUser* myFacebook;
    User *user;
    AppDelegate *mainDelegate;
}

/** Reference to an instance of FacebookUser from the Facebook Model. */
@property (strong, nonatomic) FacebookUser* myFacebook;

/** Reference to an instance of User from the User Model. */
@property (strong, nonatomic) User* user;

/** Reference to the ActivityIndicatorView that are used to indicate that the method is currently loading.  */
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;

/** Reference to an instance of UIButton that is used as a loginbutton for starting the login session.  */
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

/** Opens a Facebook session using the framework FacebookSDK. */
- (BOOL)sendLoginInfoToFacebook:(BOOL)allowLoginUI;

/** This method collects data about the user. The data that are pulled is facebookID and name. This information should be sent to the external server to see if the user has been using the application before. */
- (void)collectUserData;
@end
