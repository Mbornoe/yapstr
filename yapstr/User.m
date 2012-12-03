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
@synthesize facebookId, name, userId;

- (void)dumpUserDataInTerminal{
    NSLog(@"Name: %@", name);
    NSLog(@"userId: %@", userId);
    NSLog(@"facebookId: %@", facebookId);
}

- (void)clearUser{
    NSLog(@"Clear User Data");
    name = nil;
    userId = nil;
    facebookId = nil;
}

@end
