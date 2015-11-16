//
//  NSObject+GHBKeyValueObject.m
//  GHBExtension
//
//  Created by youziyue on 15/9/22.
//  Copyright © 2015年 Lance. All rights reserved.
//

#import "NSObject+GHBKeyValueObject.h"

#import "NSObject+Property.h"
#import "GHBProperty.h"
#import "GHBPropertyType.h"

@implementation NSObject (GHBKeyValueObject)
+ (instancetype)objectWithValues:(id)keyValues{
    if (!keyValues) return nil;
    return [[[self alloc]init] setKeyvalues:keyValues];
}

+ (NSString *)propertKey:(NSString *)propertyName{
    NSString *key;
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = [self replacedKeyFromPropertyName][propertyName];
    }
    return key?:propertyName;
}
- (instancetype)setKeyvalues:(id)keyValues{
    keyValues = [keyValues JSONObject];
    NSArray *propertiesArray = [self.class properties];
    
    for (GHBProperty *property in propertiesArray) {
        GHBPropertyType *type = property.type;
        
        Class typeClass = type.typeClass;
        
        id value = [keyValues valueForKey:[self.class propertKey:property.name]];
        
        if (!value) continue;
        
        if (!type.isFromFoundation && typeClass) {
            value = [typeClass objectWithValues:value];
        }else if ([self.class respondsToSelector:@selector(objectClassInArray)]){
            
            id objectClass;
            
            objectClass = [self.class objectClassInArray][property.name];
            
            if ([objectClass isKindOfClass:[NSString class]]) {
                objectClass = NSClassFromString(objectClass);
            }
            if (objectClass) {
                value = [objectClass objectArrayWithKeyValuesArray:value];
            }
        }else if (type.isNumberType){
            NSString *oldValue = value;
            
            if ([value isKindOfClass:[NSString class]]) {
                value = [[[NSNumberFormatter alloc]init] numberFromString:value];
                if (type.isBoolType) {
                    NSString *lower = [oldValue lowercaseString];
                    if ([lower isEqualToString:@"yes"]||[lower isEqualToString:@"true"]) {
                        value = @YES;
                    }else if ([lower isEqualToString:@"no"]||[lower isEqualToString:@"false"]){
                        value = @NO;
                    }
                }
            }
        }else{
            if (typeClass == [NSString class]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    if (type.isNumberType)
                        value = [value description];
                }else if ([value isKindOfClass:[NSURL class]]){
                    value = [value absoluteString];
                }
            }
        }
        [self setValue:value forKey:property.name];
    }
    return self;
}
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray{
    //,对数组里的每一个成员都进行字典转模型的方法.如果其中的成员不是自定义模型类,那么直接返回.
    if ([self isClassFromFoundation:self])
        return keyValuesArray;
    
    // 如果是json字符串,转成字典
    keyValuesArray = [keyValuesArray JSONObject];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    
    // 遍历
    for (NSDictionary *keyValues in keyValuesArray) {
        // 对其中的模型调用字典转模型方法,并添加到数组中返回
        id model;
        model = [self objectWithValues:keyValues];
        if (model) {
            [modelArray addObject:model];
        }
    }
    return modelArray;
}




- (id)JSONObject{
    id foundationObj;
    if ([self isKindOfClass:[NSString class]]) {
        foundationObj = [NSJSONSerialization JSONObjectWithData:[(NSString *)self dataUsingEncoding:NSUTF8StringEncoding]options:kNilOptions error:nil];
    }else if ([self isKindOfClass:[NSData class]]){
        foundationObj = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    return foundationObj?:self;
}
@end

