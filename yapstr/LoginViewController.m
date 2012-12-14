/**
 * @file LoginViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles user login. This includes validating the user against Facebook and YAPSTR's own user database.
 */

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize myFacebook, user;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"ViewDidLoad");
    user = [[User alloc] init];
    myFacebook = [[FacebookUser alloc] init];
    self.loginButton.hidden = YES;
    self.loading.hidesWhenStopped = YES;
        
    [self.loading startAnimating];
    if(![self sendLoginInfoToFacebook:NO]){
        [self.loading stopAnimating];
        self.loginButton.hidden = NO;
    }
}


/** This method collects data about the user. The data that are pulled is facebookID and name. This information should be sent to the external server to see if the user has been using the application before. */
- (void)collectUserData{
    [self.loading startAnimating];
    
    user = [NetworkDriver requestUserId:myFacebook];

    mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    mainDelegate.myUser = user;
    
    [self.loading stopAnimating];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
    
    [mainDelegate.myUser dumpUserDataInTerminal];
    
}

/** A button the will log the user in.*/
- (IBAction)Login:(id)sender {
    [self.loading startAnimating];
    if ([self sendLoginInfoToFacebook:YES]){
        NSLog(@"Kunne Ikke Logge på Facebook!");
        [self.loading stopAnimating];
    }
}

/** Opens a Facebook session using the framework FacebookSDK. */
- (BOOL)sendLoginInfoToFacebook:(BOOL)allowLoginUI
{
    return [FBSession openActiveSessionWithReadPermissions:nil
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
                                             [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                         }];
}

/** Determine if the Facebook session state has been changed. I.e. if the Facebook state has been closed or other errors has occured. */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id<FBGraphUser> FBGraphUserUser, NSError *error) {
                    
                    /** If we have a valid session, the User data are stored in parameteres */
                    myFacebook.facebookID = FBGraphUserUser.id;
                    myFacebook.name = FBGraphUserUser.name;
                    myFacebook.birthday = FBGraphUserUser.birthday;
                    
                    [self collectUserData];
                    
                }];
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    if (error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"could not connect to facebook :'("
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
