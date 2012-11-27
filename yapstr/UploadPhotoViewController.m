//
//  UploadPhotoViewController.m
//  yapstr
//
//  Created by Kildahl on 27/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import "UploadPhotoViewController.h"

@interface UploadPhotoViewController ()

@end

@implementation UploadPhotoViewController

@synthesize preview, photo, text;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"%@",text);
   // preview = [[UIImageView alloc] init];
    [preview setImage:photo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
