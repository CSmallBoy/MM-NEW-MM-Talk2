//
//  HCAppMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/15.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCAppMgr.h"
#import "AppDelegate.h"
#import "HCLogoutApi.h"
#import "HCAccountDBMgr.h"
#import "UIAlertView+HTBlock.h"
#import "HCGetUserInfoByDeviceApi.h"

static HCAppMgr *_sharedManager = nil;

@implementation HCAppMgr

//创建单例
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HCAppMgr alloc] init];
    });
    
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
    
        //token失效
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginTokenInvalided)
                                                     name:kHCAccessTokenExpiredNotification
                                                   object:nil];
        //下线通知
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(accountKickedOffTheLine)
//                                                     name:kHCNotificationOffline
//                                                   object:nil];
    }
    return self;
}

+ (void)clean
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _sharedManager = nil;
}


#pragma mark - Setters & Getters

/**
 *  是否首次启动程序，启动加载页
 *
 *  @return
 */
- (BOOL)showInstroView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long long flag = [[defaults objectForKey:@"GUIDE"] longLongValue];
    
    if (flag == 0) //首次运行，加载引导页
    {
        [defaults setObject:@(++flag) forKey:@"GUIDE"];
        [defaults synchronize];
        
        return YES;
    }
    return NO;
}

#pragma mark - Public Methods

//登录
- (void)login
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setupRootViewController];
}

//注销
- (void)logout
{
    //想服务端发送注销请求
    [self requestLogout];
    
    [[HCAccountMgr manager] clean];
}

/**
 *  token失效，提醒用户重新登录
 */
- (void)loginTokenInvalided
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"您的登录会话已失效，请重新登录。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alert handlerClickedButton:^(UIAlertView *alert, NSInteger index){
        //清空数据，返回登录
        [[HCAccountMgr manager] clean];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app setupRootViewController];
    }];
    
    [alert show];
}

/**
 *  登出
// */
- (void)requestLogout
{
    HCLogoutApi *api = [[HCLogoutApi alloc] init];
    [api startRequest:nil];
}


@end