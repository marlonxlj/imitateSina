//
//  XLUserParam.h
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
// 用户未读数请求的参数模型

/**
 

 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 uid	true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。
 
 */
#import <Foundation/Foundation.h>
#import "XLBaseParam.h"

@interface XLUserParam : XLBaseParam

/**
 *  当前用户的唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

@end
