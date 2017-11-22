//
//  UPSTabVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSTabVC.h"
#import "UPSEquipmentVC.h"
#import "UPSSettingVC.h"
#import "UPSMineVC.h"
#import "UPSNacVC.h"
#import "UIImage+Image.h"

@interface UPSTabVC ()

@end

@implementation UPSTabVC
+ (void)load{
    // 获取哪个类中UITabBarItem
    
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    ///设置字体尺寸
    NSMutableDictionary *attrsN = [NSMutableDictionary dictionary];
    attrsN[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
    [item setTitleTextAttributes:attrsN forState:UIControlStateNormal];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVC];
    [self setupChildVCTitle];
}
///设置子控制器
- (void)setupChildVC{
    
    UPSEquipmentVC *equipment = [[UPSEquipmentVC alloc]init];
    UPSNacVC *nav = [[UPSNacVC alloc]initWithRootViewController:equipment];
    [self addChildViewController:nav];
    
    UPSSettingVC *setting = [[UPSSettingVC alloc]init];
    UPSNacVC *nav1 = [[UPSNacVC alloc]initWithRootViewController:setting];
    [self addChildViewController:nav1];
    
    UPSMineVC *mine = [[UPSMineVC alloc]init];
    UPSNacVC *nav2 = [[UPSNacVC alloc]initWithRootViewController:mine];
    [self addChildViewController:nav2];
    
}
///设置tab的title
- (void)setupChildVCTitle{
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"设备";
    nav.tabBarItem.image = [UIImage imageNamed:@"equipmentOrignal"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"equipmentSel"];
    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"报警";
    nav1.tabBarItem.image = [UIImage imageNamed:@"equipmentOrignal"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"equipmentSel"];
    
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"个人";
    nav2.tabBarItem.image = [UIImage imageNamed:@"equipmentOrignal"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"equipmentSel"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
