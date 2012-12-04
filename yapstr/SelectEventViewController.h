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

@interface SelectEventViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    IBOutlet UIPickerView* eventPicker;
    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* eventLabel;
    IBOutlet UIButton* showPickerButton;
    IBOutlet UIButton* uploadButton;
    IBOutlet UIActivityIndicatorView *loading;
}
@property UIImageView* imageView;
@property UIImage* image;
@property UIPickerView* eventPicker;
@property UILabel* eventLabel;
@property NSArray* events;
@property IBOutlet UIButton* showPickerButton;
@property IBOutlet UIButton* uploadButton;
@property (retain,strong) Event* event;
@property (strong) IBOutlet UIActivityIndicatorView *loading;
-(IBAction)showEventPicker;
@end
