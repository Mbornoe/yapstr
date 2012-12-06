/**
 * @file Location.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The purpose of this class is to deliver create an object which contains longitude and latitude informations.
 */

#import <Foundation/Foundation.h>

@interface Location : NSObject

/** Parameter which is used as a container for the longitude coordinates. */
@property(assign, nonatomic)float longitude;

/** Parameter which is used as a container for latitude coordinates. */
@property(assign, nonatomic)float latitude;

/** Method used to set the latitude and longitude coordinates. */
-(id) initWithLatitude: (float)latitude andLongitude: (float)longitude;
@end
