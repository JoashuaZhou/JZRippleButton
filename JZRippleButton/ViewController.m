//
//  ViewController.m
//  JZRippleButton
//
//  Created by Joshua Zhou on 14/11/4.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "ViewController.h"
#import "JZRippleButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupButton];
}

- (void)setupButton
{
    JZRippleButton *button = [[JZRippleButton alloc] init];
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, 120, 120);
    
    [button setTitle:@"JZRippleButton" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];;
    button.backgroundColor = [UIColor colorWithRed:0/255.0 green:128/255.0 blue:255/255.0 alpha:1.0];
    button.borderWidth = 3.0;
    button.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:button];
}

@end
