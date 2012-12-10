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
@synthesize myFacebook, logout;

NSString *const FacebookDataLoadedNotification =
@"yapstr_itc:FacebookDataLoadedNotification";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"ViewDidLoad");
    mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    myFacebook = [[FacebookUser alloc] init];
    self.loginButton.hidden = YES;
    self.loading.hidesWhenStopped = YES;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(facebookDataLoaded:)
     name:FacebookDataLoadedNotification
     object:nil];
    
    if (!logout) {
        
        if ([myFacebook getFacebookID]) {
            [self collectUserData];
            NSLog(@"Is login");
        }
        else
        {
            [self.loading startAnimating];
            
            NSLog(@"Is NOT login");
            
            if(![self openSessionWithAllowLoginUI:NO]){
                [self.loading stopAnimating];
                self.loginButton.hidden = NO;
            }
            
        }
    }else {
        self.loginButton.hidden = NO;
        [mainDelegate.myUser clearUser];
        [self logFacebookOut];
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    // Do any additional setup after loading the view, typically from a nib.
}
/** This method collects data about the user. The data that are pulled is facebookID and name. This information should be sent to the external server to see if the user has been using the application before. */
- (void)collectUserData{
    [self.loading startAnimating];
    
    mainDelegate.myUser = [NetworkDriver regUserId:myFacebook];
    
    [self.loading stopAnimating];
    
    [mainDelegate.myUser dumpUserDataInTerminal];
    
}

/**  Method that is used when the Facebook data has been succesfully loaded, and the application are ready to proceed. */
- (void)facebookDataLoaded:(NSNotification*)notification {
    [self collectUserData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
}

/** A button the will log the user in.*/
- (IBAction)Login:(id)sender {
    NSLog(@"Button pust");
    [self.loading startAnimating];
    logout=NO;
    if ([self openSessionWithAllowLoginUI:YES]){
        NSLog(@"Kunne Ikke Logge på Facebook!");
        [self.loading stopAnimating];
    }
}

/** Method that will close the Facebook session and define the related attributes to nil. */
- (void)logFacebookOut{
    NSLog(@"Facebook Logout");
    [FBSession.activeSession closeAndClearTokenInformation];
    myFacebook.facebookID = nil;
    myFacebook.name = nil;
    myFacebook.birthday = nil;
}

/** Opens a Facebook session using the framework FacebookSDK. */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI { NSLog(@"openSessionWithAllowLoginUI is calld");
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
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id<FBGraphUser> user, NSError *error) {
                    
                    /** If we have a valid session, the User data are stored in parameteres */
                    myFacebook.facebookID = user.id;
                    myFacebook.name = user.name;
                    myFacebook.birthday = user.birthday;
                    
                    
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:FacebookDataLoadedNotification
                     object:session];
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
