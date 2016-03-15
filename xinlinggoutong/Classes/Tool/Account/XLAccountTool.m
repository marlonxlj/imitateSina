//
//  XLAccountTool.m
//  xinlinggoutong
//
//  Created by m on 15/12/17.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLAccountTool.h"
#import "XLAccount.h"
#import "AFNetworking.h"

#import "XLHttpTool.h"
#import "XLAccountParam.h"
#import "MJExtension.h"

@implementation XLAccountTool

static XLAccount *_account;
+ (void)saveAccount:(XLAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:XLAccountFileName];
}


+ (XLAccount *)account
{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:XLAccountFileName];
    }
    
    //判断账号是否过期，如果过期直接返回nil
    if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {//过期
        return nil;
    }
    //过期时间=当前保存时间+有效期
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    XLAccountParam *params = [[XLAccountParam alloc] init];
    params.client_id = XLClient_id;
    params.client_secret = XLClient_secret;
    params.grant_type = @"authorization_code";
    params.code = code;
    params.redirect_uri = XLRedirect_uri;
    
    [XLHttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:params.keyValues success:^(id responseObject) {
        
        //字典转模型
        XLAccount *account = [XLAccount accountWithDict:responseObject];
        
        // 保存账号信息
        [XLAccountTool saveAccount:account];
        
        // 进入主页(进入新特性还是进入tabBar)
        //        [XLRootTool chooseRootViewController:XLKeyWindow];
        if (success) {
            success();
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
//    //发送POST
//    //创建请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"client_id"] = XLClient_id;
//    params[@"client_secret"] = XLClient_secret;
//    params[@"grant_type"] = @"authorization_code";
//    params[@"code"] = code;
//    params[@"redirect_uri"] = XLRedirect_uri;
//    //发送请求
//    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //字典转模型
//        XLAccount *account = [XLAccount accountWithDict:responseObject];
//        
//        // 保存账号信息
//        [XLAccountTool saveAccount:account];
//        
//        // 进入主页(进入新特性还是进入tabBar)
//        //        [XLRootTool chooseRootViewController:XLKeyWindow];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];

}
@end
