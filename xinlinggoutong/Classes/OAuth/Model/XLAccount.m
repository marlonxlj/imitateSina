//
//  XLAccount.m
//  xinlinggoutong
//
//  Created by m on 15/12/17.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLAccount.h"

#define XLAccountTokenKey @"token"
#define XLUidKey @"uid"
#define XLExpires_inKey @"expires"
#define XLExpires_dateKey @"date"
#define XLNameKey @"name"

#import "MJExtension.h"

@implementation XLAccount

//底层遍历当前的类的所有属性，一个一个归档和解档
MJCodingImplementation

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    XLAccount *account = [[self alloc] init];
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    //计算过期时间＝当前时间+有效期
    
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
    
}

//归档的时候调用，告诉系统哪个属性需要归档，如何归档
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_access_token forKey:XLAccountTokenKey];
//    [aCoder encodeObject:_expires_in forKey:XLExpires_inKey];
//    [aCoder encodeObject:_uid forKey:XLUidKey];
//    [aCoder encodeObject:_expires_date forKey:XLExpires_dateKey];
//    [aCoder encodeObject:_name forKey:XLNameKey];
//}
//解档的时候调用
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        _access_token = [aDecoder decodeObjectForKey:XLAccountTokenKey];
//        _expires_in = [aDecoder decodeObjectForKey:XLExpires_inKey];
//        _uid = [aDecoder decodeObjectForKey:XLUidKey];
//        _expires_date = [aDecoder decodeObjectForKey:XLExpires_dateKey];
//        _name = [aDecoder decodeObjectForKey:XLNameKey];
//    }
//    return self;
//}
@end
