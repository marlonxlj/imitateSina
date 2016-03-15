//
//  XLOAuthViewController.m
//  xinlinggoutong
//
//  Created by m on 15/12/17.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLOAuthViewController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

#import "XLRootTool.h"
#import "XLAccountTool.h"

@interface XLOAuthViewController ()<UIWebViewDelegate>

@end

@implementation XLOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //展示登录的网页->UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    //加载网页
    
    NSString *baseUrl = XLAuthorizeBaseUrl;
    NSString *client_id = XLClient_id;
    NSString *redirect_uri = XLRedirect_uri;
    //拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseUrl, client_id, redirect_uri];
    //创建URl
    NSURL *url = [NSURL URLWithString:urlStr];
    //创建
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载请求
    [webView loadRequest:request];
    
    //设置代理
    webView.delegate = self;
}

#pragma mark --UIWebView代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
//拦截WebView请求,当WebView需要加载一个请求的时候，就会调用这个方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    
    //获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {//有code=
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        //换取accessToken
        [self accessTokenWithCode:code];
        
        return NO;
    }
    XLLog(@"%@====",urlStr);
    
    return YES;
}
#pragma mark -换取accessToken
/**
 *  换取accessToken
 * url:https://api.weibo.com/oauth2/access_token
 *  @param code
 * 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    [XLAccountTool accountWithCode:code success:^{
        // 进入主页(进入新特性还是进入tabBar)
        [XLRootTool chooseRootViewController:XLKeyWindow];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
@end
