/**
 * @file SelectPhotoViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import "SelectPhotoViewController.h"

@interface SelectPhotoViewController ()

@end

@implementation SelectPhotoViewController

@synthesize imgPicker, img, firstTime;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!firstTime){
    // Do any additional setup after loading the view.
    imgPicker = [[UIImagePickerController alloc] init];
	//self.imgPicker.allowsEditing = YES;
	imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imgPicker animated:YES completion:nil];
    }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage*)pickedImg editingInfo:(NSDictionary *)editInfo {
    //img = [pickedImg imageByScalingAndCroppingForSize:CGSizeMake(640, 920)];
    img = pickedImg;
    [self dismissModalViewControllerAnimated:NO];
    [self performSegueWithIdentifier:@"SelectPhotoToPreview" sender:self];    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if([segue.identifier isEqualToString:@"SelectPhotoToPreview"])
   {
       PreviewPhotoViewController *vc = (PreviewPhotoViewController *)[segue destinationViewController];
       vc.snappedPhoto=img;
   }
}

@end
