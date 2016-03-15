//
//  XLTextView.m
//  xinlinggoutong
//
//  Created by m on 15/12/22.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLTextView.h"

@interface XLTextView ()

@property (nonatomic, weak) UILabel *placeHolderLable;

@end
@implementation XLTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
//        self.placeHolderLable.font = self.font;
    }
    
    return self;
}

- (UILabel *)placeHolderLable
{
    if (_placeHolderLable== nil) {
        UILabel *lable = [[UILabel alloc] init];
        
        [self addSubview:lable];
        _placeHolderLable = lable;
    }
    
    return _placeHolderLable;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    self.placeHolderLable.text = placeHolder;
    
    //lable的尺寸跟文字一样
    [self.placeHolderLable sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeHolderLable.x = 5;
    self.placeHolderLable.y = 8;
    
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLable.font = self.font;
    [self.placeHolderLable sizeToFit];
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    
    self.placeHolderLable.hidden = hidePlaceHolder;
}
@end
