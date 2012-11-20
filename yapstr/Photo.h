/**
 * @file Photo.h
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
#import "Location.h"

@interface Photo : NSObject
@property (retain) NSString* photoPath;
@property (retain) NSString* thumpnailPath;
@property (retain) NSNumber* userID;
@property (retain) Location* location;
@property (retain) NSNumber* eventID;
@property (retain) NSNumber* photoID;
- (void) startCamera;
- (void) takePhoto;
- (void) showPhoto;
- (void) setDeleteFlag;
- (void) selectPhotoFromCameraRoll;
- (void) requestPhotosFromServer;

@end
