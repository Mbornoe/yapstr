/**
 * @file CreateEventViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles creation of new events.
 */

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NetworkDriver.h"
#import "SelectEventViewController.h"
#import "Location.h"
#import "Event.h"

/** CreateEventViewController is a view controller that recives userinput and collects location data, to create an event that will be uploaded to a server's database. */
@interface CreateEventViewController : UIViewController <UITextFieldDelegate,CLLocationManagerDelegate>

/** Reference to the switch between private and public event. */
@property (weak, nonatomic) IBOutlet UISwitch *privateSwitch;

/** Reference to the name entered by the user. */
@property (weak, nonatomic) IBOutlet UITextField *name;

/** Reference to the description entered by the user. */
@property (weak, nonatomic) IBOutlet UITextField *description;

/** Reference to the password entered by the user, only relevant for private event. */
@property (weak, nonatomic) IBOutlet UITextField *password;

/** Reference to the label telling the user if the event is private or public. */
@property (weak, nonatomic) IBOutlet UILabel *privatLabel;

/** The logitude with double precision. */
@property(assign, nonatomic)double longitude;

/** The latitude with double precision. */
@property(assign, nonatomic)double latitude;

/** Reference to an instance of the event class. */
@property Event* createdEvent;

/** Reference to an instance of UIImage. */
@property UIImage* image;

/** Creating an event using the collected user info and location data. */
- (IBAction)createEvent;

/** Switching between private and public event is done using */
- (IBAction)checkPrivat;

/** Fetching the current date GTM+0 */
NSString *getDateString();

@end
