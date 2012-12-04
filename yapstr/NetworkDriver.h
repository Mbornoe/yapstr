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
#import "Location.h"
#import "Event.h"
#import "Photo.h"


@interface NetworkDriver : NSObject

+ (void)uploadPhoto:(UIImage*)image withEvent:(Event*)event;
+ (Event*) uploadEvent:(Event*)eventIn;
+ (void)uploadLocation:(Location*)location;
+(NSString *) parseToJSON: (NSData*)dataToParse;
+(NSArray*)regEvents;
+(NSArray*)reqPhotosWithEvent:(Event*)event;

@end
