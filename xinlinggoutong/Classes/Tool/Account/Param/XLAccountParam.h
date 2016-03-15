//
//  XLAccountParam.h
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
@interface XLAccountParam : NSObject

@property (nonatomic, copy) NSString *client_id;

@property (nonatomic, copy) NSString *client_secret;

@property (nonatomic, copy) NSString *grant_type;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *redirect_uri;

@end
