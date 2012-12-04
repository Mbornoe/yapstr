/**
 * @file User.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class hold properties of the user on the mobile client.
 */

#import <Foundation/Foundation.h>
#import "Facebook.h"

@interface User : NSObject

/** Parameter which is used as a container for the user's name. */
@property (strong, nonatomic) NSString *name;

/** Parameter which is used as a container for the user's ID. */
@property (strong, nonatomic) NSNumber *userID;

/** Parameter which is used as a container for the user's Facebook ID. */
@property (strong, nonatomic) NSString *facebookID;

/** Method for debugging. Printing the name, userID and facebookID when executed. */
- (void)dumpUserDataInTerminal;

/** Method that clear the name, userID and facebookID by declaring it to nil. */
- (void)clearUser;

@end
