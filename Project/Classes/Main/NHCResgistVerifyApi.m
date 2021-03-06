//
//  NHCResgistVerifyApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//  验证验证码

#import "NHCResgistVerifyApi.h"

@implementation NHCResgistVerifyApi
- (void)startRequest:(HCRegisterVerify)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{   //验证验证码
    return @"User/validateAuthCode.do";
}
- (id)requestArgument
{   //验证验证码

    NSDictionary *head = @{@"UUID":_uuid,
                           @"platForm":[readUserInfo GetPlatForm]};
    NSDictionary *para = @{@"PhoneNumber": _PhoneNumber,
                           @"theCode": _theCode,
                           @"theType": _theType};
    NSDictionary *body = @{@"Para":para,
                           @"Head":head};
    return body;
}
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
