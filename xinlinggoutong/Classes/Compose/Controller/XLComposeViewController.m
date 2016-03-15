//
//  XLComposeViewController.m
//  xinlinggoutong
//
//  Created by m on 15/12/22.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLComposeViewController.h"
#import "XLTextView.h"
#import "XLComposeToolBar.h"
#import "XLComposePhotosView.h"

#import "XLComposeTool.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "XLComposeParm.h"
#import "MJExtension.h"


@interface XLComposeViewController () <UITextViewDelegate, XLComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) XLTextView *textView;

@property (nonatomic, weak) XLComposeToolBar *tooBar;

@property (nonatomic, weak) XLComposePhotosView *photosView;

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation XLComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航条
    [self setUpNavigatinBar];
    
    //添加textView
    [self setUpTextView];
    
    //添加工具条
    [self setUpToolBar];
//    图片压缩
//    UIImageJPEGRepresentation(<#UIImage * _Nonnull image#>, 0.000001)
    
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //添加相册视图
    [self setUpPhotosView];
    
}

#pragma mark --添加相册视图
- (void)setUpPhotosView
{
    XLComposePhotosView *photosView = [[XLComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    
    _photosView = photosView;
    [_textView addSubview:photosView];
}
#pragma mark -- 监听键盘的弹出
- (void)keyboardFrameChange:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) {//没有弹出键盘
        [UIView animateWithDuration:duration animations:^{
            _tooBar.transform = CGAffineTransformIdentity;
        }];
        
    }else{
        //工具条向上移动258
        [UIView animateWithDuration:duration animations:^{
             _tooBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
       
    }
}



- (void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    
    
    XLComposeToolBar *toolBar = [[XLComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _tooBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}

#pragma mark --点击工具条按钮的时候调用
- (void)composeToolBar:(XLComposeToolBar *)toolBar diddClickBtn:(NSInteger)indexPath
{
    if (indexPath == 0) {//点击了相册
        //弹出系统的相册
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [_textView becomeFirstResponder];
}

#pragma mark --选择图片完成的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    _photosView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    _rightItem.enabled = YES;
}

#pragma mark -- 添加textView
- (void)setUpTextView
{
    XLTextView *textView = [[XLTextView alloc] initWithFrame:self.view.bounds];
    _textView = textView;
    //设置占位符
    textView.placeHolder = @"分享新鲜事...";
    
    [self.view addSubview:textView];
    
    //默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    
    //监听文本框的输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    //监听拖拽
    _textView.delegate = self;
    
    
}

#pragma mark --开始拖拽时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

//文字改变时调用
- (void)textChange
{
    //判断textView有没有内容
    
    if (_textView.text.length) {//有内容
        _textView.hidePlaceHolder = YES;
        _rightItem.enabled = YES;
    }else{//没有内容
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
    }
}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpNavigatinBar
{
    self.title = @"发送微博";
    
    //left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    //right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    
    // 监听按钮点击
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//发送
- (void)sendTitle
{
    //1.发送文字
    [XLComposeTool composeWithStatus:_textView.text success:^{
        
        //提示用户发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
        //回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showSuccess:@"发送失败"];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 发送微博
- (void)compose
{
    // 新浪上传：文字不能为空，分享图片
    // 二进制数据不能拼接url的参数，只能使用formdata
    // 判断下有没有图片
    if (self.images.count) { // 发送图片
        
        // 发送图片
        [self sendPicture];
        
    }else{
        
        // 发送文字
        [self sendTitle];
    }
    
}
#pragma mark - 发送图片
- (void)sendPicture
{
    UIImage *image = self.images[0];
    
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    
    _rightItem.enabled = NO;
    // 我引用你，你引用我
    [XLComposeTool composeWithStatus:status image:image success:^{
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送图片成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        _rightItem.enabled = YES;
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error.description);
        [MBProgressHUD showSuccess:@"发送图片失败"];
        _rightItem.enabled = YES;
        
    }];
}

@end
