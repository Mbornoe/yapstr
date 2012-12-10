/**
 * @file  PhotoCollectionViewCell.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The PhotoCollectionViewCell is used for thumbnails in the PhotoCollectionViewController.
 */

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell

/** Reference to the image view, that displays thumbnails. */
@property(weak) IBOutlet UIImageView *imageView;

/** Reference to the ActivityIndicatorView that are used to indicate that the method is currently loading.  */
@property (strong) IBOutlet UIActivityIndicatorView *loading;

@end
