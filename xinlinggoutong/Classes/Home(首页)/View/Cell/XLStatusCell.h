//
//  XLStatusCell.h
//  xinlinggoutong
//
//  Created by m on 15/12/20.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLStatusFrame;

@interface XLStatusCell : UITableViewCell

@property (nonatomic, strong) XLStatusFrame *statusF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
