//
//  XLStatus.m
//  xinlinggoutong
//
//  Created by m on 15/12/17.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLStatus.h"
#import "XLPhoto.h"

#import "NSDate+MJ.h"

@implementation XLStatus
/**
 *  实现这个方法就会自动把数组中的字典转换对应的模型
 *
 *  @return 
 */
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[XLPhoto class]};
}

- (NSString *)created_at
{
    //Sun Dec 20 22:30:23 +0800 2015
//    NSLog(@"1111==%@", _created_at);
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    
    NSDate *create_at = [fmt dateFromString:_created_at];
#pragma mark-- 时间不显示???? 
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    
//    NSLog(@"2222==%@", _created_at);
    
    if ([create_at isThisYear]) {//是今年
        
        if ([create_at isToday]) {//今天
            
            //计算跟当前时间的差距
         NSDateComponents *cmp = [create_at deltaWithNow];
            
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if([create_at isYesterday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create_at];
        }else{//前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:create_at];
        }
        
    }else{//不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        
        return [fmt stringFromDate:create_at];
    }
    
    return _created_at;
}

- (void)setSource:(NSString *)source
{
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    
    range = [source rangeOfString:@"<"];

    source = [source substringToIndex:range.location];
    
    source = [NSString stringWithFormat:@"来自%@", source];
    
    _source = source;
}

- (void)setRetweeted_status:(XLStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    _retwetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}

@end
