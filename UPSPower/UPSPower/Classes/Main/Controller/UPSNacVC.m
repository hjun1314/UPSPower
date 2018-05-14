//
//  UPSNacVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSNacVC.h"
@interface UPSNacVC ()

@end

@implementation UPSNacVC
+ (void)load{
//    [[UINavigationBar appearance] setTranslucent:NO];

    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    ///设置导航栏字体
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [bar setTitleTextAttributes:attrs];
    [bar setBarTintColor:UICOLOR_RGB(55.0, 157.0, 246.0, 1)];
//    [bar setBarTintColor:[UIColor whiteColor]];
    // 设置导航条背景图片
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
   // [bar setBackgroundImage:[self createImageWithColor: UICOLOR_RGB(55.0, 157.0, 246.0, 1)] forBarMetrics:UIBarMetricsDefault];
}
+ (UIImage*)createImageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
