//
//  SocialInterface.m
//  social
//
//  Created by zhaoyifeng on 14-2-12.
//  Copyright (c) 2014年 PinGuo. All rights reserved.
//

#import "SocialInterface.h"
#import "SocialAlbumViewController.h"
#import "SocialHelp.h"

static SocialInterface *sharedSocialInterface = nil;

@implementation SocialInterface

+(SocialInterface*) shareSocialInterface
{
    @synchronized(self)
    {
        if (sharedSocialInterface == nil)
        {
            sharedSocialInterface = [[self alloc] init];
        }
    }

    return sharedSocialInterface;
}

-(id) init
{
    self = [super init];

    if (self)
    {

    }

    return self;
}

-(void) navigationToSocialAlbum:(UIViewController*)viewController
{
    NSAssert(viewController!=nil, @"viewController is nil");

    NSBundle *bundle = [SocialHelp socialLibraryResourcesBundle];
    UIStoryboard *storeStoryboard = [UIStoryboard storyboardWithName:@"SocialAlbumViewController" bundle:bundle];
    SocialAlbumViewController *socialAlbumViewController = [storeStoryboard instantiateViewControllerWithIdentifier:@"SocialAlbumViewController"];

    [viewController.navigationController pushViewController:socialAlbumViewController animated:YES];
}

-(void)dealloc
{

}

@end
