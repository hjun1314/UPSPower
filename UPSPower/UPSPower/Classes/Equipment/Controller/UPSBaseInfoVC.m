//
//  UPSBaseInfoVC.m
//  UPSPower
//
//  Created by hjun on 2017/12/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSBaseInfoVC.h"

@interface UPSBaseInfoVC ()

@end

@implementation UPSBaseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setUI];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)setNav{
    self.navigationItem.title = @"设备详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"基础信息" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
}
- (void)clickRightItem{
    
}
- (void)setUI{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 20, kScreenW, kScreenH * 0.3)];
    imageView.image = [UIImage imageNamed:@"0-1-正常工作状态"];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
