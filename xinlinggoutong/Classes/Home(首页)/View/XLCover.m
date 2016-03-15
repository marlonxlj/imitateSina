//
//  XLCover.m
//  xinlinggoutong
//
//  Created by m on 15/12/15.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLCover.h"

@implementation XLCover

//设置浅灰色的蒙板
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.alpha= 1;
        self.backgroundColor = [UIColor clearColor];
    }
}

//显示蒙板
+ (instancetype)show
{
    XLCover *cover = [[XLCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    [XLKeyWindow addSubview:cover];
    
    return cover;
}

//点击蒙板的时候做事情
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //移除蒙板
    [self removeFromSuperview];
    
    //通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        [_delegate coverDidClickCover:self];
    }
}

@end
