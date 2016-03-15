//
//  XLUserResult.h
//  xinlinggoutong
//
//  Created by m on 15/12/19.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 status	int	新微博未读数
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 */
@interface XLUserResult : NSObject
/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;
/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;
/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;
/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;
/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;
/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  消息的总和
 *
 *  @return
 */
- (int)messageCount;

/**
 *  未读数总和
 *
 *  @return <#return value description#>
 */
- (int)totoalCount;
@end
