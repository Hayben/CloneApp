//
//  GHBSTatus.h
//  GHBExtension
//
//  Created by youziyue on 15/9/21.
//  Copyright © 2015年 Lance. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GHBUser,GHBGirl;

@interface GHBSTatus : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) GHBUser *user;

@property (nonatomic, strong) GHBGirl *girl;

@property (nonatomic, strong) GHBSTatus *retweetedGHBStatus;

@end
