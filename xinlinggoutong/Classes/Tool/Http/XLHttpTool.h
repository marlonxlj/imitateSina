//
//  XLHttpTool.h
//  xinlinggoutong
//
//  Created by m on 15/12/18.
//  Copyright © 2015年 YourDevloper. All rights reserved.
// 处理网络的请求

#import <Foundation/Foundation.h>
#import "XLUploadParam.h"

@interface XLHttpTool : NSObject


/**
 *  Get请求
 *
 *  @param URLString  请求的基本的URl
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */

+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                     success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;
/**
 *  Post请求
 *
 *  @param URLString  请求的基本的URl
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */

+ (void)Post:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  上传请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Upload:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(XLUploadParam *)uploadParam
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;@end
