//
//  AppDelegate.h
//  yapstr
//
//  Created by Morten Bornø Jensen on 14/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    User* myUser;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) User* myUser;

@end
