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
-(id) initWithLatitude: (double)inLatitude andLongitude: (double)inLongitude{
    self.latitude = inLatitude;
    self.longitude = inLongitude;
    return self;
}
@end
