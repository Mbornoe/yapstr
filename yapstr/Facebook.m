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

/** The compiler to create getter/setters for the following properties */
@synthesize facebookID, name, birthday;

/** Method used to get the user's Facebook ID. Returns facebookID. */
- (NSString*)getFacebookID{
    return facebookID;
}

/** Method used to get the user's Facebook name. Returns name. */
- (NSString*)getFacebookName{
    return name;
}

/** Method used to get the user's Facebook birthday. Returns birthday. */
- (NSString*)getFacebookBirthday{
    return birthday;
}

@end