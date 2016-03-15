//
//  XLBaseParam.m
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLBaseParam.h"
#import "XLAccountTool.h"
#import "XLAccount.h"

@implementation XLBaseParam

+ (instancetype)param
{
    XLBaseParam *param = [[self alloc] init];
    
    param.access_token = [XLAccountTool account].access_token;
    
    return param;
}
@end
