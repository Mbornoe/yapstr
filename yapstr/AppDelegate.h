/**
 * @file AppDelegate.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import <UIKit/UIKit.h>
#import "User.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>{
    User* myUser;
    Location *myLocation;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) User* myUser;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Location *myLocation;

@end
