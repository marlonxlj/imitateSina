//
//  XLStatusFrame.m
//  xinlinggoutong
//
//  Created by m on 15/12/20.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLStatusFrame.h"
#import "XLStatus.h"
#import "XLUser.h"

@implementation XLStatusFrame

- (void)setStatus:(XLStatus *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = XLScreenW;
    CGFloat toolBarH = 35;
    
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    
    // 计算cell的高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
}


#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    // 头像
    CGFloat imageX = XLStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + XLStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:XLNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + XLStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + XLStatusCellMargin;
    
    CGFloat textW = XLScreenW - 2 * XLStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:XLTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + XLStatusCellMargin;
    
    // 配图
    if (_status.pic_urls.count) {
        CGFloat photosX = XLStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + XLStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + XLStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = XLScreenW;
    
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}


#pragma mark -计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    //获取总列数
    int cols = count == 4? 2 : 3;
    //获取总行数 = （总个数- 1） /总列数 + 1
    int rols = (count - 1) / cols + 1;
    
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * XLStatusCellMargin;
    CGFloat h = rols * photoWH + (cols - 1) * XLStatusCellMargin;
    
    return CGSizeMake(w, h);
}



#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = XLStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retwetName sizeWithFont:XLNameFont];
    _retweetlNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetlNameFrame) + XLStatusCellMargin;
    
    CGFloat textW = XLScreenW - 2 * XLStatusCellMargin;
    // 注意：一定要是转发微博的正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:XLTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + XLStatusCellMargin;
    // 配图
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = XLStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + XLStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + XLStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = XLScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}


#pragma mark --  计算工具条
- (void)setUpToolBarViewFrame
{
    
}


#pragma mark --  计算cell的高度
- (void)setUpCellViewFrame
{
    
}


@end
