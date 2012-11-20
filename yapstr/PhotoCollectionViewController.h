//
//  PhotoCollectionViewController.h
//  yapstr
//
//  Created by Jonas Markussen on 15/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface PhotoCollectionViewController : UICollectionViewController {
}
@property (nonatomic,retain) Event *event;
@property (strong) NSArray *photoList;
@end
