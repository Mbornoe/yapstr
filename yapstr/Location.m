/**
 * @file Location.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The purpose of this class is to deliver create an object which contains longitude and latitude informations.
 */

#import "Location.h"

@implementation Location

/** The compiler to create getter/setters for the following properties */
@synthesize longitude;
@synthesize latitude;

/** Method used to set the latitude and longitude coordinates. */
-(id) initWithLatitude:(float)inLatitude andLongitude:(float)inLongitude{
    self.latitude = inLatitude;
    self.longitude = inLongitude;
    return self;
}
@end
