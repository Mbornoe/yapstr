//
//  SelectPhotoViewController.h
//  yapstr
//
//  Created by Kildahl on 27/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UIImage *img;
	UIImagePickerController *imgPicker;
}

@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (nonatomic, retain) UIImage *img;
@property (strong, nonatomic) IBOutlet UIImageView *preview;

@end
