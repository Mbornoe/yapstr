/**
 * @file SelectEventViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import <UIKit/UIKit.h>
#import "Event.h"
#import "NetworkDriver.h"
#import "CreateEventViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"

@interface SelectEventViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    IBOutlet UIPickerView* eventPicker;
    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* eventLabel;
    IBOutlet UIButton* showPickerButton;
    IBOutlet UIButton* uploadButton;
    IBOutlet UIActivityIndicatorView *loading;
    AppDelegate *mainDelegate;
}
@property UIImageView* imageView;
@property UIImage* image;
@property UIPickerView* eventPicker;

@property UILabel* eventLabel;

/** Array holding the events recieved from the server. */
@property NSArray* events;

/** Reference to an instance of the event class. */
@property (retain,strong) Event* event;

/** Outlet for loading animation. */
@property (strong) IBOutlet UIActivityIndicatorView *loading;

/** Reference to an instance of the event class. */
@property IBOutlet UIButton* showPickerButton;
@property IBOutlet UIButton* uploadButton;
-(IBAction)showEventPicker;
@end
