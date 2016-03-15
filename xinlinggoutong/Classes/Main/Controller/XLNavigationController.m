//
//  XLNavigationController.m
//  xinlinggoutong
//
//  Created by m on 15/12/16.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLNavigationController.h"
#import "UIBarButtonItem+XLItem.h"

@interface XLNavigationController () <UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;
@end

@implementation XLNavigationController

+ (void)initialize
{
    //获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    //设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    //设置不可用
//    titleAttr = [NSMutableDictionary dictionary];
//    
//    titleAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    [item setTitleTextAttributes:titleAttr forState:UIControlStateDisabled];
    
    //注意:导航条上按钮不可用，用文字属性设置是不好用的
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//导航控制器即将显示新的控制器的时候
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //获取主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //获取tabBarVc
    UITabBarController *tabBarVc = (UITabBarController *)keyWindow.rootViewController;
    
    //移除系统自带的tarbBar
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }

}

//导航控制器跳转完成的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }else{
        //实现滑动返回功能
        //清空滑动返回手势的代理，就能实现滑动功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置非根控制器导航条的内容
    if (self.viewControllers.count != 0) {
        //设置导航条的内容
        //设置导航条左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        //右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)backToPre
{
    [self popViewControllerAnimated:YES];
}

- (void)backToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

@end
