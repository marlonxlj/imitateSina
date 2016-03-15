//
//  XLComposeTool.m
//  xinlinggoutong
//
//  Created by m on 15/12/22.
//  Copyright © 2015年 YourDevloper. All rights reserved.
//

#import "XLComposeTool.h"
#import "XLHttpTool.h"
#import "XLComposeParm.h"
#import "MJExtension.h"
#import "XLUploadParam.h"

@implementation XLComposeTool

+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error)) failure
{
    XLComposeParm *param = [XLComposeParm param];
    param.status = status;
    
    [XLHttpTool Post:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    XLComposeParm *param = [XLComposeParm param];
    param.status = status;
    
    // 创建上传的模型
    XLUploadParam *uploadP = [[XLUploadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    // 注意：以后如果一个方法，要传很多参数，就把参数包装成一个模型
    [XLHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadP success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
@end
