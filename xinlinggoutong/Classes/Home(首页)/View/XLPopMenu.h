//
//  XLPopMenu.h
//  xinlinggoutong
//
//  Created by m on 15/12/15.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLPopMenu : UIImageView

/**
 *  显示弹出菜单
 */

+ (instancetype)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+ (void)hide;

//内容视图
@property (nonatomic, weak) UIView *contentView;

@end
