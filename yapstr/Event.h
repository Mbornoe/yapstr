/**
 * @file Event.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The purpose of this class is to be a representation of a event. The class contains information about location, name and description of the event.
 */

#import <Foundation/Foundation.h>
#import "Location.h"
#import <MapKit/MapKit.h>

/** Object containing location, name and description of an Event*/
@interface Event : NSObject<MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *subtitle;
    NSString *title;
}


/** Parameter which is used as a container for information about if the Event is public or private. */
@property NSString *privateOn;

/** Parameter which is used as a container for the name of the Event. */
@property NSString *name;

/** Parameter which is used as a container for the date of the Event. */
@property NSString *date;

/** Parameter which is used as a container for a description of the Event. */
@property NSString *description;

/** Parameter which is used as a container for the password of the Event. */
@property NSString *password;

/** Parameter which is used as a typecasted container of a Location object. */
@property Location *location;

/** Parameter which is used as a container for unique eventId belonging to the Event. */
@property (retain) NSNumber* eventId;


/** Method used to set the information about a Event. It contains information about hte coordinates, name and description of the Event. */
-(void)setCoordinate:(CLLocationCoordinate2D) c;

@end
