//
//  HCPromisedDetailAPI.h
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCPromisedDetailBlock) (HCRequestStatus requestStatus,NSString *message, NSArray  *infoArr);

@interface HCPromisedDetailAPI : HCRequest

@property(nonatomic,copy)NSNumber  *ObjectId;

- (void)startRequest:(HCPromisedDetailBlock)requestBlock;

@end
