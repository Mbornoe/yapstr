//
//  SelectPhotoViewController.m
//  yapstr
//
//  Created by Kildahl on 27/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import "PreviewPhotoViewController.h"

@interface SelectPhotoViewController ()

@end

@implementation UIImage (Extras)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
@end

@implementation SelectPhotoViewController

@synthesize imgPicker, img;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)test:(UIButton *)sender {
        [self presentViewController:imgPicker animated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imgPicker = [[UIImagePickerController alloc] init];
	//self.imgPicker.allowsEditing = YES;
	imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage*)picktImg editingInfo:(NSDictionary *)editInfo {
    img = [picktImg imageByScalingAndCroppingForSize:CGSizeMake(640, 920)];
    //preview.image = img;
    //    img = picktImg;
    [self dismissModalViewControllerAnimated:NO];
    
    [self performSegueWithIdentifier:@"SelectPhotoToPreview" sender:self];
    /*
     - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:img {
     //image.image = img;
     NSLog(@"sadasdsadasda");
     [[picker parentViewController] dismissModalViewControllerAnimated:YES];
     */
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //UploadPhotoViewController *upcomingViewController = [segue destinationViewController];
    //[upcomingViewController imageToUploade:img];
 /*
    UploadPhotoViewController *upload = (UploadPhotoViewController*)[segue destinationViewController];
    //    upload.photo = [[UIImage alloc] init];
    upload.photo = img;
    //upload.text = @"jeg har sendt det her";
*/
        if([segue.identifier isEqualToString:@"SelectPhotoToPreview"]){
            PreviewPhotoViewController *vc = (PreviewPhotoViewController *)[segue destinationViewController];
            vc.snappedPhoto=img;
        }
    }

@end
