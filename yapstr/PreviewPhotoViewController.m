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


@interface PreviewPhotoViewController ()

@end

@implementation PreviewPhotoViewController
@synthesize snappedPhoto;
@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
	Photo *photo = [[Photo alloc] init];
    photo.img = self.snappedPhoto;
    self.imageView.image=[photo resizeImg:photo.img];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"PreviewToSelect"]){
        SelectEventViewController *vc = (SelectEventViewController *)[segue destinationViewController];
        /** Copy of image for uploading */
        vc.image=self.imageView.image;
        /** Copy of image for previewing */
        vc.imageView.image = self.imageView.image;
    }
}

@end
