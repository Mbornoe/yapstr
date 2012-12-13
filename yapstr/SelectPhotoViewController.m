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

/** Initial setup, requesting photos associated with a specific event from the server. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!firstTime)
    {
    // Do any additional setup after loading the view.
        [self requestPhotosFromCameraRoll];
    }
}

- (void)selectPhoto:(UIImage *)pickedImg
{
    img = pickedImg;
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [self performSegueWithIdentifier:@"SelectPhotoToPreview" sender:self];
}

- (void)requestPhotosFromCameraRoll{
    // Do any additional setup after loading the view.
    imgPicker = [[UIImagePickerController alloc] init];
	imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage*)pickedImg editingInfo:(NSDictionary *)editInfo {
    [self selectPhoto:pickedImg];
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
