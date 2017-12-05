//
//  UIImage+Image.m
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
+ (UIImage *)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

///裁剪头像变圆
- (instancetype)circleImage{
    ///1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    ///2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0 ,self.size.width,self.size.height)];
    ///3.设置裁剪区域
    [path addClip];
    ///4. 画图片
    [self drawAtPoint:CGPointZero];
    ///5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    ///6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
    
    
}

+ (instancetype)circleImageName:(NSString *)name{
    
    return [[self imageNamed:name]circleImage];
}


@end
