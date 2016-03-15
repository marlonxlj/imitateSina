//
//  XLUserTool.m
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLUserTool.h"
#import "XLHttpTool.h"
#import "XLUserParam.h"
#import "XLUserResult.h"

#import "XLAccount.h"
#import "XLAccountTool.h"

#import "MJExtension.h"

#import "XLUser.h"

@implementation XLUserTool

+ (void)unreadWithSuccess:(void (^)(XLUserResult *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    XLUserParam *params = [XLUserParam param];
    params.uid = [XLAccountTool account].uid;
    
    [XLHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params.keyValues success:^(id responseObject) {
        
        //字典转模型
        XLUserResult *result = [XLUserResult objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userInfoWithSuccess:(void (^)(XLUser *))success failure:(void (^)(NSError *))failure
{
    
    //创建参数模型
    XLUserParam *params = [XLUserParam param];
    params.uid = [XLAccountTool account].uid;
    
    //请求当前用户的昵称
    [XLHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:params.keyValues success:^(id responseObject) {
        
        //用户字典转模型
      XLUser *user = [XLUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
