//
//  PhotoCollectionViewCell.m
//  yapstr
//
//  Created by Jonas Markussen on 19/11/12.
//  Copyright (c) 2012 AAU_ITC5. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell
@synthesize loading;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.loading startAnimating];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
