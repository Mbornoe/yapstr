/**
 * @file Event.h
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
#import "Location.h"

@interface Event : NSObject
@property NSString *privateOn;
@property NSString *name;
@property NSString *date;
@property NSString *description;
@property NSString *password;
@property Location *location;
- (void) createEvent;
- (void) requestEvents;
- (void) selectEvent;
- (void) showEvent;
- (void) showEvents;

@end
