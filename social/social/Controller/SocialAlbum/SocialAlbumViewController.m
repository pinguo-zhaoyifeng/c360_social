//
//  SocialAlbumViewController.m
//  social
//
//  Created by zhaoyifeng on 14-2-12.
//  Copyright (c) 2014年 PinGuo. All rights reserved.
//

#import "SocialAlbumViewController.h"
#import "SocialAlbumCell.h"
#import "SocialAlbumLayout.h"
#import "SocialHelp.h"

#define ALBUM_GENERAL_CELL_IDENTIFIER @"SocialAlbumCell"

@interface SocialAlbumViewController ()
{
    
}

-(void) configCollectView;

@end

@implementation SocialAlbumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self)
    {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //配置相册cell
    [self configCollectView];
}

#pragma mark - 配置CollectView
-(void) configCollectView
{
    [socialAlbumCollectView registerClass:[SocialAlbumCell class] forCellWithReuseIdentifier:ALBUM_GENERAL_CELL_IDENTIFIER];
    SocialAlbumLayout *albumLayout = [[SocialAlbumLayout alloc] init];
    socialAlbumCollectView.collectionViewLayout = albumLayout;

    
}

#pragma mark - UICollectionViewDataSource methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 32;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* SocialAlbumCellIdentifier = ALBUM_GENERAL_CELL_IDENTIFIER;
    SocialAlbumCell* cell = (SocialAlbumCell*)[collectionView dequeueReusableCellWithReuseIdentifier:SocialAlbumCellIdentifier
                                                                                        forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];

    // load the image for this cell
    NSString *imageToLoad = [NSString stringWithFormat:@"%ld_full.JPG", (long)indexPath.row];
    cell.imageView.image = [SocialHelp socialImageNamed:imageToLoad];

    return cell;
}

#pragma mark - UICollectionViewDelegate methods
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
    
    return YES;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return CGSizeMake(CELL_WIDTH, FIRST_CELL_HEIGHT);
    }
    else
    {
        return CGSizeMake(CELL_WIDTH, GENERAL_CELL_HEIGHT);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
