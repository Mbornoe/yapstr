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
#import "NetworkDriver.h"
#import <CoreLocation/CoreLocation.h>
#import "Event.h"


@interface CreateEventViewController : UIViewController <UITextFieldDelegate,CLLocationManagerDelegate>
- (IBAction)checkPrivat:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *privateSwitch;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *description;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *privatLabel;
@property(assign, nonatomic)double longitude;
@property(assign, nonatomic)double latitude;
@property Event* createdEvent;
@property UIImage* image;
- (IBAction)create:(id)sender;

NSString *getDateString();
@end
