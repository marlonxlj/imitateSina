//
//  XLComposeToolBar.h
//  xinlinggoutong
//
//  Created by m on 15/12/22.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLComposeToolBar;
@protocol XLComposeToolBarDelegate <NSObject>

@optional

- (void)composeToolBar:(XLComposeToolBar *)toolBar diddClickBtn:(NSInteger)indexPath;

@end

@interface XLComposeToolBar : UIView

- (void)SetUpButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;


@property (nonatomic, weak) id<XLComposeToolBarDelegate> delegate;

@end
