//
//  AFHttpTool.h
//  YZYApp
//
//  Created by 123 on 15/10/26.
//  Copyright © 2015年 haibin. All rights reserved.
//  @"http://apitest.youziyue.com"

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};


@interface AFHttpTool : NSObject

/**
 *  发送一个请求
 *
 *  @param methodType   请求方法
 *  @param url          请求路径
 *  @param params       请求参数
 *  @param success      请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure      请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void) requestWihtMethod:(RequestMethodType)methodType
                     url : (NSString *)url
                   params:(NSDictionary *)params
               Authorized:(BOOL)authorized
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *err))failure;

//邮箱注册
+(void) registerWithEmail:(NSString *) email
                 userName:(NSString *) userName
                 password:(NSString *) password
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure;
//手机注册
+(void) registerWithmobilePhone:(NSString *) mobilePhone
                           code:(NSString *)phoneCode
                       userName:(NSString *) userName
                       password:(NSString *) password
                         uccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure;
//手机验证码
+(void)giveAnMessageByPhone:(NSString *)phone;

//login
+(void) loginWithEmail:(NSString *) email
              password:(NSString *) password
               success:(void (^)(id response))success
               failure:(void (^)(NSError* err))failure;

@end
