//
//  XLBaseParam.h
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//  基本的参数模型

#import <Foundation/Foundation.h>

@interface XLBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，访问令牌
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;
@end
