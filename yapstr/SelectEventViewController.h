//
//  SelectEventViewController.h
//  yapstr
//
//  Created by Jonas Markussen on 27/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

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
