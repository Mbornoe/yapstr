/**
 * @file EventViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles creation of new events and fetching of existing events from the server. The class will be able to present a number of events in the proximity of the user and the photos attached to a single event, when selected from the list of events.
 */

#import "EventViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController
@synthesize events;
@synthesize tableView;
@synthesize loading;

/** Customize the number of rows in the table view. */
- (NSInteger)tableView:(UITableView *)unused numberOfRowsInSection:(NSInteger)section {
    return [events count];
}

/** Customize the appearance of table view cells. This methods represents the showEventList method from the design. */
- (UITableViewCell *)tableView:(UITableView *)unused cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Event *event = [events objectAtIndex: [indexPath row]];
    cell.textLabel.text = event.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath  *)indexPath {
    [self selectEvent];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"eventListToCollection"])
    {
        NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
        Event *temp = [events objectAtIndex: [indexPath row]];
        PhotoCollectionViewController *vs = [segue destinationViewController];
        vs.event=temp;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self requestEventList];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]])
    {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

/** This method requests a list of all the Event's on the external server.*/
- (void) requestEventList
{
  events = [NetworkDriver regEvents];
}

/** Selects which event the user wants to see the contents of. */
- (void) selectEvent
{
    [self performSegueWithIdentifier:@"eventListToCollection" sender:self];
}


@end
