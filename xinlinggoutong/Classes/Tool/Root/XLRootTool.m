//
//  XLRootTool.m
//  xinlinggoutong
//
//  Created by m on 15/12/17.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLRootTool.h"

@implementation XLRootTool

//选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window
{
    //1 获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //2 获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:XLVersionKey];
    
    if ([currentVersion isEqualToString:lastVersion]) {//没有最新的版本号
        //        创建tabBarVc
        XLTabBarController *tabBarVc = [[XLTabBarController alloc] init];
        
        //        设置窗口的根控制器
        window.rootViewController = tabBarVc;
    }else{//没有最新的版本号
        //进入新特性界面
        XLNewFeatureController *vc = [[XLNewFeatureController alloc] init];
        
        window.rootViewController = vc;
        
        //保存当前版本号，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:XLVersionKey];
    }
    
}

@end
