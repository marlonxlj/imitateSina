//
//  XLStatusFrame.h
//  xinlinggoutong
//
//  Created by m on 15/12/20.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//  模型 + 对应控件的frame

#import <Foundation/Foundation.h>

@class XLStatus;

@interface XLStatusFrame : NSObject
/**
 *  微博数据
 */
@property (nonatomic, strong) XLStatus *status;

// 原创微博frame
@property (nonatomic, assign) CGRect originalViewFrame;


/** **********原创微博子控件的frame ******/

//头像frame
@property (nonatomic, assign) CGRect originalIconFrame;

//昵称frame
@property (nonatomic, assign) CGRect originalNameFrame;

//VIP frame
@property (nonatomic, assign) CGRect originalVipFrame;

//时间 frame
@property (nonatomic, assign) CGRect originalTimeFrame;

//来源frame
@property (nonatomic, assign) CGRect originalSourceFrame;

//正文 frame
@property (nonatomic, assign) CGRect originalTextFrame;

//配图 frame
@property (nonatomic, assign) CGRect originalPhotosFrame;



/** *********** 转发微博frame ********/

@property (nonatomic, assign) CGRect retweetViewFrame;

//转发昵称frame
@property (nonatomic, assign) CGRect retweetlNameFrame;

//转发正文 frame
@property (nonatomic, assign) CGRect retweetTextFrame;

// 工具条frame
@property (nonatomic, assign) CGRect toolBarFrame;

//配图 frame
@property (nonatomic, assign) CGRect retweetPhotosFrame;



/** *********** cell的高度frame ********/

@property (nonatomic, assign) CGFloat cellHeight;

@end
