/**
 * @file User.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import <Foundation/Foundation.h>
#import "Facebook.h"

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *facebookID;

@end
