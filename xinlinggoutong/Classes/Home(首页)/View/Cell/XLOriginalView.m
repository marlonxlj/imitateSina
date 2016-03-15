//
//  XLOriginalView.m
//  xinlinggoutong
//
//  Created by m on 15/12/20.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLOriginalView.h"
#import "XLStatusFrame.h"
#import "XLStatus.h"
#import "XLPhotosView.h"

#import "UIImageView+WebCache.h"


@interface XLOriginalView ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *nameView;

@property (nonatomic, weak) UIImageView *vipView;

@property (nonatomic, weak) UILabel *timeView;

@property (nonatomic, weak) UILabel *sourceView;

@property (nonatomic, weak) UILabel *textView;

//配图
@property (nonatomic, weak) XLPhotosView *photosView;

@end

@implementation XLOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    
    return self;
}

#pragma mark -- 添加所有子控件
- (void)setUpAllChildView
{
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    //昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = XLNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    //VIP
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    //时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = XLTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    //来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = XLSourceFont;
    sourceView.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    //正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = XLTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    //配图
    XLPhotosView *photosView = [[XLPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

- (void)setStatusF:(XLStatusFrame *)statusF
{
    _statusF = statusF;
    
    //设置frame
    [self setUpFrame];
    
    //设置data
    [self setUpData];
    
}

- (void)setUpData
{
    XLStatus *status = _statusF.status;
    //头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
        
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    
    //vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    _vipView.image = image;
    
    //时间
    _timeView.text = status.created_at;
    
    //来源
    _sourceView.text = status.source;
    
    //正文
    _textView.text = status.text;
    
#warning TODO:配图数据
    //配图
    _photosView.pic_urls = status.pic_urls;
    

}

- (void)setUpFrame
{
    XLStatus *status = _statusF.status;
    // 头像
    _iconView.frame = _statusF.originalIconFrame;
    
    //昵称
    _nameView.frame = _statusF.originalNameFrame;
    
    if (_statusF.status.user.vip) {//是vip
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
    
    //时间 每次有新时间的时候都需要计算时间frame
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + XLStatusCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:XLTimeFont];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
//    _timeView.frame = _statusF.originalTimeFrame;
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + XLStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:XLSourceFont];
    _sourceView.frame = (CGRect){{sourceX, sourceY}, sourceSize};
//    _sourceView.frame = _statusF.originalSourceFrame;
    
    //正文
    _textView.frame = _statusF.originalTextFrame;
    
    //配图
    _photosView.frame = _statusF.originalPhotosFrame;

}

@end
