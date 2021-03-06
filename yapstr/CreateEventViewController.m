/**
 * @file CreateEventViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles creation of new events.
 */

#import "CreateEventViewController.h"

@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

/** The compiler to create getter/setters for the following properties */
@synthesize privateSwitch;
@synthesize name;
@synthesize description;
@synthesize password;
@synthesize image;
@synthesize createdEvent;

/** Setup of location services and delegates for textfields */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    password.hidden=YES;
    
    mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    /** Setup delegates for the textfields */
    self.name.delegate=self;
    self.description.delegate=self;
    self.password.delegate=self;
}

/** Hiding keyboard when the user resignes it */
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField==name){
        return  [description becomeFirstResponder];
    }
    if(textField==description){
        if ([privateSwitch isOn]) {
            return  [password becomeFirstResponder];
        }
        else{
            return [textField resignFirstResponder];
        }
    }
    if (textField==password) {
        return [textField resignFirstResponder];
    }
    return 0;
}

/** Creating an event using the information collected from user and location data */
- (IBAction)uploadEvent
{
    //Getting the date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    //Generating the event!
    Event *newEvent = [[Event alloc] init];
    newEvent.location = [[Location alloc] init];
    newEvent.name =[name text];
    newEvent.description = [description text];
    newEvent.password = [password text];
    newEvent.date = strDate;
    if ([privateSwitch isOn])
    {
        newEvent.privateOn = @"1";
        password.hidden=NO;
    }
    else
    {
        newEvent.privateOn = @"0";
        password.hidden=YES;
    }
    newEvent.location.longitude = mainDelegate.myLocation.longitude;
    newEvent.location.latitude = mainDelegate.myLocation.latitude;
    
    /** Send message to network driver, to upload the new event and store the same event plus event id received from the server*/
    self.createdEvent=[NetworkDriver uploadEvent:newEvent];
    
    /** Preform createdEventToUpload segue to the SelectEventViewController */
    [self performSegueWithIdentifier:@"createdEventToUpload" sender:self];
}

/** Handling Segues back to SelectEventViewController */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"backFromCreateEvent"])
    {
        SelectEventViewController *vc = (SelectEventViewController*)[segue destinationViewController];
        vc.image = image;
    }
    if([[segue identifier] isEqualToString:@"createdEventToUpload"])
    {
        SelectEventViewController *vc = (SelectEventViewController*)[segue destinationViewController];
        vc.image = image;
        vc.event=self.createdEvent;
    }
}

/** Handling of the private/public switch */
- (IBAction)checkPrivat {
    if ([privateSwitch isOn]) {
        password.hidden=NO;
    } else {
        password.hidden=YES;
    }
}
@end
