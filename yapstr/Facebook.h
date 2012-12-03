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

@interface FacebookUser : NSObject{
    NSString *facebookID;
    NSString *name;
    NSString *birthday;
}

//Parameters
@property (strong, nonatomic) NSString *facebookID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *birthday;


//Methods
- (NSString*)getFacebookID;
- (NSString*)getFacebookName;
- (NSString*)getFacebookBirthday;

@end