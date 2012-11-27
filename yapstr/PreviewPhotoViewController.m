//
//  PreviewPhotoViewController.m
//  yapstr
//
//  Created by Jonas Markussen on 27/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import "PreviewPhotoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "SelectEventViewController.h"

@interface PreviewPhotoViewController ()

@end

@implementation PreviewPhotoViewController
@synthesize snappedPhoto;
@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView.image=self.snappedPhoto;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"PreviewToSelect"]){
        SelectEventViewController *vc = (SelectEventViewController *)[segue destinationViewController];
        vc.image=self.snappedPhoto;
        vc.imageView.image = vc.image;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
