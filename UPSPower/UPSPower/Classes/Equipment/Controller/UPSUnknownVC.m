//
//  UPSUnknownVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/23.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSUnknownVC.h"

@interface UPSUnknownVC ()

@end

@implementation UPSUnknownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
}

- (void)setNav{
    
    self.navigationItem.title = @"状态详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, self.view.width, self.view.height - SafeAreaTabbarHeight)];
    imageView.image = [UIImage imageNamed:@"unknown"];
    [self.view addSubview:imageView];
}

- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
