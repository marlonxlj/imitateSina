//
//  XLTabBarController.m
//  xinlinggoutong
//
//  Created by m on 15/12/13.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLTabBarController.h"
#import "UIImage+XLImage.h"
#import "XLTabBar.h"

#import "XLHomeViewController.h"
#import "XLMessageViewController.h"
#import "XLDiscoverViewController.h"
#import "XLProfileViewController.h"

#import "XLNavigationController.h"

#import "XLUserTool.h"
#import "XLUserResult.h"

#import "XLComposeViewController.h"

@interface XLTabBarController ()<XLTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) XLHomeViewController *home;

@property (nonatomic, weak) XLMessageViewController *message;

@property (nonatomic, weak) XLProfileViewController *profile;

@end

@implementation XLTabBarController

/**
 *  什么时候调用:程序一启动的时候就会把所有的类加载进内存
 *  作用:加载类的时候调用
 */

//+ (void)load
//{
//
//}

/**
 *  什么时候调用:当第一次使用这个类或者子类的时候调用
 *  作用:初始化类
 */

- (NSMutableArray *)items
{
    if (_items== nil) {
        _items = [NSMutableArray array];
    }
    
    return _items;
}

//+ (void)initialize
//{
//    //获取所有的tabBarItem外观标识
////    UITabBarItem *item = [UITabBarItem appearance];
//    //获取当前这个类下面的所有tabBarItem
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];//方法1
//    // 方法2    [dic setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//        [item setTitleTextAttributes:dic forState:UIControlStateSelected];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有子控制器
    [self setUpAllChildViewController];
    
    //自定义tabBar
    [self setUpTabBar];
    
    //每隔一段时间请求未读数 5秒刷新
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
}


//请求未读数
- (void)requestUnread
{
    //请求微博的未读数
    [XLUserTool unreadWithSuccess:^(XLUserResult *result) {
        
        //设置首页的未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        //设置消息的未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        
        //设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        //设置应用程序的所有未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
    XLTabBar *tabBar = [[XLTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    tabBar.delegate = self;
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    [self.tabBar addSubview:tabBar];
    
//    [self.tabBar removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //移除系统自带的tarbBar
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}
#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(XLTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) {// 点击首页
        [_home refresh];
    }
    self.selectedIndex = index;
}
//点击加号的时候调用
- (void)tabBarDidClickPlusButton:(XLTabBar *)tabBar
{
    //创建发送微博控制器
    XLComposeViewController *composeVc = [[XLComposeViewController alloc] init];
    XLNavigationController *nav = [[XLNavigationController alloc] initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark --添加所有的子控制器
- (void)setUpAllChildViewController
{
    // 首页
    XLHomeViewController *home = [[XLHomeViewController alloc] init];
    
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
    
    // 消息
    XLMessageViewController *message = [[XLMessageViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;
    
    // 发现
    XLDiscoverViewController *discover = [[XLDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    // 我
    XLProfileViewController *profile = [[XLProfileViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    _profile = profile;
}

#pragma mark --添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;

    vc.tabBarItem.selectedImage = selectedImage;
    
    [self.items addObject:vc.tabBarItem];
    
    XLNavigationController *nav = [[XLNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

@end
