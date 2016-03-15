//
//  XLPopMenu.m
//  xinlinggoutong
//
//  Created by m on 15/12/15.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLPopMenu.h"

@implementation XLPopMenu

+ (instancetype)showInRect:(CGRect)rect
{
    XLPopMenu *menu = [[XLPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    [XLKeyWindow addSubview:menu];
    
    return menu;
}

+ (void)hide
{
    for (UIView *popMenu in XLKeyWindow.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
}

//设置内容视图
- (void)setContentView:(UIView *)contentView
{
    //先移除之前内容视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
}
@end
