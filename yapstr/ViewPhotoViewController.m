/**
 * @file ViewPhotoViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles presentation photos, both photos stored locally on the phone and externally on a server. Photos can furthermore be flagged for deletion.
 */

#import "ViewPhotoViewController.h"

@interface ViewPhotoViewController ()

@end

@implementation ViewPhotoViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) requestPhotosFromCameraRoll
{
    
}
- (void) requestPhotosFromServer
{
    
}
- (void) selectPhotoFromCameraRoll
{
    
}
- (void) showPhoto
{
    
}
- (void) setDeleteFlag
{
    
}

@end
