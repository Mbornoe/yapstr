/**
 * @file Facebook.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookUser : NSObject{
    NSString *facebookID;
    NSString *name;
    NSString *birthday;
}

extern NSString *const FacebookDataLoadedNotification;

//Parmetes
@property (strong, nonatomic) NSString *facebookID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *birthday;
@property (nonatomic, assign) BOOL facebookDataLoaded;


//Methods
- (NSString*)getFacebookID;
- (NSString*)getFacebookName;
- (NSString*)getFacebookBirthday;
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
@end