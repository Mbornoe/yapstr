/**
 * @file Location.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import "Location.h"

@implementation Location
@synthesize x;
@synthesize y;
-(id) initWithLatitude: (double)latitude andLongitude: (double)longitude{
    x = latitude;
    y = longitude;
    return self;
}
@end
