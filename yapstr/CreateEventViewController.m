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
        return  [password becomeFirstResponder];
    }
    if (textField==password) {
        return [textField resignFirstResponder];
    }
    return 0;
    
}

- (IBAction)createEvent:(id)sender {
    
    Event *newEvent = [[Event alloc] init];
    newEvent.name =[name text];
    newEvent.description = [description text];
    newEvent.password = [password text];
    //  newEvent.location = [[Location alloc] init];
    //  newEvent.location.x = longitude;
    //  newEvent.location.y = latitude;
    newEvent.date = getDateString();
    NSLog(@"dateEfer %@", newEvent.date);
    
    
    if ([privateSwitch isOn]) {
        newEvent.privateOn = @"1";
    }
    else{
        newEvent.privateOn = @"0";
    }
    
    
    NSLog(@"%@",newEvent.privateOn);
    NSLog(@"%@",newEvent.name);
    NSLog(@"%@",newEvent.date);
    NSLog(@"%@",newEvent.description);
    NSLog(@"%@",newEvent.password);
    
    NSDictionary *eventDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               newEvent.name, @"name",
                               newEvent.privateOn, @"privateOn",
                               newEvent.date, @"date",
                               newEvent.description, @"description",
                               newEvent.password, @"password",
                               nil];
    
    NSData *eventData =[NSJSONSerialization dataWithJSONObject:eventDict options:kNilOptions error:nil];
    [NetworkDriver uploadEvent:eventData];
    
}

NSString *getDateString(){
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"daaaaaate: %@", strDate);
    return strDate;
    
}