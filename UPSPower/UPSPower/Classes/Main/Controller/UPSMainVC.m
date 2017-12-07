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
#import "UPSNacVC.h"
#import "UPSMainModel.h"
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
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)clickLoginViewSureBtn{
//    UPSTabVC *tab = [[UPSTabVC alloc]init];
//    [self.navigationController pushViewController:tab animated:YES];
//
    ///192.168.1.147:12345/ups-interface/login
    NSDictionary *params = @{@"username":self.loginView.userTextField.text,@"password":self.loginView.passwordTextField.text};

    [[UPSHttpNetWorkTool sharedApi]POST:@"login" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        UPSTabVC *tab = [[UPSTabVC alloc]init];
        [self.navigationController pushViewController:tab animated:YES];
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        NSMutableArray *dataM = [NSMutableArray array];
        NSDictionary *data = responseObject[@"data"];
        
        UPSMainModel *model = [UPSMainModel mj_objectWithKeyValues:data];
        [dataM addObject:model];
        NSLog(@"模型数组。。。%@",dataM);
        [UPSTool saveToken:responseObject[@"data"][@"token"]];
        NSString *ID = responseObject[@"data"][@"userId"];
        [UPSTool saveID:[ID integerValue]];
//        NSLog(@"groupUps模型%@",responseObject[@"data"][@"groupUps"]);
//        NSLog(@"%@",);

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"登录失败");
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
