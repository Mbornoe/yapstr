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

@interface Photo : NSObject

- (void) startCamera;
- (void) takePhoto;
- (void) showPhoto;
- (void) setDeleteFlag;
- (void) selectPhotoFromCameraRoll;
- (void) requestPhotosFromServer;

@end
