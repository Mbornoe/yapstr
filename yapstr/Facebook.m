/**
 * @file Facebook.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class hold properties of the user, that has to do with the user's facebookaccount on the mobile client.
 */

#import "Facebook.h"

@implementation FacebookUser
@synthesize facebookID, name, birthday;

- (NSString*)getFacebookID{
    return facebookID;
}
- (NSString*)getFacebookName{
    return name;
}
- (NSString*)getFacebookBirthday{
    return birthday;
}

@end