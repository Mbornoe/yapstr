/**
 * @file NetworkDriver.h
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
#import "Event.h"

@interface NetworkDriver : NSObject

- (void) uploadPhoto;
+ (void) uploadEvent:(NSData*)eventData;
+(NSString *) parseToJSON: (NSData*)dataToParse;
+(NSArray*)regEvents;
+(NSArray*)reqPhotosWithEvent:(Event*)event;

@end
