//
//  XLCover.h
//  xinlinggoutong
//
//  Created by m on 15/12/15.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <UIKit/UIKit.h>
//代理什么时候调用，一般自定义控件的时候都用代理
//为什么？因为一个控件以后可能要扩充新的功能，为了程序的可扩充性一般都用代理

@class XLCover;
@protocol XLCoverDelegate <NSObject>
//点击蒙板的时候调用
- (void)coverDidClickCover:(XLCover *)cover;

@end

@interface XLCover : UIView
/**
 *  显示蒙板
 */
+ (instancetype)show;

//设置浅灰色蒙板
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id<XLCoverDelegate> delegate;

@end
