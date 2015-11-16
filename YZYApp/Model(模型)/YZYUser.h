//
//  YZYUser.h
//  YZYApp
//
//  Created by 123 on 15/10/10.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZYUser : NSObject

//user id
@property (nonatomic, copy) NSNumber *userId;

//username
@property (nonatomic, copy) NSString *userName;

//signature
@property (nonatomic, copy) NSString *userSign;

//gender
@property (nonatomic, copy) NSString *userGender;

//user_url
//51adfa0f
@property (nonatomic, copy) NSString *userURL;

//user post
///v1/users/51adfa0f/post
@property (nonatomic, copy) NSString *postURL;

//school related
@property (nonatomic, copy) NSString *schoolId;
@property (nonatomic, copy) NSString *schoolName;
@property (nonatomic, copy) NSString *schoolNameEN;
@property (nonatomic, copy) NSString *schoolURL;
@property (nonatomic, copy) NSNumber *chatNum;

//avatar url
///img/profile/2_160.png
@property (nonatomic, copy) NSString *avatarLURL;
@property (nonatomic, copy) NSString *avatarMURL;
@property (nonatomic, copy) NSString *avatarSURL;

//关注，被关注
@property (nonatomic, copy) NSNumber *fansNum;
@property (nonatomic, copy) NSNumber *followingNum;

//发帖数量
@property (nonatomic, copy) NSNumber *itemNum;

//通知数
@property (nonatomic, copy) NSNumber *noticeNum;


//关注的小组，学校
@property (nonatomic, strong) NSMutableArray *KVOGroupList;
@property (nonatomic, strong) NSMutableArray *groupList;
@property (nonatomic, strong) NSMutableArray *schoolList;

@end
