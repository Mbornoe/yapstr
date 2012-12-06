/**
 * @file AppDelegate.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize myUser;
@synthesize locationManager;
@synthesize myLocation;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    myUser = [[User alloc] init];
    myLocation = [[Location alloc] init];
    
    /** Start determining location */
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/** Obtaining location using the CoreLocation framework, error handling */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    if (currentLocation != nil) {
        myLocation.longitude =  currentLocation.coordinate.longitude;
        myLocation.latitude =  currentLocation.coordinate.latitude;
       // NSLog(@"my location: %f;%f", myLocation.longitude, myLocation.latitude);
       // NSLog(@"my location: %f;%f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
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
