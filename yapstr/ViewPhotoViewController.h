/**
 * @file ViewPhotoViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles presentation photos, both photos stored locally on the phone and externally on a server. Photos can furthermore be flagged for deletion.
 */

#import <UIKit/UIKit.h>
#import "Photo.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "NetworkDriver.h"

@interface ViewPhotoViewController : UIViewController{
}

/** Reference to an array that contains all the defined photos. */
@property (strong) NSArray* photos;

/** Reference to the interger named currentPic, which is used to determine which picture the user are at when swiping left and right.  */
@property int currentPic;

/** Reference to the UIImageview that is containg the the picture that is selected to be viewed. */
@property(weak) IBOutlet UIImageView *imageView;

/** Reference to the ActivityIndicatorView that are used to indicate that the method is currently loading.  */
@property (strong) IBOutlet UIActivityIndicatorView *loading;

/** Reference to a IBAction that is used when the user swipes right.*/
-(IBAction)swipeRight:(id)sender;

/** Reference to a IBAction that is used when the user swipes left.*/
-(IBAction)swipeLeft:(id)sender;

/** Reference to a IBAction that is used when the user markes a photo for deletion.*/
- (IBAction)deleteFlag:(id)sender;

/** Requests a photo from the server to be presented. */
- (void) requestPhotoFromServer;

/** Shows the photo that the user wants to be presented. */
- (void) showPhoto;

/** Method that can be used in case the user wants a picture deleted. */
- (void) deleteFlag;

/** Method that requests the photos from server. */
- (void) loadPhoto;

@end
