//
//  customLayout.m
//  newCollectionView
//
//  Created by chester on 14-2-20.
//  Copyright (c) 2014年 chester. All rights reserved.
//

#import "customLayout.h"

#define CELL_WIDTH 320
#define CELL_HEIGHT 100
#define CELL_CURRHEIGHT 200

#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.3


@implementation customLayout
{
    CGFloat _lastPosition;
    int _direction;
    int _totalIndex;
    bool isFirst;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
        self.collectionView.contentSize = CGSizeMake(320, 32*CELL_HEIGHT+CELL_HEIGHT);
        
        isFirst = YES;
        
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
//    if (isFirst) {
//        isFirst = NO;
//        for (UICollectionViewLayoutAttributes* attributes in array) {
//            NSLog(@"er");
//            if (CGRectIntersectsRect(attributes.frame, visibleRect)){
//                CGFloat distance = attributes.frame.origin.y - screen_y; //屏幕顶端和每个CELL顶端的距离
//                if(distance == 0){
//                    NSLog(@"fffss");
//                    //attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y, 320, 200);
//                }else{
//                    //attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y+100, 320, CELL_HEIGHT);
//                }
//            }
//        }
//        
//        return array;
//    }
    
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            
            CGFloat distance = attributes.frame.origin.y - screen_y; //屏幕顶端和每个CELL顶端的距离
            
            if(distance < CELL_CURRHEIGHT && distance > 0){ //则表示满足这个条件的CELL是当前屏幕上第二个CELL，将进行放大操作
                
                _totalIndex = _totalIndex + 1;
                   attributes.zIndex = _totalIndex;
                
                attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y-(CELL_CURRHEIGHT-distance), attributes.frame.size.width,CELL_HEIGHT+ CELL_CURRHEIGHT-distance);
            }else if(distance <= 0 && distance > -CELL_HEIGHT){//则表示满足这个条件的CELL是当前屏幕上第一个CELL，将进行缩小操作
                
                _totalIndex = _totalIndex - 1;
                    attributes.zIndex = _totalIndex;

                //attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y, attributes.frame.size.width,CELL_CURRHEIGHT+distance);
            }else{
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
