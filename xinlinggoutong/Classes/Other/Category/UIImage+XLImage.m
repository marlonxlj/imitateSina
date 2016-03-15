//
//  UIImage+XLImage.m
//  xinlinggoutong
//
//  Created by m on 15/12/13.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "UIImage+XLImage.h"

@implementation UIImage (XLImage)

+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
   UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
