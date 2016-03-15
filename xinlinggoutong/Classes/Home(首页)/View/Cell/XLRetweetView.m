//
//  XLRetweetView.m
//  xinlinggoutong
//
//  Created by m on 15/12/20.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLRetweetView.h"
#import "XLStatus.h"
#import "XLStatusFrame.h"
#import "XLPhotosView.h"

@interface XLRetweetView ()

@property (nonatomic, weak) UILabel *nameView;

@property (nonatomic, weak) UILabel *textView;

//配图
@property (nonatomic, weak) XLPhotosView *photosView;

@end

@implementation XLRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    
    return self;
}

#pragma mark -- 添加所有子控件
- (void)setUpAllChildView
{
    
    //昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = XLNameFont;
    nameView.textColor = [UIColor blueColor];
    [self addSubview:nameView];
    _nameView = nameView;

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
    
    XLStatus *status = statusF.status;
    //昵称
    _nameView.frame = statusF.retweetlNameFrame;
    _nameView.text = status.retwetName;
    
    //正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
    
    //配图
    _photosView.frame = statusF.retweetPhotosFrame;
    _photosView.pic_urls = status.retweeted_status.pic_urls;
    
    
}

@end
