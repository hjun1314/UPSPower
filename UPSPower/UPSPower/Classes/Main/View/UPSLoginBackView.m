//
//  UPSLoginBackView.m
//  UPSPower
//
//  Created by hjun on 2017/12/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSLoginBackView.h"
@implementation UPSLoginBackView

//重写此方法，用Quartz2D画出中间分割线
-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,0.7);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,0,40);
    CGContextAddLineToPoint(context,self.frame.size.width,40);
    CGContextClosePath(context);
    [UICOLOR_RGB(207, 207, 207, 1)setStroke];
    CGContextStrokePath(context);
}
@end
