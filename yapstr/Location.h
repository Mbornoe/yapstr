/**
 * @file Location.h
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

@interface Location : NSObject
@property(assign, nonatomic)double longitude;
@property(assign, nonatomic)double latitude;
-(id) initWithLatitude: (double)latitude andLongitude: (double)longitude;
@end
