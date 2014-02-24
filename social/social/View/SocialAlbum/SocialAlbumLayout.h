//
//  SocialAlbumLayout.h
//  social
//
//  Created by zhaoyifeng on 14-2-13.
//  Copyright (c) 2014年 PinGuo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_WIDTH 320
#define GENERAL_CELL_HEIGHT 100
#define FIRST_CELL_HEIGHT 200

@interface SocialAlbumLayout : UICollectionViewFlowLayout
{
    NSInteger cellCount;
    CGPoint preContentOffset;
    int totalIndex;
}

@end
