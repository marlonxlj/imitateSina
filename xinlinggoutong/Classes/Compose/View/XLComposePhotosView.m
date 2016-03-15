//
//  XLComposePhotosView.m
//  xinlinggoutong
//
//  Created by m on 15/12/22.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLComposePhotosView.h"

@implementation XLComposePhotosView

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.image = image;
    
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat marign = 10;
    CGFloat wh = (self.width - (cols - 1) * marign) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        col = i % cols;
        row = i / cols;
        x = col * (marign + wh);
        y = row * (marign + wh);
        
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
}

@end
