//
//  AppDelegate.m
//  xinlinggoutong
//
//  Created by m on 15/12/12.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "AppDelegate.h"

#import "XLTabBarController.h"
#import "XLOneViewController.h"
#import "XLNewFeatureController.h"
#import "XLOAuthViewController.h"
#import "XLAccountTool.h"
#import "XLRootTool.h"
#import "UIImageView+WebCache.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //根控制器,判断一下有没有制空权,进行授权
    
    if ([XLAccountTool account]) {//已授权
        //选择根控制器
        [XLRootTool chooseRootViewController:self.window];
    }else{// 进行授权
        
        XLOAuthViewController *oauthVc = [[XLOAuthViewController alloc] init];
        
        //显示，就是设置窗口的根控制器
        self.window.rootViewController = oauthVc;

    }
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //1.停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    //2.删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}

//失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [player prepareToPlay];
    player.numberOfLoops = -1;
    [player play];
    _player = player;
}

//程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
   //开启一个后台任务,时间不确定，优先级比较低
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        //当你的后台任务结束的时候调用
        [application endBackgroundTask:ID];
    }];
    
    //如何提高后台任务的优先级，欺骗苹果，我们是后台播放音乐
    
    //但是苹果会检测你的程序当时有没有播放音乐
    
    //微博:在程序将失去焦点的时候播放音乐，0KB.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}



@end
