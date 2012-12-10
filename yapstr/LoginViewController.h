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
    AppDelegate *mainDelegate;
}

/** Reference to an external String that are used by Facebook. */
extern NSString *const FacebookDataLoadedNotification;

/** Reference to the a bool if the user is logged in or not. */
@property BOOL* logout;

/** Reference to an instance of FacebookUser from the Facebook Model. */
@property (strong, nonatomic) FacebookUser* myFacebook;

/** Reference to the a bool if the facebookdata is loaded or not. */
@property (nonatomic, assign) BOOL facebookDataLoaded;

/** Reference to the ActivityIndicatorView that are used to indicate that the method is currently loading.  */
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;

/** Reference to an instance of UIButton that is used as a loginbutton for starting the login session.  */
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

/** Opens a Facebook session using the framework FacebookSDK. */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;


/** Method that will close the Facebook session and define the related attributes to nil. */
- (void)logFacebookOut;

/** This method collects data about the user. The data that are pulled is facebookID and name. This information should be sent to the external server to see if the user has been using the application before. */
- (void)collectUserData;
@end
