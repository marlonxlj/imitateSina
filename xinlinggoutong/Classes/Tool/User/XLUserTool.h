//
//  XLUserTool.h
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//  处理用户的业务

#import <Foundation/Foundation.h>

@class XLUserResult, XLUser;
@interface XLUserTool : NSObject

/**
 *  请求用户的未读数
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(XLUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(XLUser *user))success failure:(void(^)(NSError *error))failure;
@end
