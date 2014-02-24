//
//  TestViewController.m
//  socialTest
//
//  Created by zhaoyifeng on 14-2-12.
//  Copyright (c) 2014年 PinGuo. All rights reserved.
//

#import "TestViewController.h"
#import "SocialInterface.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction) touchDownBtn:(id)sender
{
    [[SocialInterface shareSocialInterface] navigationToSocialAlbum:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
