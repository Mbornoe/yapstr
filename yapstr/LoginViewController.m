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
    self.loginButton.hidden = YES;
    self.loading.hidesWhenStopped = YES;
    
    if ([myFacebook getFacebookID]) {
        [self collectUserData];
        NSLog(@"Is login");
    }
    else
    {
        [self.loading startAnimating];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(facebookDataLoaded:)
         name:FacebookDataLoadedNotification
         object:nil];
        
        NSLog(@"Is NOT login");
        
        if(![myFacebook openSessionWithAllowLoginUI:NO]){
            [self.loading stopAnimating];
            self.loginButton.hidden = NO;
        }
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

- (void)viewDidUnload{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)facebookDataLoaded:(NSNotification*)notification {
    //    NSLog(@"FacebookID: %@", [myFacebook getFacebookID]);
    [self collectUserData];
    [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
}

- (IBAction)Login:(id)sender {
    NSLog(@"Button pust");
    [self.loading startAnimating];
    if (![myFacebook openSessionWithAllowLoginUI:YES]){
        NSLog(@"Kunne Ikke Logge på Facebook!");
        [self.loading stopAnimating];
    }
    NSLog(@"Method logWithFacebook is calld");
}

@end
