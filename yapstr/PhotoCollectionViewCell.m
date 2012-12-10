/**
 * @file  PhotoCollectionViewCell.m
 * @author ITC5 Group 550
 * @date Fall 2012
 * @version 1.0
 *
 *
 * @section DESCRIPTION
 *
 * The PhotoCollectionViewCell is used for thumbnails in the PhotoCollectionViewController.
 */

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell
@synthesize loading;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.loading startAnimating];
    }
    return self;
}

@end
