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

    JZRippleButton *button = [[JZRippleButton alloc] init];
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, 90, 90);
    
}

@end
