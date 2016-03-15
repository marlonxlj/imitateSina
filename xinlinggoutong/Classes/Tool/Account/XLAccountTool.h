//
//  XLAccountTool.h
//  xinlinggoutong
//
//  Created by m on 15/12/17.
//  Copyright © 2015年 YourDevloper. All rights reserved.
// 专门处理账号的业务(账号存储和读取)

#import <Foundation/Foundation.h>

@class XLAccount;
@interface XLAccountTool : NSObject

+ (void)saveAccount:(XLAccount *)account;

+ (XLAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;
@end
