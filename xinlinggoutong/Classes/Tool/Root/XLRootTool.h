//
//  XLRootTool.h
//  xinlinggoutong
//
//  Created by m on 15/12/17.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLTabBarController.h"
#import "XLNewFeatureController.h"
#define XLVersionKey @"version"

@interface XLRootTool : NSObject

//选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window;
@end
