/**
 * @file MapViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles presentation and all interaction with the Map.
 */

#import "MapViewController.h"

@interface MapViewController ()
/** Refrence to the selected event on the map. */
@property Event* selectedEvent;

@end

@implementation MapViewController

@synthesize events;
@synthesize mapView;
@synthesize selectedEvent;

/** Initial setup, requesting events from server and setting up delegate for getting location. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    events = [NetworkDriver requestEvents];
    for (Event *event in events) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = event.location.latitude;
        coordinate.longitude = event.location.longitude;
        [event setCoordinate:coordinate];
        [mapView addAnnotation:event];
    }
    mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

/** Initial setup of map view and slideing menu. */
- (void)viewWillAppear:(BOOL)animated {
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}


/** Handles passing the selected event along to the PhotoCollectionViewController when the user selects an event. */
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    selectedEvent = [[Event alloc] init];
    selectedEvent=view.annotation;
    [self performSegueWithIdentifier:@"eventListMapToCollection" sender:self];
    
}

/** Send the selected event along to the PhotoCollectionViewController. */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"eventListMapToCollection"])
    {
        PhotoCollectionViewController *vs = [segue destinationViewController];
        vs.event=selectedEvent;
    }
}

/** Show icons on the map, representing each of the events. */
- (MKAnnotationView *)mapView:(MKMapView *)unused viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"Event";
    if ([annotation isKindOfClass:[Event class]])
    {
        MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil)
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"partyIcon.png"]; //here we use a nice image instead of the default pins
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        else
        {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
}

@end