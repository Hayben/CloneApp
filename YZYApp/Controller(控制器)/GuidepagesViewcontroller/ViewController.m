//
//  ViewController.m
//  YZYApp
//
//  Created by 123 on 15/10/9.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "ViewController.h"
#import "GHBLoginViewController.h"
#import "AppDelegate.h"
#define ScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScrollViewImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];
    
}

- (void)createScrollViewImage{
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenSize.width*i, 0, ScreenSize.width, ScreenSize.height)];
        imageView.image = [UIImage imageNamed:@"Homeback"];
       // imageView.backgroundColor = [UIColor redColor];
        
        if (i==4) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(110, 200, 100, 50);
            button.center = self.view.center;
            [button setTitle:@"开始体验" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            //打开用户交互
            imageView.userInteractionEnabled = YES;
        }
        [_scrollView addSubview:imageView];
    }
    //必须要设置滚动区域 (所有并排显示子视图的总大小)
    //5张 并排显示
    _scrollView.contentSize = CGSizeMake(5*ScreenSize.width, 0);
    
    //隐藏滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    //不回弹
    _scrollView.bounces = NO;
}
- (void)btnClick:(UIButton *)btn{
    NSLog(@"cdwbcijdbwcw");
    GHBLoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil]instantiateViewControllerWithIdentifier:@"GHBLoginViewController"];
    UINavigationController *LoginNaVc = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [AppDelegate sharedDelegate].window.rootViewController = LoginNaVc;
   // [self.navigationController pushViewController:loginVC animated:YES];
}
@end
