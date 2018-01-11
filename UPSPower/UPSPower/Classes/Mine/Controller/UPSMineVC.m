//
//  UPSMineVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSMineVC.h"
#import "UPSAboutUsVC.h"
#import "UPSAlarmVC.h"
#import "UPSChildUsersVC.h"
#import "UPSMainModel.h"
#import "UPSMainVC.h"
#import "UPSAlarmModel.h"
@interface UPSMineVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UPSMainModel *mainModel;

@end

@implementation UPSMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"个人中心";
    [self setup];
    UPSMainModel *model = [UPSMainModel sharedUPSMainModel];
    self.mainModel = model;
}

- (void)setup{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTabbarHeight - SafeAreaTopHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.dataSource = self;
    tableView.delegate = self;
    
}
#pragma mark- delegate&datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"mineCell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
    }
    if (indexPath.row == 0 ) {
        cell.textLabel.text = @"修改密码";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"子用户管理";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"告警定义设置";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"关于我们";
    }else{
        cell.textLabel.text = @"用户注销";
    }
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        
  
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改父账号密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"修改密码";
            textField.secureTextEntry = YES;
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ///http://192.168.1.147:12345/ups-interface/updateParentPassword
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"token"] = self.mainModel.token;
            params[@"userId"] = @(self.mainModel.userId);
            params[@"newPassword"] = alert.textFields[0].text;
            [[UPSHttpNetWorkTool sharedApi]POST:@"updateParentPassword" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"密码修改成功%@",responseObject);
                UPSMainVC *main = [[UPSMainVC alloc]init];
                [self.navigationController pushViewController:main animated:YES];
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
        }]];
        
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        
    }else if (indexPath.row == 1){
        
        UPSChildUsersVC *childUserVC = [[UPSChildUsersVC alloc]init];
        [self.navigationController pushViewController:childUserVC animated:YES];
        
    }else if (indexPath.row == 2){
        ///http://192.168.1.147:12345/ups-interface/upsAlarmConfigureList
       
        UPSAlarmVC *alarmVC = [[UPSAlarmVC alloc]init];
        [self.navigationController pushViewController:alarmVC animated:YES];

    }else if (indexPath.row == 3){
        
        UPSAboutUsVC *aboutVC = [[UPSAboutUsVC alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];
        
    }else{
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"确定注销?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ///http://192.168.1.147:12345/ups-interface/logout
            NSDictionary *params = @{@"token": [UPSTool getToken] ,@"userId":@([UPSTool getID])};
            [[UPSHttpNetWorkTool sharedApi]POST:@"logout" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"注销成功");
                UPSMainVC *main = [[UPSMainVC alloc]init];
                [main setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:main animated:YES];
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"注销失败");
            }];
            
            
            
        }];
        
        [alert addAction:cancel];
        [alert addAction:sure];
        
        [self presentViewController:alert animated:YES completion:nil];

        
    }
    
    
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
