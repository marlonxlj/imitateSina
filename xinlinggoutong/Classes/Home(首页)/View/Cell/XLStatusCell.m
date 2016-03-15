//
//  XLStatusCell.m
//  xinlinggoutong
//
//  Created by m on 15/12/20.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLStatusCell.h"
#import "XLOriginalView.h"
#import "XLRetweetView.h"
#import "XLStatusToolBar.h"

#import "XLStatusFrame.h"
#import "XLStatus.h"

@interface XLStatusCell ()

@property (nonatomic, weak) XLOriginalView *orginalView;

@property (nonatomic, weak) XLRetweetView *retweetView;

@property (nonatomic, weak) XLStatusToolBar *toolBar;

@end

@implementation XLStatusCell

//注意:cellj et initwithstyle初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

#pragma mark -- 添加所有子控件
- (void)setUpAllChildView
{
    //原创微博
    XLOriginalView *orginalView = [[XLOriginalView alloc] init];
    
    [self addSubview:orginalView];
    _orginalView = orginalView;
    
    //转发微博
    XLRetweetView *retweetView = [[XLRetweetView alloc] init];
    
    [self addSubview:retweetView];
    _retweetView = retweetView;
    //工具条
    XLStatusToolBar *toolBar = [[XLStatusToolBar alloc] init];
    
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setStatusF:(XLStatusFrame *)statusF
{
    _statusF = statusF;
    
    //设置原创微博的frame
    _orginalView.frame = statusF.originalViewFrame;
    _orginalView.statusF = statusF;

    if (statusF.status.retweeted_status) {
        //设置转发微博的frame
        _retweetView.frame = statusF.retweetViewFrame;
        _retweetView.statusF = statusF;
        _retweetView.hidden = NO;
    }else{
        _retweetView.hidden = YES;
    }
    
    //设置工具条的frame
    _toolBar.frame = statusF.toolBarFrame;
    _toolBar.status = statusF.status;
  
}

@end
