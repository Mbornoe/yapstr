/**
 * @file  PreviewPhotoViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import "PreviewPhotoViewController.h"


@interface PreviewPhotoViewController ()

@end

@implementation PreviewPhotoViewController
@synthesize snappedPhoto;
@synthesize imageView;
@synthesize longitude;
@synthesize latitude;

/** Reference to a locationManager object */
CLLocationManager *locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView.image=self.snappedPhoto;
    /** Start determining location */
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"PreviewToSelect"]){
        SelectEventViewController *vc = (SelectEventViewController *)[segue destinationViewController];
        vc.image=self.snappedPhoto;
        vc.imageView.image = vc.image;
        vc.longitude=self.longitude;
        vc.latitude=self.latitude;
        
        /** Stop determining location */
        [locationManager stopUpdatingLocation];
    }
}

/** Obtaining location using the CoreLocation framework, error handling */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    if (currentLocation != nil) {
        self.longitude =  currentLocation.coordinate.longitude;
        self.latitude =  currentLocation.coordinate.latitude;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorString = [[NSString alloc] init];
    
    switch (error.code) {
        case kCLErrorLocationUnknown:
            errorString = @"Location unknown";
            break;
            
        case kCLErrorDenied:
            errorString = @"Access denied";
            break;
            
        case kCLErrorNetwork:
            errorString = @"No network coverage";
            break;
            
        case kCLErrorDeferredAccuracyTooLow:
            errorString = @"Accuracy is too low to display";
            break;
            
        default:
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting location"
                                                    message:errorString
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
