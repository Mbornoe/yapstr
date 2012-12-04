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

/** The compiler to create getter/setters for the following properties */
@synthesize facebookID, name, userID;


/** Methods for debugging. Printing the name, userID and facebookID when executed. */
- (void)dumpUserDataInTerminal{
    /** Printing name. */
    NSLog(@"Name: %@", name);
    
    /** Printing userID. */
    NSLog(@"userID: %@", userID);
    
    /** Printing facebookID. */
    NSLog(@"facebookID: %@", facebookID);
}


/** Method that clear the name, userID and facebookID by declaring it to nil. */
- (void)clearUser{
    /** Printing a debugging notation to make sure the User Data is cleared.. */
    NSLog(@"Clear User Data");
    
    name = nil;
    userId = nil;
    facebookId = nil;
}

@end
