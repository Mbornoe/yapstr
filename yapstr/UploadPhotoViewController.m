//
//  UploadPhotoViewController.m
//  yapstr
//
//  Created by Morten Bornø Jensen on 21/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import "UploadPhotoViewController.h"
#import "UploadPhotoViewCell.h"

@interface UploadPhotoViewController ()

@end

@implementation UploadPhotoViewController
@synthesize cameraRoll;



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    return [self.cameraRoll count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"photoCellView";
    
    UploadPhotoViewCell *cell = [self.collectionView
                      dequeueReusableCellWithReuseIdentifier:cellIdentifier
                      forIndexPath:indexPath];
    
    //Foto *currFoto = [self.fotoArray objectAtIndex:indexPath.row];
    // Set the selectedFotoID
    [CoreDataManager sharedInstance].selectedFotoId = ((Foto*)[self.fotoArray objectAtIndex:indexPath.row]).objectID;
    NSURL *u = [NSURL URLWithString:currFoto.f_path];
    [self findImage:u in: cell];
    
    
    return cell;
}

// Get Photo from Asset Library
-(void)findImage:(NSURL*)u in: (FotoCell*) cell
{
    
    __block FotoCell *blockCell = cell;
    //
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            UIImage *largeimage = [UIImage imageWithCGImage:iref];
            //[largeimage retain];
            UIImage *thumbnail = [UIImage imageWithCGImage:iref scale:0.15 orientation:UIImageOrientationUp];
            [blockCell.fotoThumb setImage:thumbnail];
        }
    };
    
    //
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"cant get image - %@",[myerror localizedDescription]);
    };
    
    
    
    NSURL *asseturl = u;
    ALAssetsLibrary* assetslibrary = [[[ALAssetsLibrary alloc] init] autorelease];
    [assetslibrary assetForURL:asseturl
                   resultBlock:resultblock
                  failureBlock:failureblock];
    
}















- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
