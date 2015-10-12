//
//  ViewController.m
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/10.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import "ViewController.h"
#import <JSBadgeView/JSBadgeView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"首页";
    UILabel *label = [UILabel new];
    [label setFrame:CGRectMake(0, 0, 40, 30)];
    [label setText:@"首页"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    self.navigationItem.titleView = label;
    JSBadgeView *jsBadgeView = [[JSBadgeView alloc] initWithParentView:label alignment:JSBadgeViewAlignmentTopRight];
    jsBadgeView.badgeText = @"3";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
