/**
 * @file Facebook.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class hold properties of the user, that has to do with the user's facebookaccount on the mobile client.
 */

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

/** Declaring a FacebookUser object, which contains facebookID, name and birthday. */
@interface FacebookUser : NSObject{
    NSString *facebookID;
    NSString *name;
    NSString *birthday;
}

/** Parameter which is used as a container for the user's Facebook ID. */
@property (strong, nonatomic) NSString *facebookID;

/** Parameter which is used as a container for the user's Facebook name. */
@property (strong, nonatomic) NSString *name;

/** Parameter which is used as a container for the user's Facebook birthday. */
@property (strong, nonatomic) NSString *birthday;


/** Method used to get the user's Facebook ID. Returns facebookID. */
- (NSString*)getFacebookID;

/** Method used to get the user's Facebook name. Returns name. */
- (NSString*)getFacebookName;

/** Method used to get the user's Facebook birthday. Returns birthday. */
- (NSString*)getFacebookBirthday;

@end