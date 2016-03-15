//
//  XLStatusTool.h
//  xinlinggoutong
//
//  Created by m on 15/12/18.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//  处理微博数据

#import <Foundation/Foundation.h>

@interface XLStatusTool : NSObject
/**
 *  请求更新的微博数据
 *
 *  @param sinceId  返回比这个更大的微博数据
 *  @param statuses 请求成功的时候回调(statuses(XLstaus模型))
    @failure 请求失败
 */
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;
/**
 * 请求更多旧的微博数据
 *
 *  @param MaxId   返回小于等于这个id的微博数据
 *  @param success 请求成功的时候调用
 *  @param failure 失败的时候调用
 */
+ (void)MoreStatusWithMaxId:(NSString *)MaxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;
@end
