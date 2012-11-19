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
@interface CreateEventViewController : UIViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UISwitch *privateSwitch;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *description;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *privatLabel;

- (IBAction)createEvent:(id)sender;

NSString *getDateString();
@end
