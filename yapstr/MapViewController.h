/**
 * @file MapViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles all interaction with the Map. 
 */

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NetworkDriver.h"
#import "Event.h"
#import "PhotoCollectionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"

@interface MapViewController : UIViewController <MKMapViewDelegate> {
    AppDelegate *mainDelegate;
}

/** */
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

/** */
@property (assign) NSArray *events;


/** */
- (void)centerOnUser;
@end