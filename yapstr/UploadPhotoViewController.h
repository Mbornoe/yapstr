//
//  UploadPhotoViewController.h
//  yapstr
//
//  Created by Kildahl on 27/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadPhotoViewController : UIViewController <UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *preview;

@property UIImage *photo;
@property NSString *text;
@end
