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

    //192.168.1.147:12345/ups-interface/login
    NSDictionary *params = @{@"username":self.loginView.userTextField.text,@"password":self.loginView.passwordTextField.text};

    [[UPSHttpNetWorkTool sharedApi]POST:@"login" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"总的数据%@",responseObject);
        ///总模型
        NSMutableArray *dataM = [NSMutableArray array];
        NSDictionary *data = responseObject[@"data"];
        UPSMainModel *mainModel = [UPSMainModel mj_objectWithKeyValues:data];
        [dataM addObject:mainModel];

        ///parentGroup数组转模型数组
        NSMutableArray *parentM = responseObject[@"data"][@"parentGroup"];

        NSMutableArray *parentG = [NSMutableArray array];
        for (int i = 0; i < parentM.count; i++) {
            UPSParentGroupModel *groupModel = [UPSParentGroupModel mj_objectWithKeyValues:parentM[i]];
            [parentG addObject:groupModel];

        }

//     self.parentArr = [UPSParentGroupModel mj_objectArrayWithKeyValuesArray:self.tempArr];
        ///ups设备数组转模型数组
        NSMutableArray *upsM = responseObject[@"data"][@"groupUps"];
        NSMutableArray *upsG = [NSMutableArray array];
        for (int i = 0 ; i < upsM.count; i++) {
            UPSGroupUPSModel *upsModel = [UPSGroupUPSModel mj_objectWithKeyValues:upsM[i]];
            [upsG addObject:upsModel];
        }

        ///存token id
        [UPSTool saveToken:responseObject[@"data"][@"token"]];
        NSString *ID = responseObject[@"data"][@"userId"];
        [UPSTool saveID:[ID integerValue]];
        UPSTabVC *tab = [[UPSTabVC alloc]init];
        tab.tabArr = parentG;
        UPSEquipmentVC *eqVC = [[UPSEquipmentVC alloc]init];
        eqVC.dataArr = parentG;
        eqVC.upsArr = upsG;
        [self.navigationController pushViewController:eqVC animated:YES];
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"登录失败");
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
