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
#import "Location.h"
#import "Event.h"


@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

@synthesize privateSwitch;
@synthesize name;
@synthesize description;
@synthesize password;
@synthesize longitude;
@synthesize latitude;
CLLocationManager *locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    password.hidden=YES;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    self.name.delegate=self;
    self.description.delegate=self;
    self.password.delegate=self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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


- (IBAction)create:(id)sender {
    
    Event *newEvent = [[Event alloc] init];
    newEvent.location = [[Location alloc] init];
    
    newEvent.name =[name text];
    newEvent.description = [description text];
    newEvent.password = [password text];
    newEvent.date = getDateString();
    NSLog(@"dateEfer %@", newEvent.date);
    
    if ([privateSwitch isOn]) {
        newEvent.privateOn = @"1";
        
    }
    else{
        newEvent.privateOn = @"0";
        password.hidden=YES;
    }
    newEvent.location.longitude=self.longitude;
    newEvent.location.latitude=self.latitude;
    
    NSLog(@"%@",newEvent.privateOn);
    NSLog(@"%@",newEvent.name);
    NSLog(@"%@",newEvent.date);
    NSLog(@"%@",newEvent.description);
    NSLog(@"%@",newEvent.password);
    
    NSLog(@"%f",newEvent.location.longitude);
    NSLog(@"%f",newEvent.location.latitude);
    NSDictionary *eventDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               newEvent.name, @"name",
                               newEvent.privateOn, @"privateOn",
                               newEvent.date, @"date",
                               newEvent.description, @"description",
                               newEvent.password, @"password",
                               [NSString stringWithFormat:@"%f",newEvent.location.longitude], @"longitude",
                               [NSString stringWithFormat:@"%f",newEvent.location.latitude], @"latitude",
                               nil];
    
    NSData *eventData =[NSJSONSerialization dataWithJSONObject:eventDict options:kNilOptions error:nil];
    
    [locationManager stopUpdatingLocation];
    
    NSLog(@"ER HER HNUp");
    
    
    [NetworkDriver uploadEvent:eventData];
    
    
}

NSString *getDateString(){
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
    
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.longitude =  currentLocation.coordinate.longitude;
        self.latitude =  currentLocation.coordinate.latitude;
        NSLog(@"longitude: %f", self.longitude);
        NSLog(@"latitude: %f", self.latitude);
        
        
    }
}


- (IBAction)checkPrivat:(id)sender {
    
    if ([privateSwitch isOn]) {
        password.hidden=NO;
    }
    else{
        password.hidden=YES;
    }
    
}
@end
