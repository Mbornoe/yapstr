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

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *facebookId;

- (void)dumpUserDataInTerminal;
- (void)clearUser;
@end
