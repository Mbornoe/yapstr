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
@synthesize longitude;
@synthesize latitude;

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    /** Transmitting the users current location to the server, to allow the server to sortout nearby events */
    Event *locationEvent = [[Event alloc] init];
    locationEvent.location = [[Location alloc] init];
    locationEvent.location.longitude=self.longitude;
    locationEvent.location.latitude=self.latitude;
    
    /** Initial setup of view */
    eventPicker.hidden=YES;
    loading.hidden=YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    
    /** Request list of events from server */
	events = [NetworkDriver regEvents:locationEvent];
    if(event!=nil) {
        eventLabel.text=event.name;
    }
}

/** Event picker appears after the user touches blue arrow */
-(IBAction)showEventPicker {
    eventPicker.hidden = false;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)unused {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return ([events count]+1);
}

/** Monitor which entry in the event picker table has been selected */
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(row==[events count]) {
        return @"Create new";
    } else {
        Event *tempEvent = [events objectAtIndex:row];
        return tempEvent.name;
    }
}

/** This method represent the selectEvent() from the design chapter. */
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

/** Handling Segues to the CreateEventViewController */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectEventToCreate"])
    {
        CreateEventViewController *vs = (CreateEventViewController*)[segue destinationViewController];
        vs.image = image;
    }
}

/** Upload image to the server and assigned the selected event, followed by the uploadComplete segue back to the cameraViewController(InitialSlidingViewController) */
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

@end
