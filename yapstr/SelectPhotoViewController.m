//
//  SelectPhotoViewController.m
//  yapstr
//
//  Created by Kildahl on 27/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import "UploadPhotoViewController.h"

@interface SelectPhotoViewController ()

@end

@implementation SelectPhotoViewController

@synthesize imgPicker, img, preview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)test:(id)sender {
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
    img = picktImg;
    preview.image = img;
//    img = picktImg;
    [self dismissModalViewControllerAnimated:NO];
    
    [self performSegueWithIdentifier:@"updateSegue" sender:self];
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
    
    UploadPhotoViewController *upload = (UploadPhotoViewController*)[segue destinationViewController];
//    upload.photo = [[UIImage alloc] init];
    upload.photo = img;
        upload.text = @"jeg har sendt det her";
}

@end
