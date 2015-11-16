//
//  NSObject+GHBKeyValueObject.h
//  GHBExtension
//
//  Created by youziyue on 15/9/22.
//  Copyright © 2015年 Lance. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GHBKeyValue <NSObject>

@optional

/**
 *  用于指定一个数组中元素的类型
 *
 *  @return 返回一个字典，值表示对应的类型
 */

+ (NSDictionary *)objectClassInArray;

+ (NSDictionary *)replacedKeyFromPropertyName;

@end

@interface NSObject (GHBKeyValueObject)<GHBKeyValue>

+ (instancetype)objectWithValues:(id)keyValues;

@end
