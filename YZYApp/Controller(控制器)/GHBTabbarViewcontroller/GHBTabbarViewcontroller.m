//
//  GHBTabbarViewcontroller.m
//  YZYApp
//
//  Created by 123 on 15/10/14.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "GHBTabbarViewcontroller.h"

#import "UIView+Screenshot.h"
#import "UIImage+ImageEffects.h"
#import "FancyTabBar.h"

@interface GHBTabbarViewcontroller ()<FancyTabBarDelegate>

@property (nonatomic,strong) FancyTabBar *fancyTabBar;
@property (nonatomic,strong) UIImageView *backgroundView;

@end

@implementation GHBTabbarViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFancyTabBar];
}

- (void)initFancyTabBar{
    _fancyTabBar = [[FancyTabBar alloc] initWithFrame:self.view.bounds];
    [_fancyTabBar setUpChoices:self choices:@[@"文字",@"图片",@"问答"] withMainButtonImage:[UIImage imageNamed:@"底部按钮"]];
    _fancyTabBar.delegate = self;
    _fancyTabBar.tintColor = [UIColor blackColor];
    [self.view addSubview:_fancyTabBar];
}

- (void)hideFancyBar{
    [UIView animateWithDuration:1.0 animations:^{
        _fancyTabBar.alpha = 0;
    } completion:^(BOOL finished) {
        [_fancyTabBar removeFromSuperview];
    }];
}
- (void)displayFancyBar{
    
    [UIView animateWithDuration:1.0 animations:^{
        _fancyTabBar.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self.view addSubview:_fancyTabBar];
    }];
}

#pragma mark for fancy tab bar effect
#pragma mark - FancyTabBarDelegate
- (void) didCollapse{
    
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if(finished) {
            [_backgroundView removeFromSuperview];
            _backgroundView = nil;
        }
    }];
}

- (void) didExpand{
    if(!_backgroundView){
        _backgroundView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _backgroundView.alpha = 0;
        [self.view addSubview:_backgroundView];
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        _backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha  = 0.8;
    [self.view bringSubviewToFront:_fancyTabBar];
    
}

// PERFORM SEGUES TO NEXT VIEWS BASED ON INDEX PATH
- (void)optionsButton:(UIButton*)optionButton didSelectItem:(int)index{
    NSLog(@"Hello index %d tapped !", index);
    //GALLERY SEGUE
    if (index == 1) {
        
        
    }else if(index == 2){
        
        
    }else if(index == 3){
        
        
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

@end
