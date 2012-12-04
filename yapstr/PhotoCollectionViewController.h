/**
 * @file PhotoCollectionViewController.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The class handles the requests and presentation of the thumbnails list of photos which are defined from an event selected.
 */


#import <UIKit/UIKit.h>
#import "Event.h"
#import "NetworkDriver.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "ViewPhotoViewController.h"


@interface PhotoCollectionViewController : UICollectionViewController {
}
@property (nonatomic,retain) Event *event;
@property (strong) NSArray *photoList;
@property (nonatomic) IBOutlet UICollectionView *collectionView;
- (void)requestPhotosFromServer:(NSIndexPath*)indexPath;
- (UICollectionViewCell *)collectionView:(UICollectionView *)unused cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
