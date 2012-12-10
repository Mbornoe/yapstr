/**
 * @file Event.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The purpose of this class is to be a representation of a event. The class contains information about location, name and description of the event.
 */

#import "Event.h"

@implementation Event

/** The compiler to create getter/setters for the following properties */
@synthesize coordinate, title, subtitle, eventId, description;


/** Method used to set the information about a Event. It contains information about hte coordinates, name and description of the Event. */
-(void)setCoordinate:(CLLocationCoordinate2D) c {
    coordinate=c;
    title = [self name];
    subtitle = description;
}

@end
