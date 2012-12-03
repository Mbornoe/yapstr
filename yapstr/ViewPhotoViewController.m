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
- (void)viewDidLoad
{
    [super viewDidLoad];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self loadPhoto];
    
}

-(IBAction)swipeRight:(id)sender {
    NSLog(@"swipped right");
    if(currentPic>0) {
        currentPic--;
        NSLog(@"Decremented to: %i", self.currentPic);
        [self loadPhoto];
    }

}

-(IBAction)swipeLeft:(id)sender {
    NSLog(@"swipped left");
    if(currentPic<([photos count]-1)) {
        currentPic++;
        NSLog(@"Icremented to: %i", self.currentPic);
        [self loadPhoto];
    }
}
/** Requests selected pictured from camera roll to be presented
 */
- (void) requestPhotoFromCameraRoll
{
    
}

/** Requests a photo from the server to be presented.
 */
- (void) requestPhotoFromServer
{
    Photo *photo = [photos objectAtIndex:currentPic];
    NSURL *url = [NSURL URLWithString:photo.photoPath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    [self performSelectorOnMainThread:@selector(displayImage:) withObject:img waitUntilDone:NO];
}


- (void) loadPhoto
{
    [self.loading startAnimating];
    imageView.hidden=YES;
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestPhotosFromServer)
                                        object:nil];
    [queue addOperation:operation];
    [self.loading startAnimating];
}

-(void)showPhoto:(UIImage*)img {
    imageView.image = img;
    imageView.hidden=NO;
    [self.loading stopAnimating];
}

- (void) setDeleteFlag
{
    
}

@end
