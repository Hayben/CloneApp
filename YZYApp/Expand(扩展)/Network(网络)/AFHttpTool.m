//
//  AFHttpTool.m
//  YZYApp
//
//  Created by 123 on 15/10/26.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "AFHttpTool.h"
#import <AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>
#define FAKE_SERVER @"http://api.youziyue.com"

@implementation AFHttpTool

+ (NSDictionary *)headerDictionary:(NSString *)str {
    //获取名为 accessToken 的本地数据, 转化为字典
    NSDictionary *headerDic = [NSDictionary dictionaryWithObject:str forKey:@"Authorization"];
    return headerDic;
}

+(NSString *)base64:(NSString *)input{
    NSData *tokenData = [input dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [tokenData base64EncodedStringWithOptions:0];
    return base64String;
}

+(NSString *)tokenWithBasicEncyption:(NSString *)input{
    //token with column
    NSString *token = [NSString stringWithFormat:@"%@:",input];
    //"Basic " + base64(token + ":")
    NSString *encpyt = [NSString stringWithFormat:@"Basic %@",[self base64:token]];
    // NSLog(@"encpyt is %@\n", encpyt);
    return encpyt;
}

+(NSString *)GHBMD5:(NSString *)input{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, (int)strlen(cStr), digest);
    NSMutableString *outPut = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [outPut appendFormat:@"%02x",digest[i]];
    }
    return outPut;
}

+ (void)requestWihtMethod:(RequestMethodType)methodType url:(NSString *)url params:(NSDictionary *)params Authorized:(BOOL)authorized success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSURL *baseURL = [NSURL URLWithString:FAKE_SERVER];
    
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    
    if (authorized) {
        [mgr.requestSerializer setValue:@"Cache-Control" forHTTPHeaderField:@"no-cache"];
        NSDictionary *header = [AFHttpTool headerDictionary:[AFHttpTool tokenWithBasicEncyption:@"0eba59092f839bada32dcde9b964b9e2"]];
        for (NSString *key in header.allKeys) {
            [mgr.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    NSMutableSet *types = [NSMutableSet setWithSet:mgr.responseSerializer.acceptableContentTypes];
    [types addObject:@"text/plain"];
    [types addObject:@"text/html"];
    [types addObject:@"application/json"];
    mgr.responseSerializer.acceptableContentTypes = types;
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [mgr GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case RequestMethodTypePost:
        {
            [mgr POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark ---- 邮箱注册
+(void)registerWithEmail:(NSString *)email userName:(NSString *)userName password:(NSString *)password success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *params = @{@"email":email,@"pwd":[self GHBMD5:password],@"username":userName};
    [AFHttpTool requestWihtMethod:RequestMethodTypePost url:@"/v1/guest/signup" params:params Authorized:NO success:success failure:failure];
}

#pragma mark ---- 手机注册
+(void)registerWithmobilePhone:(NSString *)mobilePhone code:(NSString *)phoneCode userName:(NSString *)userName password:(NSString *)password uccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *params = @{@"phone":mobilePhone,@"code":phoneCode,@"pwd":[self GHBMD5:password],@"username":userName};
    [AFHttpTool requestWihtMethod:RequestMethodTypePost url:@"/v1/guest/signupbyphone" params:params Authorized:NO success:success failure:failure];
}
#pragma mark ---- 手机短息
+(void)giveAnMessageByPhone:(NSString *)phone{
    NSString *path = [NSString stringWithFormat:@"http://www.youziyue.com/account/ajax/sendphonecode?phone=%@",phone];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableSet *types = [NSMutableSet setWithSet:mgr.responseSerializer.acceptableContentTypes];
    [types addObject:@"text/plain"];
    [types addObject:@"text/html"];
    [types addObject:@"application/json"];
    mgr.responseSerializer.acceptableContentTypes = types;
    [mgr GET:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"成功 %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"失败 %@",error);
    }];
    
}

#pragma mark ---- 登录
+ (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSDictionary *params = @{@"phone":email,@"pwd":[self GHBMD5:password]};
    [AFHttpTool requestWihtMethod:RequestMethodTypeGet url:@"/v1/guest/logini" params:params Authorized:YES success:success failure:failure];

}



@end
