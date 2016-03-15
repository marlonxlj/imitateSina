//
//  XLAccount.h
//  xinlinggoutong
//
//  Created by m on 15/12/17.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *
 "access_token" = "2.00nxqm_G0y9OGM006424dcae0cvfy_";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5789190715;
 */

@interface XLAccount : NSObject <NSCoding>


@property (nonatomic, copy) NSString *access_token;


@property (nonatomic, copy) NSString *expires_in;


@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *remind_in;

@property (nonatomic, copy) NSString *name;

//过期时间
@property (nonatomic, strong) NSData *expires_date;

+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
