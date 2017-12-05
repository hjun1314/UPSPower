//
//  UPSMainVC.m
//  UPSPower
//
//  Created by hjun on 2017/12/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSMainVC.h"
#import "UPSLoginView.h"
#import "UPSTabVC.h"
@interface UPSMainVC ()

@property (nonatomic,strong)UPSLoginView *loginView;


@end

@implementation UPSMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UPSLoginView *loginView = [[UPSLoginView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTopHeight)];
    self.loginView = loginView;
    [self.view addSubview:loginView];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickLoginViewSureBtn) name:@"didClickSureBtn" object:nil];
}

- (void)clickLoginViewSureBtn{
    NSLog(@"点击了按钮");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
