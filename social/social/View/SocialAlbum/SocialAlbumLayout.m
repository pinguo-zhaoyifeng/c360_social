//
//  customLayout.m
//  newCollectionView
//
//  Created by chester on 14-2-20.
//  Copyright (c) 2014年 chester. All rights reserved.
//

#import "SocialAlbumLayout.h"

@implementation SocialAlbumLayout
{
    CGFloat _lastPosition;
    int _direction;
    int _totalIndex;
}

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.itemSize = CGSizeMake(CELL_WIDTH, GENERAL_CELL_HEIGHT);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
      
        _totalIndex = 100000;
        _lastPosition = self.collectionView.contentOffset.y;
    }
    
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    CGFloat screen_y = self.collectionView.contentOffset.y;
    
    for (UICollectionViewLayoutAttributes* attributes in array)
    {
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            CGFloat distance = attributes.frame.origin.y - screen_y; //屏幕顶端和每个CELL顶端的距离
            
            if(distance <= FIRST_CELL_HEIGHT && distance > 0){ //则表示满足这个条件的CELL是当前屏幕上第二个CELL
                
                _totalIndex = _totalIndex + 1;
                attributes.zIndex = _totalIndex;
                
                if(screen_y > 0)
                {
                    attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y-(FIRST_CELL_HEIGHT-distance), attributes.frame.size.width,GENERAL_CELL_HEIGHT+ FIRST_CELL_HEIGHT-distance);
                }
            }
            else if(distance <= 0 && distance > -GENERAL_CELL_HEIGHT)
            {//则表示满足这个条件的CELL是当前屏幕上第一个CELL，将进行缩小操作
                _totalIndex = _totalIndex - 1;
                attributes.zIndex = _totalIndex;
            }
            else
            {
                attributes.zIndex = 0;
            }
        }
    }
    
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
