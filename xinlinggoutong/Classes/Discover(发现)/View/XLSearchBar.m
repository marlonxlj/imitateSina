//
//  XLSearchBar.m
//  xinlinggoutong
//
//  Created by m on 15/12/16.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLSearchBar.h"

@implementation XLSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
        
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        //设置左边的view
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageV.width += 10;
        imageV.contentMode = UIViewContentModeCenter;
        self.leftView = imageV;
        
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

@end
