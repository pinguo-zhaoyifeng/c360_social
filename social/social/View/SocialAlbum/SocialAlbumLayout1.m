//
//  SocialAlbumLayout.m
//  social
//
//  Created by zhaoyifeng on 14-2-13.
//  Copyright (c) 2014年 PinGuo. All rights reserved.
//

#import "SocialAlbumLayout.h"

#define FIRST_CELL_HEGHT 176
#define SECOND_CELL_HEGHT 210
#define GENERAL_CELL_HEGHT 80
#define ACTIVE_DISTANCE 128
#define GENERAL_CELL_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define ZOOM_FACTOR 1.0f

@implementation SocialAlbumLayout

- (id)init
{
    self = [super init];

    if (self)
    {
        self.itemSize = CGSizeMake(GENERAL_CELL_WIDTH, GENERAL_CELL_HEGHT);
        self.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 0.0f;
        self.minimumInteritemSpacing = 0.0f;
        cellAttributesInfo = [[NSMutableArray alloc] init];
        totalIndex = 1;
        bFirst = NO;
    }

    return self;
}

-(void)prepareCellAttributes
{
    cellCount = [self.collectionView numberOfItemsInSection:0];

    //没有就初始化
    if ([cellAttributesInfo count] <= 0)
    {
        for (int i=0; i<cellCount; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

            if (indexPath != nil)
            {
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

                if (0 == indexPath.row)
                {
                    attributes.frame = CGRectMake(0, 0, GENERAL_CELL_WIDTH, FIRST_CELL_HEGHT);
                    attributes.center = CGPointMake(GENERAL_CELL_WIDTH*0.5, self.collectionView.contentOffset.y+FIRST_CELL_HEGHT*0.5);
                }
                else
                {
                    attributes.frame = CGRectMake(0, 0, GENERAL_CELL_WIDTH, GENERAL_CELL_HEGHT);
                    attributes.center = CGPointMake(GENERAL_CELL_WIDTH*0.5, self.collectionView.contentOffset.y+FIRST_CELL_HEGHT+indexPath.row*GENERAL_CELL_HEGHT-GENERAL_CELL_HEGHT*0.5);
                }
                
                [cellAttributesInfo addObject:attributes];
            }
        }
    }
}

-(void)prepareLayout
{
    [super prepareLayout];
    // there's a slight but important difference when setting these params here rather than using init. this method gets called EVERY TIME the
    // layout is invalidated, so it could get called any number of times. putting this code in init only runs it when we create the instance
    [self prepareCellAttributes];
}

-(CGSize)collectionViewContentSize
{
    CGSize size = CGSizeMake([self collectionView].frame.size.width, 0);
    size.height = cellCount*self.itemSize.height+(FIRST_CELL_HEGHT-GENERAL_CELL_HEGHT);

    return size;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(UICollectionViewLayoutAttributes *) getAttributesByRow:(int)row
{
    if (row<0 || row>=cellAttributesInfo.count)
    {
        return nil;
    }

    UICollectionViewLayoutAttributes *attributes = nil;
    attributes = [cellAttributesInfo objectAtIndex:row];

    return attributes;
}

-(NSArray *)getVisibleAttributes:(CGRect)rect
{
    NSMutableArray *attributesRetArray = [[NSMutableArray alloc] init];

    for (UICollectionViewLayoutAttributes* attributes in cellAttributesInfo)
    {
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            [attributesRetArray addObject:attributes];
        }
    }

    return attributesRetArray;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
 //   NSArray *attributesArray = [self getVisibleAttributes:rect];
    CGRect visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    CGFloat slideYDistance = 0;
    UICollectionViewLayoutAttributes* attributesTopCell = nil;

    for (UICollectionViewLayoutAttributes* attributes in attributesArray)
    {
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            slideYDistance = attributes.frame.origin.y-visibleRect.origin.y;
            
            if (slideYDistance<=0 && ABS(slideYDistance)<FIRST_CELL_HEGHT)
            {
                float newTopCellHeight = FIRST_CELL_HEGHT+slideYDistance;
                attributes.frame = CGRectMake(0, attributes.frame.origin.y, attributes.frame.size.width, newTopCellHeight);
                attributes.zIndex = --totalIndex;
                attributesTopCell = attributes;
            }
            else if (slideYDistance>0 && slideYDistance<=FIRST_CELL_HEGHT)
            {
                CGFloat offsetY = FIRST_CELL_HEGHT - slideYDistance;
                float nextCellNewOriginY = attributes.frame.origin.y-offsetY;
                
                float nextCellNewHeight = attributes.frame.size.height+offsetY;
                attributes.frame = CGRectMake(0, nextCellNewOriginY, attributes.frame.size.width, nextCellNewHeight);
                attributes.zIndex = ++totalIndex;
            }
            else
            {
            }
        }
    }

    return attributesArray;
}
/*
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat verticalFirst = proposedContentOffset.y + FIRST_CELL_HEGHT*0.5;
    CGRect targetRect = CGRectMake(0, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* attribsArray = [super layoutAttributesForElementsInRect:targetRect];

    for (UICollectionViewLayoutAttributes* layoutAttributes in attribsArray)
    {
        CGFloat itemVerticalCenter = layoutAttributes.center.y;

        if (ABS(itemVerticalCenter - verticalFirst) < ABS(offsetAdjustment))
        {
            offsetAdjustment = itemVerticalCenter - verticalFirst;
        }
    }

    return CGPointMake(proposedContentOffset.x, proposedContentOffset.y+offsetAdjustment);
}
 */

-(void) dealloc
{
    cellAttributesInfo = nil;
}

@end

