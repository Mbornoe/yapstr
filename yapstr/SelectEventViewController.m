/**
 * @file SelectEventViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * 
 */

#import "SelectEventViewController.h"


@interface SelectEventViewController ()

@end

@implementation SelectEventViewController
@synthesize events;
@synthesize event;
@synthesize eventPicker;
@synthesize imageView;
@synthesize image;
@synthesize eventLabel;
@synthesize showPickerButton;
@synthesize uploadButton;
@synthesize loading;

- (void)viewDidLoad
{
    [super viewDidLoad];
    eventPicker.hidden=YES;
    loading.hidden=YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
	events = [NetworkDriver regEvents];
    if(event!=nil) {
        eventLabel.text=event.name;
    }
}
-(IBAction)showEventPicker {
    eventPicker.hidden = false;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)unused {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return ([events count]+1);
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(row==[events count]) {
        return @"Create new";
    } else {
        Event *tempEvent = [events objectAtIndex:row];
        return tempEvent.name;
    }
}

/** This method represent the selectEvent() from the design chapter.
 */
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    eventPicker.hidden=TRUE;
    if(row==[events count]) {
        [self performSegueWithIdentifier:@"selectEventToCreate" sender:self];
    } else {
        Event *tempEvent = [events objectAtIndex:row];
        event = tempEvent;
        eventLabel.text = tempEvent.name;
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectEventToCreate"])
    {
        CreateEventViewController *vs = (CreateEventViewController*)[segue destinationViewController];
        vs.image = image;
    }
}
- (IBAction)uploadImage {
    loading.hidden=NO;
    [loading startAnimating];
    imageView.hidden=YES;
    showPickerButton.hidden=YES;
    uploadButton.hidden=YES;
    eventLabel.hidden=YES;
    [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate: [NSDate date]];
    [NetworkDriver uploadPhoto:image withEvent:event];
    [self performSegueWithIdentifier:@"uploadComplete" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
