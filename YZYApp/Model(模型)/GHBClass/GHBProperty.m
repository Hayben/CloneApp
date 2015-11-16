//
//  GHBProperty.m
//  GHBExtension
//
//  Created by youziyue on 15/9/21.
//  Copyright © 2015年 Lance. All rights reserved.
//

#import "GHBProperty.h"
#import "GHBPropertyType.h"
@implementation GHBProperty

+ (instancetype)propertyWithProperty:(objc_property_t)property{
    return [[GHBProperty alloc]initWithProperty:property];
}
- (instancetype)initWithProperty:(objc_property_t)property{
    if (self = [super init]) {
        _name = @(property_getName(property));
        
        _type = [GHBPropertyType propertyTypeWithAttributeString:@(property_getAttributes(property))];
    }
    return self;
}
@end
