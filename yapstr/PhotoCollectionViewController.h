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

/** Reference to an instance of the event class, needed to reach the photos in the event. */
@property (nonatomic,retain) Event *event;

/** Reference to an array containing all of the photos that is wanted to the event. */
@property (strong) NSArray *photoList;

/** Reference to the UICollectionView that is containing the the thumbnail from all of the photos from the selected Event. */
@property (nonatomic) IBOutlet UICollectionView *collectionView;


/** Requests all the thumbnails photos to a photoList, afterwards they are presented in the cell image view(cvc.imageview). */
- (void)requestPhotosFromServer:(NSIndexPath*)indexPath;

/** All of the thumbnails are collected in a collectionView. */
- (UICollectionViewCell *)collectionView:(UICollectionView *)unused cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
