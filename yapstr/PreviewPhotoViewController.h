//
//  PreviewPhotoViewController.h
//  yapstr
//
//  Created by Jonas Markussen on 27/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewPhotoViewController : UIViewController
@property IBOutlet UIImageView* imageView;
@property (strong) UIImage* snappedPhoto;

@end
