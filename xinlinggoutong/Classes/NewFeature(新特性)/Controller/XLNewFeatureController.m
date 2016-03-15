//
//  XLNewFeatureController.m
//  xinlinggoutong
//
//  Created by m on 15/12/16.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLNewFeatureController.h"
#import "XLNewFeatureCell.h"

@interface XLNewFeatureController ()

@property (nonatomic, weak) UIPageControl *control;

@end

@implementation XLNewFeatureController

//static NSString * const reuseIdentifier = @"Cell";
static NSString * const ID = @"cell";
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    //清空行距
    layout.minimumLineSpacing = 0;
    
    //左右滚蛋方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor greenColor];
    
    //注册cell
    [self.collectionView registerClass:[XLNewFeatureCell class] forCellWithReuseIdentifier:ID];
    //分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;//不要有弹性
    self.collectionView.showsHorizontalScrollIndicator = NO;//水平条消失
    
    // 添加pageController
    [self setUpPageControl];
}

- (void)setUpPageControl
{
    // 添加pageController,只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    //设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height - 20);
    _control = control;
    
    [self.view addSubview:control];
}

//返回有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//返回第section组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

//返回cell显示什么数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // dequeueReusableCellWithReuseIdentifier
    // 1.首先从缓存池里取cell
    // 2.看下当前是否有注册Cell,如果注册了cell，就会帮你创建cell
    // 3.没有注册，报错
    XLNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    
    // 拼接图片名称 3.5 320 480
//    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
//    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
//    if (screenH > 480) { // 5 , 6 , 6 plus
//       NSString * imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
//    }
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
   
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];
    
#pragma mark --屏幕适配有问题???? 2015-12-17等解决
//    if (screenH > 480) {
//        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
//    }

    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:4];
    
    return cell;

}
@end
