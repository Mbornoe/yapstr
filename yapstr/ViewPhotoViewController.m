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

@synthesize photos;
@synthesize currentPic;
@synthesize imageView;
@synthesize loading;

/** Initial setup of the ViewPhotoViewContoller. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self loadPhoto];
    
}

/** Reference to a IBAction that is used when the user swipes right. When this is done a new picture will be loaded in the imageview due to decreasement of the integer currentPic. */
-(IBAction)swipeRight:(id)sender {
    NSLog(@"swipped right");
    if(currentPic>0) {
        currentPic--;
        NSLog(@"Decremented to: %i", self.currentPic);
        [self loadPhoto];
    }

}

/** Reference to a IBAction that is used when the user swipes left. When this is done a new picture will be loaded in the imageview due to increasement of the integer currentPic. */
-(IBAction)swipeLeft:(id)sender {
    NSLog(@"swipped left");
    if(currentPic<([photos count]-1)) {
        currentPic++;
        NSLog(@"Incremented to: %i", self.currentPic);
        [self loadPhoto];
    }
}

/** Method that can be used in case the user wants a picture deleted. */
- (IBAction)deleteFlag:(id)sender {
    [NetworkDriver setDeleteFlag:[photos objectAtIndex:currentPic]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                    message:@"Your photo is requested deleted"
                                                   delegate:nil
                                          cancelButtonTitle:@"Okyi dokyi"
                                          otherButtonTitles:nil];
    [alert show];
}

/** Requests selected pictured from camera roll to be presented, unused method, apples imagepicker is used instead. */
- (void) requestPhotoFromCameraRoll
{
    
}

/** Requests a photo from the server to be presented. */
- (void) requestPhotoFromServer{
    Photo *photo = [photos objectAtIndex:currentPic];
    NSURL *url = [NSURL URLWithString:photo.photoPath];
    NSLog(@"%@",url);
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    [self performSelectorOnMainThread:@selector(showPhoto:) withObject:img waitUntilDone:NO];
}

/** Method that requests the photos from server. */
- (void) loadPhoto
{
    [self.loading startAnimating];
    imageView.hidden=YES;
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestPhotoFromServer)
                                        object:nil];
    [queue addOperation:operation];
    [self.loading startAnimating];
}

/** Shows the photo that the user wants to be presented. */
-(void)showPhoto:(UIImage*)img
{
    imageView.image = img;
    imageView.hidden=NO;
    [self.loading stopAnimating];
}

@end
