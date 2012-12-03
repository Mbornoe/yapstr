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
@synthesize longitude;
@synthesize latitude;
@synthesize image;
@synthesize createdEvent;

/** Reference to a locationManager object */
CLLocationManager *locationManager;

/** Setup of location services and delegates for textfields */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    password.hidden=YES;
    
    /** Start determining location */
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    /** Setup delegates for the textfields */
    self.name.delegate=self;
    self.description.delegate=self;
    self.password.delegate=self;
}

/** The create event view should always be shown in Portrait */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

/** Creating an event using the information collected from user and position data */
- (IBAction)createEvent
{
    Event *newEvent = [[Event alloc] init];
    newEvent.location = [[Location alloc] init];
    newEvent.name =[name text];
    newEvent.description = [description text];
    newEvent.password = [password text];
    newEvent.date = getDateString();
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
    newEvent.location.longitude=self.longitude;
    newEvent.location.latitude=self.latitude;
    
    /** Stop determining location */
    [locationManager stopUpdatingLocation];
    
    /** Send message to network driver, to upload the new event and store the same event plus event id recived from the server*/
    self.createdEvent=[NetworkDriver uploadEvent:newEvent];
    
    /** Preform createdEventToUpload segue to the SelectEventViewController */
    [self performSegueWithIdentifier:@"createdEventToUpload" sender:self];
}

/** Fetching the current date GTM+0 */
NSString *getDateString()
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
}

/** Handling Segues to and from SelectEventViewController */
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
- (IBAction)checkPrivat
{
    if ([privateSwitch isOn])
    {
        password.hidden=NO;
    }
    else
    {
        password.hidden=YES;
    }
}

/** Obtaining location using the CoreLocation framework, error handling */
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

/** Obtaining location using the CoreLocation framework */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.longitude =  currentLocation.coordinate.longitude;
        self.latitude =  currentLocation.coordinate.latitude;
    }
}

@end
