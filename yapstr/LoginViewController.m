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
@synthesize myFacebook;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    myFacebook = [[FacebookUser alloc] init];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(facebookDataLoaded:)
     name:FacebookDataLoadedNotification
     object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated{
    // Do any additional setup after loading the view, typically from a nib.
    if ([myFacebook getFacebookID]) {
        mainDelegate.myUser.facebookID = [myFacebook getFacebookID];
        mainDelegate.myUser.name = [myFacebook getFacebookName];
        [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
        NSLog(@"Is login");
    }
    else
    {
        NSLog(@"Is NOT login");
        [myFacebook openSessionWithAllowLoginUI:NO];
    }
}

- (void)viewDidUnload{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)facebookDataLoaded:(NSNotification*)notification {
        mainDelegate.myUser.facebookID = [myFacebook getFacebookID];
    NSLog(@"User.facebookID = %@", mainDelegate.myUser.facebookID);
    mainDelegate.myUser.name = [myFacebook getFacebookName];
    [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
}

- (IBAction)Login:(id)sender {
    NSLog(@"Button pust");
    [myFacebook openSessionWithAllowLoginUI:YES];
    NSLog(@"Method logWithFacebook is calld");
}

@end
