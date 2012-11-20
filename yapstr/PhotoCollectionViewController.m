//
//  PhotoCollectionViewController.m
//  yapstr
//
//  Created by Jonas Markussen on 15/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "NetworkDriver.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"

@interface PhotoCollectionViewController ()
@end

@implementation PhotoCollectionViewController
@synthesize event;
@synthesize photoList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photoList = [NetworkDriver reqPhotosWithEvent:event];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return photoList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PhotoCell";
    PhotoCollectionViewCell *cvc = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Photo *tempPhoto = [Photo alloc];
    tempPhoto= [photoList objectAtIndex:[indexPath row]];
    NSURL *url = [NSURL URLWithString:tempPhoto.thumpnailPath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    cvc.imageView.image = img;
    return cvc;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
