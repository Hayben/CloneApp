//
//  GHBPropertyType.m
//  GHBExtension
//
//  Created by youziyue on 15/9/21.
//  Copyright © 2015年 Lance. All rights reserved.
//

#import "GHBPropertyType.h"
#import "GHBExtensionConst.h"
#import "GHBProperty.h"
#import "NSObject+Property.h"


@implementation GHBPropertyType
/**
 *  用于缓存一些常用类型的type，避免多次调用
 */
static NSMutableDictionary *cachedTypes_;
+ (void)load{
    cachedTypes_ = [NSMutableDictionary dictionary];
}
- (instancetype)initWithTypeString:(NSString *)string{
    NSUInteger loc = 1;
    NSUInteger len = [string rangeOfString:@","].location - loc;
    NSString *typeCode = [string substringWithRange:NSMakeRange(loc,len)];
    
    if (!cachedTypes_[typeCode]) {
        self =[super init];
        [self getTypeCode:typeCode];
        cachedTypes_[typeCode] = self;
    }
    return self;
    
}
- (void)getTypeCode:(NSString *)code{
    if ([code isEqualToString:MJPropertyTypeId]) {
        _idType = YES;
    }else if (code.length > 3 && [code hasPrefix:@"@\""]){
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
        _numberType = (_typeClass == [NSNumber class]||[_typeClass isSubclassOfClass:[NSNumber class]]);
        _fromFoundation = [NSObject isClassFromFoundation:_typeClass];
    }
    NSString *lowerCode = code.lowercaseString;
    NSArray *numberTypes = @[MJPropertyTypeInt,MJPropertyTypeShort,MJPropertyTypeBOOL1,MJPropertyTypeBOOL2,MJPropertyTypeFloat,MJPropertyTypeDouble,MJPropertyTypeLong,MJPropertyTypeChar];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        
        if ([lowerCode isEqualToString:MJPropertyTypeBOOL1]||[lowerCode isEqualToString:MJPropertyTypeBOOL2]) {
            _boolType = YES;
        }
    }
}
+(instancetype)propertyTypeWithAttributeString:(NSString *)string{
    return [[GHBPropertyType alloc]initWithTypeString:string];
}

@end
