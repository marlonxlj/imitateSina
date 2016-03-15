//
//  XLStatusResult.h
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface XLStatusResult : NSObject<MJKeyValue>
/**
 *  用户的微博数(XLstatus)
 */
@property (nonatomic, strong) NSArray *statuses;

/**
 *  用户最近的微博数
 */
@property (nonatomic, assign) int total_number;
@end
