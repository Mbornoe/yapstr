/**
 * @file  PreviewPhotoViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

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
