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
@synthesize longitude;
@synthesize latitude;
-(id) initWithLatitude: (double)latitude andLongitude: (double)longitude{
    latitude = latitude;
    longitude = longitude;
    return self;
}
@end
