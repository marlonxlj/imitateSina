//
//  XLStatusTool.m
//  xinlinggoutong
//
//  Created by m on 15/12/18.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLStatusTool.h"
#import "XLHttpTool.h"
#import "XLStatus.h"
#import "XLAccountTool.h"
#import "XLAccount.h"

#import "XLStatusParam.h"
#import "MJExtension.h"
#import "XLStatusResult.h"

@implementation XLStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    XLStatusParam *params = [[XLStatusParam alloc] init];
    params.access_token = [XLAccountTool account].access_token;
    if (sinceId) {//有微博数据才需要下拉刷新
        
        params.since_id = sinceId;
    }
    //创建一个参数字典
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (sinceId) {//有微博数据才需要下拉刷新
//        
//        params[@"since_id"] = sinceId;
//    }
//        params[@"access_token"]= [XLAccountTool account].access_token;
    
    //params.keyValues将模型字典
    [XLHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {
        
        //方法:1.2
//        NSArray *dictArr = responseObject[@"statuses"];
//        NSArray *statuses = (NSMutableArray *)[XLStatus objectArrayWithKeyValuesArray:dictArr];
        
        //请求成功
        XLStatusResult *result = [XLStatusResult objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)MoreStatusWithMaxId:(NSString *)MaxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    XLStatusParam *params = [[XLStatusParam alloc] init];
    params.access_token = [XLAccountTool account].access_token;
    if (MaxId) {//有微博数据才需要下拉刷新
        
        params.max_id = MaxId;
    }
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (MaxId) {//有微博数据才需要下拉刷新
//        
//        params[@"max_id"] = MaxId;
//    }
//    params[@"access_token"]= [XLAccountTool account].access_token;
    
    [XLHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {
        
        //方法:1.2
//        NSArray *dictArr = responseObject[@"statuses"];
//        NSArray *statuses = (NSMutableArray *)[XLStatus objectArrayWithKeyValuesArray:dictArr];
        
        //把结果字典转换成结果模型
        XLStatusResult *relust = [XLStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(relust.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
