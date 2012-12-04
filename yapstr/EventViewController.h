/**
 * @file EventViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles fetching existing events from the server. The class will be able to present a number of events in the proximity of the user and the photos attached to a single event, when selected from the list of events.
 */

#import <UIKit/UIKit.h>
#import "PhotoCollectionViewController.h"
#import "NetworkDriver.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"


@interface EventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;
}

/** Refernce to a NSArray that held all of the Events.*/
@property (strong) NSArray *events;

/** Reference to a UITableView that contain all of the Events in a table.*/
@property (nonatomic, retain) IBOutlet UITableView *tableView;

/** Reference to the ActivityIndicatorView that are used to indicate that the method is currently loading.  */
@property (strong) IBOutlet UIActivityIndicatorView *loading;


/** This method requests a list of all the Event's on the external server.*/
- (void) requestEventList;

/** Selects which event the user wants to see the contents of. */
- (void) selectEvent;


@end
