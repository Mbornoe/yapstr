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

/** Reference to a locationManager object */
//CLLocationManager *locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView.image=self.snappedPhoto;
    /** Start determining location */
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [locationManager startUpdatingLocation];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"PreviewToSelect"]){
        SelectEventViewController *vc = (SelectEventViewController *)[segue destinationViewController];
        vc.image=self.snappedPhoto;
        vc.imageView.image = vc.image;
     //   vc.longitude=self.longitude;
     //   vc.latitude=self.latitude;
        
        /** Stop determining location */
    //    [locationManager stopUpdatingLocation];
    }
}

@end
