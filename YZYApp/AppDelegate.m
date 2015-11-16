//
//  AppDelegate.m
//  YZYApp
//
//  Created by 123 on 15/10/9.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "AppDelegate.h"

#import "GHBLoginViewController.h"
#import "MomentsViewController.h"

//#import "WXApi.h"
//#import "WXApiObject.h"

#import "Constants.h"
#import "UIColor+YZYColor.h"
#import "WMCommon.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)sharedDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self bulidNavgation];
    
    WMCommon *common = [WMCommon getInstance];
    common.screenW = [[UIScreen mainScreen] bounds].size.width;
    common.screenH = [[UIScreen mainScreen] bounds].size.height;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BOOL isFirst = [ud boolForKey:@"isFirst"];
    BOOL isLogin = [ud boolForKey:YZYActiveUser];
    if (!isFirst) {
        [ud setBool:YES forKey:@"isFirst"];
    }else{
        if (isLogin) {
            MomentsViewController *MomentsVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MomentsViewController"];
            self.window.rootViewController = MomentsVC;
        }else{
            GHBLoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil]instantiateViewControllerWithIdentifier:@"GHBLoginViewController"];
            UINavigationController *LoginNaVc = [[UINavigationController alloc]initWithRootViewController:loginVC];
            [AppDelegate sharedDelegate].window.rootViewController = LoginNaVc;
        }
        
    }

    [self aboutWXApiLoginAction];
    return YES;
}
#pragma mark - 创建统一导航
- (void)bulidNavgation{
    [[UINavigationBar appearance]setBarTintColor:[UIColor themeColor]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:YES];
}
#pragma mark - 向微信注册
- (void)aboutWXApiLoginAction{
     //[WXApi registerApp:@"wxe13e46e3350b823c" withDescription:@"youziyue.com"];
}

#pragma mark -重写AppDelegate的handleOpenURL和openURL方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
   //return [WXApi handleOpenURL:url delegate:self];
    return true;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
   // return [WXApi handleOpenURL:url delegate:self];
    return true;
}

//- (void)onReq:(BaseReq *)req{
//    
//}
//- (void)onResp:(BaseResp *)resp{
//    if ([resp isKindOfClass:[PayResp class]]) {
//        
//    }else if ([resp isKindOfClass:[SendAuthResp class]]){
//        SendAuthResp *aresp = (SendAuthResp *)resp;
//        if (aresp.errCode == 0) {
//            NSLog(@"用户同意登录");
//            NSString *code = aresp.code;
//            NSLog(@"code %@ ",code);
//            [self getAccessTokenWithCode:code];
//        }
//    }
//}
//- (void)getAccessTokenWithCode:(NSString *)code{
//    NSString *urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWeiXinAppId,kWeiXinAppSecret,code];
//    NSLog(@"code  %@ ",code);
//    NSURL *url = [NSURL URLWithString:urlString];
//    __weak typeof(self) weak_self = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (data) {
//                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@"数据字典 %@",dict);
//                
//                if ([dict objectForKey:@"errcode"]) {
//                    NSLog(@"错误 %@",[dict objectForKey:@"errcode"]);
//                }else {
//                    [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"access_token"] forKey:kWeiXinAccessToken];
//                    [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"openid"] forKey:kWeiXinOpenId];
//                    [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"refresh_token"] forKey:kWeiXinRefreshToken];
//                    [[NSUserDefaults standardUserDefaults]synchronize];
//                    
//                    [weak_self getUserInfoWithAccessToken:[dict objectForKey:@"access_token"] andOpenId:[dict objectForKey:@"openid"]];
//                }
//            }
//        });
//    });
//    
//    
//}
//- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId{
//    NSString *urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
//    NSURL *url = [NSURL URLWithString:urlString];
//     __weak typeof(self) weak_self = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (data) {
//                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                
//                NSLog(@"用户数据 %@",dict);
//                
//                if ([dict objectForKey:@"errcode"]) {
//                    [weak_self getAccessTokenWithRefreshToken:[[NSUserDefaults standardUserDefaults]objectForKey:kWeiXinRefreshToken]];
//                    return;
//                }
//            }
//        });
//    });
//}
//- (void)getAccessTokenWithRefreshToken:(NSString *)refreshToken {
//    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",kWeiXinAppId,refreshToken];
//    NSURL *url = [NSURL URLWithString:urlString];
//    __weak typeof(self) weak_self = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (data) {
//                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                if ([dict objectForKey:@"errcode"]) {
//                    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kWeiXinAccessToken];
//                    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kWeiXinOpenId];
//                    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kWeiXinRefreshToken];
//                    [[NSUserDefaults standardUserDefaults]synchronize];
//                    
//                } else {
//                    [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"access_token"] forKey:kWeiXinAccessToken];
//                    [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"openid"] forKey:kWeiXinOpenId];
//                    [[NSUserDefaults standardUserDefaults]synchronize];
//                    [weak_self getUserInfoWithAccessToken:[dict objectForKey:@"access_token"] andOpenId:[dict objectForKey:@"openid"]];
//                }
//            }
//        });
//    });
//}
////获取下一个响应者
//- (UIViewController *)viewController {
//    UIResponder *next = [self nextResponder];
//    do {
//        if ([next isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)next;
//        } else {
//            next = [next nextResponder];
//        }
//    } while (next != nil);
//    return nil;
//}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
