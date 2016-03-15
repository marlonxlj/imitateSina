//
//  UIImage+XLImage.h
//  xinlinggoutong
//
//  Created by m on 15/12/13.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XLImage)

+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;
@end
