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

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    User* myUser;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) User* myUser;

@end
