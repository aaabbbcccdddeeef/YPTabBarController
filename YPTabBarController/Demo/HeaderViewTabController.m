//
//  HeaderViewTabController.m
//  YPTabBarController
//
//  Created by 喻平 on 2017/9/25.
//  Copyright © 2017年 YPTabBarController. All rights reserved.
//

#import "HeaderViewTabController.h"
#import "TableViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "WebViewController.h"

@interface HeaderViewTabController ()

@end

@implementation HeaderViewTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];

    self.tabContentView.interceptRightSlideGuetureInFirstPage = YES;
    
    self.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabBar.itemTitleSelectedColor = [UIColor redColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:17];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:22];
    
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = [UIColor redColor];
    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(40, 10, 0, 10) tapSwitchAnimated:NO];
    
    self.yp_tabItem.badgeStyle = YPTabItemBadgeStyleDot;
    
    self.tabContentView.loadViewOfChildContollerWhileAppear = YES;
    
    [self.tabContentView setContentScrollEnabledAndTapSwitchAnimated:NO];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    
    CGFloat bottom = 0;
    if (screenSize.height == 812) {
        bottom += 34;
    }
    if ([self.parentViewController isKindOfClass:[YPTabBarController class]]) {
        bottom += 50;
    }
    
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height -= bottom;
    [self.tabContentView setHeaderView:imageView
                                 style:YPTabHeaderStyleStretch
                          headerHeight:250
                          tabBarHeight:44
                 tabBarStopOnTopHeight:20
                                 frame:frame];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 20, 50, 40);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [self initViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initViewControllers {
    TableViewController *controller1 = [[TableViewController alloc] init];
    controller1.yp_tabItemTitle = @"第一个";
    
    WebViewController *controller2 = [[WebViewController alloc] init];
    controller2.yp_tabItemTitle = @"第二";
    
    TableViewController *controller3 = [[TableViewController alloc] init];
    controller3.yp_tabItemTitle = @"第三个";
    controller3.numberOfRows = 5;
    
    TableViewController *controller4 = [[TableViewController alloc] init];
    controller4.yp_tabItemTitle = @"第四";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, nil];
    
}

- (void)tabContentView:(YPTabContentView *)tabConentView didChangedContentOffsetY:(CGFloat)offsetY {
    NSLog(@"offsetY-->%f", offsetY);
}

- (void)deviceOrientationChange {
    NSLog(@"or-->%d", [UIDevice currentDevice].orientation);
    self.tabContentView.frame = [UIScreen mainScreen].bounds;
}

@end
