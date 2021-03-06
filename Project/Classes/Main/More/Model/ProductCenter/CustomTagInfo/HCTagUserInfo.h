//
//  HCTagUserInfo.h
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HCTagUserInfo : NSObject<NSMutableCopying>

///**
// *使用者头像
// */
//@property (nonatomic,strong) NSString *userImageStr;
///**
// *使用者头像
// */
//@property (nonatomic,strong) NSString *userImageUrlStr;

/**
 *姓名
 */
@property (nonatomic,strong) NSString *ObjectXName;
/**
 *性别
 */
@property (nonatomic,strong) NSString *ObjectSex;
/**
 *生日
 */
@property (nonatomic,strong) NSString *ObjectBirthDay;
/**
 *地址
 */
@property (nonatomic,strong)  NSString *ObjectHomeAddress;
/**
 *学校
 */
@property (nonatomic,strong)  NSString *ObjectSchool;
/**
 *身份证号
 */
@property (nonatomic,strong) NSString *ObjectIdNo;
/**
 *职业
 */
@property (nonatomic,strong)  NSString *ObjectCareer;
/**
 *血型
 */
@property (nonatomic,strong)  NSString *BloodType;
/**
 *过敏史
 */
@property (nonatomic,strong) NSString *Allergic;
/**
 *联系人
 */
@property (nonatomic,strong) NSMutableArray *ContactArray;
@end
