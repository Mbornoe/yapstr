/**
 * @file User.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import "User.h"

@implementation User
@synthesize facebookId, name, userId;

- (void)dumpUserDataInTerminal{
    NSLog(@"Name: %@", name);
    NSLog(@"userID: %@", userId);
    NSLog(@"facebookID: %@", facebookId);
}

- (void)clearUser{
    NSLog(@"Clear User Data");
    name = nil;
    userId = nil;
    facebookId = nil;
}

@end
