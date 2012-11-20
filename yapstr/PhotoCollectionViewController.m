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
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    //self.view.layer.shadowOpacity = 0.75f;
    //self.view.layer.shadowRadius = 10.0f;
    //self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}
@end
