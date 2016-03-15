//
//  XLStatusToolBar.m
//  xinlinggoutong
//
//  Created by m on 15/12/20.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLStatusToolBar.h"
#import "XLStatus.h"

@interface XLStatusToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) NSMutableArray *divideVs;

@property (nonatomic, weak) UIButton *retweet;

@property (nonatomic, weak) UIButton *comment;

@property (nonatomic, weak) UIButton *unlink;

@end

@implementation XLStatusToolBar

- (NSMutableArray *)btns
{
    if (_btns== nil) {
        _btns = [NSMutableArray array];
    }
    
    return _btns;
}

- (NSMutableArray *)divideVs
{
    if (_divideVs== nil) {
        _divideVs = [NSMutableArray array];
    }
    
    return _divideVs;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];

    }
    
    return self;
}

#pragma mark -- 添加所有子控件
- (void)setUpAllChildView
{
    // 转发
    UIButton *retweet =[self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet" ]];
    _retweet = retweet;
    
    //评论
    UIButton *comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    
    //赞
    UIButton *unlink = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlink = unlink;
    
    for (int i = 0; i < 2; i++) {
        UIImageView *dividev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:dividev];
        [self.divideVs addObject:dividev];
    }
    
   
}

- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger count = self.btns.count;
    CGFloat w = XLScreenW / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.btns[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    int i = 1;
    for (UIImageView *divide in self.divideVs) {
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
    }
}

- (void)setStatus:(XLStatus *)status
{
    _status = status;
    
    // 转发数
    [self setBtn:_retweet title:status.reposts_count];
    
    //评论数

    [self setBtn:_comment title:status.comments_count];
    
    //赞数
    [self setBtn:_unlink title:status.attitudes_count];

}

//设置按钮的标题
- (void)setBtn:(UIButton *)btn title:(int)count
{
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fw", floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{ //< 10000
            title = [NSString stringWithFormat:@"%d",count];
        }
        
        //设置转发数
        [btn setTitle:title forState:UIControlStateNormal];
    }

}

@end
