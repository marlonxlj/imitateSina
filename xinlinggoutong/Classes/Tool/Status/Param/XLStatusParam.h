//
//  XLStatusParam.h
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLStatusParam : NSObject
//参数模型如何设计直接参考文档
/**
 *
 source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *since_id;

@property (nonatomic, copy) NSString *max_id;

@end
