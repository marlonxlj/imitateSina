//
//  XLStatusResult.m
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLStatusResult.h"
#import "XLStatus.h"

@implementation XLStatusResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[XLStatus class]};
}
@end
