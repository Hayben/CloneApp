//
//  MomentsViewController.m
//  YZYApp
//
//  Created by 123 on 15/10/13.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "MomentsViewController.h"

#import "GHBHomeViewController.h"
#import "LeftMenuViewController.h"
#import "GHBNavigationController.h"
#import "WMCommon.h"

typedef enum state{
    kStateHome,
    kStateMenu
}state;

static const CGFloat viewSlideHorizonRatio = 0.75;
static const CGFloat viewHeightNarrowRatio = 0.80;
static const CGFloat menuStartNarrowRatio  = 0.70;

@interface MomentsViewController ()

@property (assign, nonatomic) state   sta;              // 状态(Home or Menu)
@property (assign, nonatomic) CGFloat distance;         // 距离左边的边距
@property (assign, nonatomic) CGFloat leftDistance;
@property (assign, nonatomic) CGFloat menuCenterXStart; // menu起始中点的X
@property (assign, nonatomic) CGFloat menuCenterXEnd;   // menu缩放结束中点的X
@property (assign, nonatomic) CGFloat panStartX;        // 拖动开始的x值

@property (strong, nonatomic) WMCommon               *common;
@property (strong, nonatomic) GHBHomeViewController   *homeVC;
@property (strong, nonatomic) LeftMenuViewController   *menuVC;
@property (strong, nonatomic) UINavigationController *messageNav;
@property (strong, nonatomic) UIView                 *cover;


@end

@implementation MomentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self BulidInterface];
}
- (void)BulidInterface{
    self.common = [WMCommon getInstance];
    self.sta = kStateHome;
    self.distance = 0;
    
    self.menuCenterXStart = self.common.screenW * menuStartNarrowRatio / 2.0;
    self.menuCenterXEnd = self.view.center.x;
    self.leftDistance = self.common.screenW * viewSlideHorizonRatio;
    
    //设置背景
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Homeback"]];
    bg.frame = [[UIScreen mainScreen] bounds];
    [self.view addSubview:bg];
    
    //设置menu的View
    self.menuVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    //self.menuVC.delegate = self;
    self.menuVC.view.frame = [[UIScreen mainScreen] bounds];
    self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuStartNarrowRatio, menuStartNarrowRatio);
    self.menuVC.view.center = CGPointMake(self.menuCenterXStart, self.menuVC.view.center.y);
    [self.view addSubview:self.menuVC.view];
    
    //设置遮盖
    self.cover = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.cover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.cover];
    
    //设置首页View
    self.messageNav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"GHBNavigationController"];
    self.homeVC =self.messageNav.childViewControllers.firstObject;
    self.homeVC.view.frame = [[UIScreen mainScreen] bounds];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.messageNav.view addGestureRecognizer:pan];
    [self.view addSubview:self.messageNav.view];
   
    
    //设置导航 LeftItemAction
    self.homeVC.navigationItem.leftBarButtonItem.action = @selector(showMenu);
    
    //[self bulidTabBarInterface];
    
}
/**
 *  设置statusbar的状态
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/**
 *  处理拖动事件
 *
 *  @param recognizer
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    // 当滑动水平X大于75时禁止滑动
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.panStartX = [recognizer locationInView:self.view].x;
    }
    if (self.sta == kStateHome && self.panStartX >= 75) {
        return;
    }
    
    CGFloat x = [recognizer translationInView:self.view].x;
    // 禁止在主界面的时候向左滑动
    if (self.sta == kStateHome && x < 0) {
        return;
    }
    
    CGFloat dis = self.distance + x;
    NSLog(@"444444444 %f",self.distance);
    // 当手势停止时执行操作
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (dis >= self.common.screenW * viewSlideHorizonRatio / 2.0) {
            [self showMenu];
        } else {
            [self showHome];
        }
        return;
    }
    
    CGFloat proportion = (viewHeightNarrowRatio - 1) * dis / self.leftDistance + 1;
    if (proportion < viewHeightNarrowRatio || proportion > 1) {
        return;
    }
    self.messageNav.view.center = CGPointMake(self.view.center.x + dis, self.view.center.y);
    self.messageNav.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
     NSLog(@"  中心 %f",self.distance);
    self.cover.alpha = 1 - dis / self.leftDistance;
    
    CGFloat menuProportion = dis * (1 - menuStartNarrowRatio) / self.leftDistance + menuStartNarrowRatio;
    CGFloat menuCenterMove = dis * (self.menuCenterXEnd - self.menuCenterXStart) / self.leftDistance;
    self.menuVC.view.center = CGPointMake(self.menuCenterXStart + menuCenterMove, self.view.center.y);
    self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
    
}


/**
 *  展示侧边栏
 */
- (void)showMenu{
    NSLog(@"展示侧边栏");
    self.distance = self.leftDistance;
    NSLog(@"1111111 %f",self.distance);
    self.sta = kStateMenu;
    [self doSlide:viewHeightNarrowRatio];
}

/**
 *  展示主界面
 */
- (void)showHome {
    self.distance = 0;
    NSLog(@"33333333 %f",self.distance);
    self.sta = kStateHome;
    [self doSlide:1];
}

/**
 *  实施自动滑动
 *
 *  @param proportion 滑动比例
 */
- (void)doSlide:(CGFloat)proportion {
    [UIView animateWithDuration:0.3 animations:^{
        self.messageNav.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y);
        
        self.messageNav.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
        self.cover.alpha = proportion == 1 ? 1 : 0;
        
        CGFloat menuCenterX;
        CGFloat menuProportion;
        if (proportion == 1) {
            menuCenterX = self.menuCenterXStart;
            menuProportion = menuStartNarrowRatio;
        } else {
            menuCenterX = self.menuCenterXEnd;
            menuProportion = 1;
        }
        self.menuVC.view.center = CGPointMake(menuCenterX, self.view.center.y);
        self.menuVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
