//
//  GLOParallaxTabbedProfileViewController.m
//  GLOParallaxTabbedProfileViewController
//
//  Created by Gabriel Otte on 8/15/15.
//  Copyright © 2015 Gabriel Otte. All rights reserved.
//

#import "GLOParallaxTabbedProfileViewController.h"

@interface GLOParallaxTabbedProfileViewController ()<GLOParallaxTabViewDelegate>

@end

@implementation GLOParallaxTabbedProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLOParallaxTabView *tabView = [[GLOParallaxTabView alloc] init];
    tabView.tabTitles = @[@"Test 1", @"Test 2", @"Test 3", @"Test 4"];
    tabView.backgroundColor = [UIColor purpleColor];
    tabView.delegate = self;
    [self.view addSubview:tabView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabView:(GLOParallaxTabView *)tabView didSelectTab:(UIButton *)button {
    NSLog(@"%@ selected",[button titleForState:UIControlStateNormal]);
}

@end
