/**
 * @file Photo.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The purpose of this class is to deliver a whereabouts of a photo on the external server. The class contains info about path to the image and its thumbnail, userid, a Location object, eventID and a photoID.
 */

#import <Foundation/Foundation.h>
#import "Location.h"
#import <UIKit/UIKit.h>

@interface Photo : NSObject

-(UIImage*)resizeImg:(UIImage*)sourceImage;

/** Parameter which is used as a container for the path to the photo. */
@property (retain) NSString* photoPath;

/** Parameter which is used as a container for the path to the thumbnail of the photo. */
@property (retain) NSString* thumpnailPath;

/** Parameter which is used as a container for the userID belonging to the user whom uploaded the picture. */
@property (retain) NSNumber* userID;

/** Parameter which is used as a typecasted container of a Location object. */
@property (retain) Location* location;

/** Parameter which is used as a container for the eventID belonging to the user selected event. */
@property (retain) NSNumber* eventID;

/** Parameter which is used as a container for a photoID belonging to the unique photo. */
@property (retain) NSNumber* photoID;

/** Reference to the image chosen from the iPhones cameraroll. */
@property (nonatomic, retain) UIImage *img;

@end
