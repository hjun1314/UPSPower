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
#import "UPSChildUsersVC.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"

@interface UPSMainVC ()

@property (nonatomic,strong)UPSLoginView *loginView;

@end

@implementation UPSMainVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UPSLoginView *loginView = [[UPSLoginView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.loginView = loginView;
    self.loginView.backgroundColor = UICOLOR_RGB(55.0, 157.0, 246.0, 0.7);
    //    self.loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickLoginViewSureBtn) name:@"didClickSureBtn" object:nil];
    //    self.navigationItem.title = @"账号登录";
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    [SVProgressHUD show];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    NSDictionary *params = @{@"username":self.loginView.userTextField.text,@"password":self.loginView.passwordTextField.text,@"registrationId":[UPSTool getGeTuiCid]};
    kWeakSelf(self);
    [UPSTool dc_saveUserData:@"1" forKey:@"isLogin"];
    [[UPSHttpNetWorkTool sharedApi]POST:@"login" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
          
            
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
            [weakself.navigationController pushViewController:tab animated:YES];
           [tab.view makeToast:@"登录成功" duration:0.5 position:CSToastPositionCenter];
            [UPSTool saveUserName:weakself.loginView.userTextField.text];
            [UPSTool savePassWord:weakself.loginView.passwordTextField.text];
            
        });
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
//            UPSTabVC *tab = [[UPSTabVC alloc]init];

            [weakself.view makeToast:@"账号密码错误请重新登录" duration:0.5 position:CSToastPositionCenter];
        });
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
