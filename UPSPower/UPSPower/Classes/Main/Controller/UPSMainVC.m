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
#import "UPSParentGroupModel.h"
#import "UPSGroupUPSModel.h"
#import "UPSEquipmentVC.h"
#import "MBProgressHUD.h"
@interface UPSMainVC ()

@property (nonatomic,strong)UPSLoginView *loginView;




@end

@implementation UPSMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UPSLoginView *loginView = [[UPSLoginView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.loginView = loginView;
    self.loginView.backgroundColor = UICOLOR_RGB(55.0, 157.0, 246.0, 0.6);
//    self.loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickLoginViewSureBtn) name:@"didClickSureBtn" object:nil];
//    self.navigationItem.title = @"账号登录";
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
//
    self.tabBarController.tabBar.hidden = YES;
    

}

- (void)clickLoginViewSureBtn{
    if ([self.loginView.userTextField.text  isEqual: @""] || [self.loginView.passwordTextField.text  isEqual: @""]) {
        self.loginView.loginButton.enabled = NO;
        return;
    }else {
        self.loginView.loginButton.enabled = YES;
        [self loadLoginData];
        
    }

}
- (void)loadLoginData{
    //    UPSTabVC *tab = [[UPSTabVC alloc]init];
    //    [self.navigationController pushViewController:tab animated:YES];
    [SVProgressHUD showWithStatus:@"正在登陆"];
    [SVProgressHUD setBackgroundColor:UICOLOR_RGB(0, 0, 0, 0.3)];

    //192.168.1.147:12345/ups-interface/login
    NSDictionary *params = @{@"username":self.loginView.userTextField.text,@"password":self.loginView.passwordTextField.text,@"registrationId":@"1a1018970aa361f103f"};
    
    [[UPSHttpNetWorkTool sharedApi]POST:@"login" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"总的数据%@",responseObject);
        ///总模型
        NSMutableArray *dataM = [NSMutableArray array];
        NSDictionary *data = responseObject[@"data"];
        
        UPSMainModel *mainModel = [UPSMainModel mj_objectWithKeyValues:data];
        [dataM addObject:mainModel];
        ///parentGroup数组转模型数组
        //        NSMutableArray *parentM = responseObject[@"data"][@"parentGroup"];
        //
        //        NSMutableArray *parentG = [NSMutableArray array];
        //        for (int i = 0; i < parentM.count; i++) {
        //            UPSParentGroupModel *groupModel = [UPSParentGroupModel mj_objectWithKeyValues:parentM[i]];
        //            [parentG addObject:groupModel];
        //
        //        }
        ////     self.parentArr = [UPSParentGroupModel mj_objectArrayWithKeyValuesArray:self.tempArr];
        //        ///ups设备数组转模型数组
        // NSMutableArray *upsM = responseObject[@"data"][@"groupUps"];
        //NSMutableArray *upsG = [NSMutableArray array];
        //        upsG = [UPSGroupUPSModel mj_objectArrayWithKeyValuesArray:upsM];
        //        for (int i = 0 ; i < upsM.count; i++) {
        //            UPSGroupUPSModel *upsModel = [UPSGroupUPSModel mj_objectWithKeyValues:upsM[i]];
        //            [upsG addObject:upsModel];
        //        }
        
        ///存token id
        [UPSTool saveToken:responseObject[@"data"][@"token"]];
        NSString *ID = responseObject[@"data"][@"userId"];
        [UPSTool saveID:[ID integerValue]];
        
        UPSTabVC *tab = [[UPSTabVC alloc]init];
        
        [self.navigationController pushViewController:tab animated:YES];
        [UPSTool saveUserName:self.loginView.userTextField.text];
        [UPSTool savePassWord:self.loginView.passwordTextField.text];
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"登录失败%@",error);
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
