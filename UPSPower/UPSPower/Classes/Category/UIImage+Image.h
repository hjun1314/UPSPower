//
//  UIImage+Image.h
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

///设置图片的渲染方式
+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

///裁剪头像变圆
- (instancetype)circleImage;

+ (instancetype)circleImageName:(NSString *)name;

@end
