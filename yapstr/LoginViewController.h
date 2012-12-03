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
    FacebookUser* myFacebook;
    AppDelegate *mainDelegate;
}

extern NSString *const FacebookDataLoadedNotification;

@property BOOL* logout;
@property (strong, nonatomic) FacebookUser* myFacebook;
@property (nonatomic, assign) BOOL facebookDataLoaded;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void)logFacebookOut;

@end
