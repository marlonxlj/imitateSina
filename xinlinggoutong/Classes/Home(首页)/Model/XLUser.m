//
//  XLUser.m
//  xinlinggoutong
//
//  Created by m on 15/12/17.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLUser.h"

@implementation XLUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}
@end
