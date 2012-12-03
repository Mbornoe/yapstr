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

- (void)collectUserData{
    [self.loading startAnimating];
    mainDelegate.myUser.facebookID = [myFacebook getFacebookID];
    mainDelegate.myUser.name = [myFacebook getFacebookName];
    NSLog(@"User.facebookID = %@", mainDelegate.myUser.facebookID);
    NSDictionary *dataToServer = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [myFacebook getFacebookID], @"facebookID",
                                  nil];
    
    NSData *dataToServerData = [NSJSONSerialization dataWithJSONObject:dataToServer options:kNilOptions error:nil];
    
    NSString *dataToServerJSONUrlString = [NSString stringWithFormat:@"http://12gr550.lab.es.aau.dk/UserController/getUser?data=%@", parseToJSON(dataToServerData)];
    NSLog(@"%@",dataToServerJSONUrlString);
    
    
    NSError* error = nil;
    NSURL *url = [NSURL URLWithString:dataToServerJSONUrlString];
    NSData *JASONData = [NSData dataWithContentsOfURL:url];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:JASONData options:kNilOptions error:&error];
    mainDelegate.myUser.userID = [data objectForKey:@"id"];
    mainDelegate.myUser.name = [data objectForKey:@"name"];
    [self.loading stopAnimating];
    [mainDelegate.myUser dumpUserDataInTerminal];
    
}

NSString *parseToJSON(NSData *dataToParse){
    
    NSString *eventJSONString = [[NSString alloc] initWithData:dataToParse encoding:NSUTF8StringEncoding];
    NSString *encodedJSONString = [eventJSONString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return encodedJSONString;
    
}

- (void)facebookDataLoaded:(NSNotification*)notification {
    [self collectUserData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
}

- (IBAction)Login:(id)sender {
    NSLog(@"Button pust");
    [self.loading startAnimating];
    logout=NO;
    if ([self openSessionWithAllowLoginUI:YES]){
        NSLog(@"Kunne Ikke Logge på Facebook!");
        [self.loading stopAnimating];
    }
}

- (void)logFacebookOut{
    NSLog(@"Facebook Logout");
    [FBSession.activeSession closeAndClearTokenInformation];
    myFacebook.facebookID = nil;
    myFacebook.name = nil;
    myFacebook.birthday = nil;
}

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

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id<FBGraphUser> user, NSError *error) {
                    
                    // We have a valid session
                    
                    
                    // Gemmer User data in variavels
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
