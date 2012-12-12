/**
 * @file PhotoCollectionViewController.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles the requests and presentation of the thumbnails list of photos which are defined from an event selected.
 */

#import "PhotoCollectionViewController.h"

@interface PhotoCollectionViewController ()
@end

@implementation PhotoCollectionViewController
@synthesize event;
@synthesize photoList;
@synthesize collectionView;

/** Initial setup, requesting photos associated with a specific event from the server. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photoList = [NetworkDriver requestPhotosFromServer:event];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return photoList.count;
}

/** The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath: **/
- (UICollectionViewCell *)collectionView:(UICollectionView *)unused cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PhotoCell";
    PhotoCollectionViewCell *cvc = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cvc.loading startAnimating];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestPhotosFromServer:)
                                        object:indexPath];
    [queue addOperation:operation];
    cvc.imageView.contentMode=UIViewContentModeScaleToFill;
    return cvc;
}

/** Requests all the thumbnails photos to a photoList, afterwards they are presented in the cell image view(cvc.imageview).
 */
- (void)requestPhotosFromServer:(NSIndexPath*)indexPath {
    Photo *tempPhoto = [Photo alloc];
    tempPhoto= [photoList objectAtIndex:[indexPath row]];
    NSURL *url = [NSURL URLWithString:tempPhoto.thumpnailPath];
    
    UIImage *img = [NetworkDriver requestPhoto:url];
    
    PhotoCollectionViewCell *cvc = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cvc.imageView.image = img;
    cvc.contentMode = UIViewContentModeScaleToFill;
    cvc.imageView.contentMode = UIViewContentModeScaleToFill;
    [cvc.loading stopAnimating];
    cvc.loading.hidden=YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"collectionToPhoto"]){
        PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        ViewPhotoViewController *vc = (ViewPhotoViewController *)[segue destinationViewController];
        vc.photos=photoList;
        vc.currentPic = [indexPath row];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}
@end
