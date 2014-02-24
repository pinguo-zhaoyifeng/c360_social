//
//  SocialHelp.m
//  social
//
//  Created by zhaoyifeng on 14-2-13.
//  Copyright (c) 2014年 PinGuo. All rights reserved.
//

#import "SocialHelp.h"

@implementation SocialHelp

+ (NSBundle*) socialLibraryResourcesBundle
{
    @try
    {
        static dispatch_once_t onceToken;
        static NSBundle *myLibraryResourcesBundle = nil;

        dispatch_once(&onceToken, ^{
            NSLog(@"[NSBundle mainBundle] : %@", [NSBundle mainBundle]);
            NSURL *URL = [[NSBundle mainBundle] URLForResource:@"SocialResource" withExtension:@"bundle"];
            myLibraryResourcesBundle = [NSBundle bundleWithURL:URL];
        });

        return myLibraryResourcesBundle;
    }
    @catch (NSException *exception) {

    }
    @finally {

    }
    
    return nil;
}

+(UIImage*) socialImageNamed:(NSString*)name
{
    UIImage *imageFromMainBundle = [UIImage imageNamed:name];

    if (imageFromMainBundle)
    {
        return imageFromMainBundle;
    }

    NSString *strPath = [[[SocialHelp socialLibraryResourcesBundle] resourcePath] stringByAppendingPathComponent:name];
    UIImage *imageFromMyLibraryBundle = [UIImage imageWithContentsOfFile:strPath];

    return imageFromMyLibraryBundle;
}

@end
