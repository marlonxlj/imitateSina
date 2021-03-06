//
//  UIBarButtonItem+XLItem.m
//  xinlinggoutong
//
//  Created by m on 15/12/15.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "UIBarButtonItem+XLItem.h"

@implementation UIBarButtonItem (XLItem)
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
