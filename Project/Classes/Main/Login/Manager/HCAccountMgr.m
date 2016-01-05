//
//  HCAccountMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/14.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCAccountMgr.h"
#import "HCAccountDBMgr.h"

static HCAccountMgr *_sharedManager = nil;

@implementation HCAccountMgr

//创建单例
+ (instancetype)manager
{
    if (_sharedManager == nil) {
        _sharedManager = [[HCAccountMgr alloc] init];
    }
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Public Methods

//释放单利，清空账号数据库
- (void)clean
{
    [[HCAccountDBMgr manager] truncateTable];
    _sharedManager = nil;
}

//更新数据库的登录信息
- (void)updateLoginInfoToDB
{
    [[HCAccountDBMgr manager] updateLoginInfo:self.loginInfo];
}

//更新数据库的用户信息
- (void)updateUserInfoToDB
{
//    [[HCAccountDBMgr manager] updateUserInfo:self.userInfo];
}

//保存用户登录信息
- (void)saveLoginInfoToDB
{
    [[HCAccountDBMgr manager] insertLoginInfo:self.loginInfo];
}



- (void)getLoginInfoData
{
    WEAKSELF
    [[HCAccountDBMgr manager] queryLastUserInfo:^(HCLoginInfo *loginInfo) {
        weakSelf.loginInfo = loginInfo;
//        weakSelf.userInfo = userInfo;
        weakSelf.isLogined = YES;
    }];
}

#pragma mark - Setters & Getters

//获取登录信息
//- (HCLoginInfo *)loginInfo
//{
//    if (_loginInfo == nil) {
//
//    }
//    return _loginInfo;
//}


@end
