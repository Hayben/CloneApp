//
//  GHBNavigationController.m
//  YZYApp
//
//  Created by 123 on 15/10/13.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "GHBNavigationController.h"
#import "WMNavigationInteractiveTransition.h"
@interface GHBNavigationController () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
@property (nonatomic, strong) WMNavigationInteractiveTransition *navT;

@end

@implementation GHBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)featureOne{
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc]init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    _navT = [[WMNavigationInteractiveTransition alloc]initWithViewController:self];
    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
