//
//  GHBProperty.h
//  GHBExtension
//
//  Created by youziyue on 15/9/21.
//  Copyright © 2015年 Lance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class GHBPropertyType;

/**
 *  这个类包含两个属性、一个是属性的名字、一个是属性的类型信息
 */
@interface GHBProperty : NSObject

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly) GHBPropertyType *type;

+ (instancetype)propertyWithProperty:(objc_property_t)property;

@end
