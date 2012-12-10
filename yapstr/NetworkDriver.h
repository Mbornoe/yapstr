/**
 * @file NetworkDriver.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The NetworkDriver is used for communicating data between the view controlleres in the Mobile Client subsystem and the views and controllers in the Server subsystem.
 */

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Event.h"
#import "Photo.h"
#import "Facebook.h"
#import "User.h"

@interface NetworkDriver : NSObject

/** Method inform the Server that a certain photo has been flaged for deletion. Takes the said photo object as input parameter. */
+ (void)reqSetDeleteFlag:(Photo*)photo;

/** Method allowing upload of photo Takes an image and an event object as input parameters. */
+ (void)uploadPhoto:(UIImage*)image withEvent:(Event*)event;

/** Method for requesting all events. */
+ (NSArray*)regEvents;

/** Method for requesting the events in the in the vicinity of the users location. Takes an event object holding the users current location as input parameter. */
+ (NSArray*)regEvents:(Location*)location;

/** Method for requesting the photos associated with a certain event. Takes the event object that the photos are associated with as input parameter. */
+ (NSArray*)reqPhotosFromServer:(Event*)event;

/** Method allowing upload of event. Takes an event object as input parameters. */
+ (Event*) uploadEvent:(Event*)eventIn;

/** Method for requesting userId and information. */
+ (User*) regUserId:(FacebookUser*)facebookUser;

+ (UIImage*) reqPhotoFromServer:(NSURL*)url;

@end
