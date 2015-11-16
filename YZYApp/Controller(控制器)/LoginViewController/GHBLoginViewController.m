//
//  GHBLoginViewController.m
//  YZYApp
//
//  Created by 123 on 15/10/9.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "GHBLoginViewController.h"
#import "MomentsViewController.h"

#import "AppDelegate.h"

#import "NSObject+Property.h"
#import "NSObject+GHBKeyValueObject.h"
#import "GHBSTatus.h"
#import "YZYUser.h"

#import "WXApi.h"

#import "Constants.h"
@interface GHBLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation GHBLoginViewController

#pragma mark ---- LoginAction
- (IBAction)loginButtonAction:(UIButton *)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:YZYActiveUser];
    MomentsViewController *MomentsVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MomentsViewController"];
   // UINavigationController *MomentsNVC = [[UINavigationController alloc]initWithRootViewController:MomentsVC];
    [AppDelegate sharedDelegate].window.rootViewController = MomentsVC;
}
- (IBAction)QQLoginAction:(UIButton *)sender {
}
- (IBAction)WeixinLoginAction:(id)sender {
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"mimiss";
    [WXApi sendReq:req];
}
- (IBAction)SinaLoginAction:(id)sender {
}
#pragma mark ---- registerAction
- (IBAction)registerButtonAction:(id)sender {
}
#pragma mark ---- ForgetpasswordAction
- (IBAction)ForgetpasswordButtonAction:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountTextfield.layer.cornerRadius = 5;
    self.passwordTextfield.layer.cornerRadius = 5;
    self.loginButton.layer.cornerRadius = 5;
    [self modelTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];
    
}
- (void)modelTest{
    //1.定义一个字典
    NSDictionary *dict = @{
                           @"text" : @"是啊，今天天气确实不错！",
                           @"user" : @{
                                   @"schoolId" : @"101210222",
                                   @"avatarLURL" : @"lufy.png"
                                   },
                           @"girl" : @{
                                   @"name" : @"Jack",
                                   @"icon" : @"lufy.png"
                                   },
                           @"retweetedGHBStatus" : @{
                                   @"text" : @"今天天气真不错！",
                                   @"user" : @{
                                           @"name" : @"Rose",
                                           @"icon" : @"nami.png"
                                           }
                                   }
                           };
    GHBSTatus *status = [GHBSTatus objectWithValues:dict];
    NSLog(@"学号  %@ 头像 %@",status.user.schoolId,status.user.avatarLURL);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.accountTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
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
