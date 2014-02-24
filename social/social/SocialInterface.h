//
//  SocialInterface.h
//  social
//
//  Created by zhaoyifeng on 14-2-12.
//  Copyright (c) 2014年 PinGuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SocialInterface : NSObject
{

}

+(SocialInterface*) shareSocialInterface;

-(void) navigationToSocialAlbum:(UIViewController*)viewController;

@end
