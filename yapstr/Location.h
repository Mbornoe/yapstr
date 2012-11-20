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
@property(assign, nonatomic)double x;
@property(assign, nonatomic)double y;
-(id) initWithLatitude: (double)latitude andLongitude: (double)longitude;
@end
