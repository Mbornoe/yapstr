/**
 * @file MapViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles user login. This includes validating the user against Facebook and YAPSTR's own user database.
 */

#import "MapViewController.h"
#import "NetworkDriver.h"
#import "Event.h"
#import "PhotoCollectionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface MapViewController ()
@property Event* selectedEvent;
@end
@implementation MapViewController

@synthesize events;
@synthesize mapView;
@synthesize selectedEvent;
- (void)viewDidLoad
{
    [super viewDidLoad];
    events = [NetworkDriver regEvents];
    [self plotEvents];
	// Do any additional setup after loading the view.
}
- (void)plotEvents {
    for (id<MKAnnotation> annotation in mapView.annotations) {
        [mapView removeAnnotation:annotation];
    }
    for (Event *event in events) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = event.location.latitude;
        coordinate.longitude = event.location.longitude;
        [event setCoordinate:coordinate];
        [mapView addAnnotation:event];
    }
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    selectedEvent = [[Event alloc] init];
    selectedEvent=view.annotation;
    [self performSegueWithIdentifier:@"eventListMapToCollection" sender:self];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"eventListMapToCollection"])
    {
        PhotoCollectionViewController *vs = [segue destinationViewController];
        vs.event=selectedEvent;
    }
}
- (MKAnnotationView *)mapView:(MKMapView *)unused viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"Event";
    if ([annotation isKindOfClass:[Event class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"partyIcon.png"];//here we use a nice image instead of the default pins
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)unused didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = mapView.userLocation.coordinate.latitude;
    zoomLocation.longitude= mapView.userLocation.coordinate.longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1300, 1300);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    [super viewWillAppear:animated];
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    //self.view.layer.shadowOpacity = 0.75f;
    //self.view.layer.shadowRadius = 10.0f;
    //self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

