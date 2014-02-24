//
//  SocialAlbumViewController.h
//  social
//
//  Created by zhaoyifeng on 14-2-12.
//  Copyright (c) 2014年 PinGuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialAlbumViewController : UIViewController<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
{
    IBOutlet UICollectionView *socialAlbumCollectView;
    IBOutlet UIImageView *backViewImage;
}

@end
