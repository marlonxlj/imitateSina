//
//  XLHomeViewController.m
//  xinlinggoutong
//
//  Created by m on 15/12/15.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLHomeViewController.h"
#import "UIBarButtonItem+XLItem.h"
#import "XLTitleButton.h"
#import "XLPopMenu.h"
#import "XLCover.h"
#import "XLOneViewController.h"
#import "AFNetworking.h"
#import "XLAccountTool.h"
#import "XLAccount.h"
#import "XLStatus.h"
#import "MJExtension.h"
#import "XLUser.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "XLHttpTool.h"

#import "XLStatusTool.h"
#import "XLUserTool.h"

#import "XLAccount.h"
#import "XLAccountTool.h"

#import "XLStatusCell.h"
#import "XLStatusFrame.h"

@interface XLHomeViewController ()<XLCoverDelegate>

@property (nonatomic, weak)XLTitleButton *titleButton;

@property (nonatomic, strong) XLOneViewController *one;

/**
 *  ViewModel:XLStatusFrame
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation XLHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (XLOneViewController *)one
{
    if (_one == nil) {
        _one = [[XLOneViewController alloc] init];
    }
    return _one;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置导航条内容
    [self setUpNavgationBar];
    //添加下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
//
//    //添加上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    //一开始展示之前的微博名称，然后在发送用户信息请求，直接赋值
    
    //请求录前用户的昵称
    [XLUserTool userInfoWithSuccess:^(XLUser *user) {
        
        //请求到当前账号的用户信息
        //设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //获取当前账号
        XLAccount *account = [XLAccountTool account];
        account.name = user.name;
        
        //保存用户的昵称
        [XLAccountTool saveAccount:account];
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -刷新最新的微博
- (void)refresh
{
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
}
#pragma mark -请求更多旧的微博数
- (void)loadMoreStatus
{
    NSString *maxIdStr = nil;
    
    if (self.statusFrames.count) {//有微博数据才需要下拉刷新
//        XLStatus *s = [self.statusFrames[0] status];
        XLStatus *s = [[self.statusFrames lastObject] status];
        long long maxId = [ s.idstr longLongValue] - 1;
        
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    [XLStatusTool MoreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        //结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        NSMutableArray *statuesFrames = [NSMutableArray array];
        //模型转换视图模型 XLStatus->XLStatusFrame
        for (XLStatus *status in statuses) {
            XLStatusFrame *statusF = [[XLStatusFrame alloc] init];
            statusF.status = status;
            [statuesFrames addObject:statusF];
        }
        
        
        // 把数组中的元素添加进去
        [self.statusFrames addObjectsFromArray:statuesFrames];
        
        // 刷新表格
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
    }];
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//
//    params[@"access_token"]= [XLAccountTool account].access_token;
//    
//    [XLHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(id responseObject) {
//
//        
//        //获取到微博数据
//        //1 获取微博字典的数组
//        //方法:1.2
//        NSArray *dictArr = responseObject[@"statuses"];
//        NSArray *statuses = (NSMutableArray *)[XLStatus objectArrayWithKeyValuesArray:dictArr];
//        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
//    } failure:^(NSError *error) {
//        
//    }];
}

//- (void)loadMoreStatus
//{
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    //    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (self.statuses.count) {//有微博数据才需要下拉刷新
//        
//         long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
//        
//        params[@"max_id"] = [NSString stringWithFormat:@"%lld",maxId];
//    }
//    params[@"access_token"]= [XLAccountTool account].access_token;
//    
//    // 发送get请求
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //结束上拉刷新
//        [self.tableView footerEndRefreshing];
//        
//        //获取到微博数据
//        //1 获取微博字典的数组
//        //方法:1.1
//        //        NSArray *dictArr = responseObject[@"statuses"];
//        //        for (NSDictionary *dict in dictArr) {
//        //            //字典转XLStatus
//        //           XLStatus *status = [XLStatus objectWithKeyValues:dict];
//        //            [self.statuses addObject:status];
//        //        }
//        //方法:1.2
//        NSArray *dictArr = responseObject[@"statuses"];
//        NSArray *statuses = (NSMutableArray *)[XLStatus objectArrayWithKeyValuesArray:dictArr];
//        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
//        // 把数组中的元素添加进去
//        [self.statuses addObjectsFromArray:statuses];
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//
//}


#pragma mark -请求最新的微博数
- (void)loadNewStatus
{
    NSString *sinceId = nil;
    if (self.statusFrames.count) {//有微博数据才需要下拉刷新
        XLStatus *s = [self.statusFrames[0] status];
        sinceId = s.idstr;
    }
//    params[@"access_token"]= [XLAccountTool account].access_token;
    
    [XLStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {//请求成功的BLOCK
        
        //展示最新的微博数
        [self showNewStatusCount:statuses.count];
        
        //结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        NSMutableArray *statuesFrames = [NSMutableArray array];
        //模型转换视图模型 XLStatus->XLStatusFrame
        for (XLStatus *status in statuses) {
            XLStatusFrame *statusF = [[XLStatusFrame alloc] init];
            statusF.status = status;
            [statuesFrames addObject:statusF];
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];

        [self.statusFrames insertObjects:statuesFrames atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark -- 展示最新的微博数
- (void)showNewStatusCount:(int)count
{
    if (count == 0) return;
    
    //展示最新的微博数
    CGFloat x = 0;
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame)- h;
    CGFloat w = self.view.width;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    lable.text = [NSString stringWithFormat:@"最新微博数%d", count];
    lable.textAlignment = NSTextAlignmentCenter;
    
    //插入到导航控制器下导航条下面
    [self.navigationController.view insertSubview:lable belowSubview:self.navigationController.navigationBar];
    
    //动画平移
    [UIView animateWithDuration:0.25 animations:^{
        //往下
        lable.transform = CGAffineTransformMakeTranslation(0, h);
        
    } completion:^(BOOL finished) {
       //还原
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            lable.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [lable removeFromSuperview];
        }];
        
    }];
    
}

//- (void)loadNewStatus
//{
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (self.statuses.count) {//有微博数据才需要下拉刷新
//
//         params[@"since_id"] = [self.statuses[0] idstr];
//    }
//    params[@"access_token"]= [XLAccountTool account].access_token;
//    
//    // 发送get请求
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //结束下拉刷新
//        [self.tableView headerEndRefreshing];
//        
//        //方法:1.2
//        NSArray *dictArr = responseObject[@"statuses"];
//        NSArray *statuses = (NSMutableArray *)[XLStatus objectArrayWithKeyValuesArray:dictArr];
//        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
//        // 把数组中的元素添加进去
////        [self.statuses addObjectsFromArray:statuses];
//        [self.statuses insertObjects:statuses atIndexes:indexSet];
//        
//        // 刷新表格
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//}

#pragma mark - 设置导航条
- (void)setUpNavgationBar
{
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    //titleView
    XLTitleButton *titleButton = [XLTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    NSString *title = [XLAccountTool account].name?:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    //高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    //弹出蒙板
    XLCover *cover = [XLCover show];
    cover.delegate = self;
    
    //弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    
    XLPopMenu *menu = [XLPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
    
}

//点击蒙板的时候调用
- (void)coverDidClickCover:(XLCover *)cover
{
    [XLPopMenu hide];
    
    _titleButton.selected = NO;
}

- (void)friendsearch
{
    
}

- (void)pop
{
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //创建cell
    XLStatusCell *cell = [XLStatusCell cellWithTableView:tableView];
    
    //获取status模型
    XLStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    
    //给cell传递模型
    
    //用户昵称
    cell.statusF = statusF;
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
    
    return cell;
}

/**
    问题: 1.cell的高度应该提前计算出来
         2.cell的高度必须先计算出每个子控件的位置，才能确定
         3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能
    解决方法:MVVM思想
    M:模型
    V:视图
    VM:视图模型
 */

//返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取status模型
    XLStatusFrame *statusF = self.statusFrames[indexPath.row];
    return statusF.cellHeight;
}

@end
