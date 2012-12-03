/**
 * @file User.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class hold properties of the user on the mobile client.
 */

#import "User.h"

@implementation User
@synthesize facebookID, name, userID;

- (void)dumpUserDataInTerminal{
    NSLog(@"Name: %@", name);
    NSLog(@"userID: %@", userID);
    NSLog(@"facebookID: %@", facebookID);
}

- (void)clearUser{
    NSLog(@"Clear User Data");
    name = nil;
    userID = nil;
    facebookID = nil;
}

@end
