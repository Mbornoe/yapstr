/**
 * @file  PhotoCollectionViewCell.h
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 *
 */

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell
@property(weak) IBOutlet UIImageView *imageView;
@property (strong) IBOutlet UIActivityIndicatorView *loading;
@end
