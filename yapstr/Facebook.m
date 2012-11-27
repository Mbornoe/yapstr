/**
 * @file Facebook.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import "Facebook.h"

@implementation FacebookUser
@synthesize facebookID, name, birthday;

NSString *const FacebookDataLoadedNotification =
@"yapstr_itc:FacebookDataLoadedNotification";

- (NSString*)getFacebookID{
    return facebookID;
}
- (NSString*)getFacebookName{
    return name;
}
- (NSString*)getFacebookBirthday{
    return birthday;
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
                    facebookID = user.id;
                    name = user.name;
                    birthday = user.birthday;
                    
                    
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
        
        /*
         UIAlertView *alertView = [[UIAlertView alloc]
         initWithTitle:@"Error"
         message:error.localizedDescription
         delegate:nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [alertView show];
         */
    }
}

@end