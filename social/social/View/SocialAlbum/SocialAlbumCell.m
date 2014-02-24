//
//  SocialAlbumLayout.h
//  social
//
//  Created by zhaoyifeng on 14-2-13.
//  Copyright (c) 2014年 PinGuo. All rights reserved.
//

#import "SocialAlbumCell.h"

@implementation SocialAlbumCell
@synthesize textLabel = _textLabel;
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60, frame.size.height)];
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.textLabel];

    }
    
    return self;
}

-(void) dealloc
{
    self.textLabel = nil;
    self.imageView.image = nil;
    self.imageView = nil;
}

@end
