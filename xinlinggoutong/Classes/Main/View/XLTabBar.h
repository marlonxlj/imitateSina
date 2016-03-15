//
//  XLTabBar.h
//  xinlinggoutong
//
//  Created by m on 15/12/16.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLTabBar;

@protocol XLTabBarDelegate <NSObject>

@optional

- (void)tabBar:(XLTabBar *)tabBar didClickButton:(NSInteger)index;

/**
 *  点击加号的时候调用
 */
- (void)tabBarDidClickPlusButton:(XLTabBar *)tabBar;

@end

@interface XLTabBar : UIView
// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<XLTabBarDelegate> delegate;

@end
