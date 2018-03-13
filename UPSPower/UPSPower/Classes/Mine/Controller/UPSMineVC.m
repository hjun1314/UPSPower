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
#import "UPSChangePasswordVC.h"
#import "AppDelegate.h"
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
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - SafeAreaTabbarHeight)];
    UIView *foot = [[UIView alloc]initWithFrame:CGRectZero];
    tableView.tableFooterView = foot;
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
    if (self.mainModel.userChildren == YES) {
        return 3;
    }else{
        return 5;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"mineCell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
    }if (self.mainModel.userChildren == YES) {
        if (indexPath.row == 0 ) {
            cell.textLabel.text = @"修改密码";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"关于我们";
        }else{
            cell.textLabel.text = @"用户注销";
        }
    }else{
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
    }
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.mainModel.userChildren == YES) {
        if (indexPath.row == 0 ) {
            
            UPSChangePasswordVC *changeVC = [[UPSChangePasswordVC alloc]init];
            [self.navigationController pushViewController:changeVC animated:YES];
            
        }else if (indexPath.row == 1){
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
                    [(AppDelegate *)[UIApplication sharedApplication].delegate showWindowHome:@"logout"];
                    [SVProgressHUD showSuccessWithStatus:@"注销成功"];
                    
                } fail:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"注销失败");
                }];
                
                
                
            }];
            
            [alert addAction:cancel];
            [alert addAction:sure];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
    }else{
    
    if (indexPath.row == 0 ) {

        UPSChangePasswordVC *changeVC = [[UPSChangePasswordVC alloc]init];
        [self.navigationController pushViewController:changeVC animated:YES];
        
    }else if (indexPath.row == 1){
        
        UPSChildUsersVC *childUserVC = [[UPSChildUsersVC alloc]init];
        [self.navigationController pushViewController:childUserVC animated:YES];
        
    }else if (indexPath.row == 2){
       
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
                [(AppDelegate *)[UIApplication sharedApplication].delegate showWindowHome:@"logout"];
                [SVProgressHUD showSuccessWithStatus:@"注销成功"];
                
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"注销失败");
            }];
            
            
            
        }];
        
        [alert addAction:cancel];
        [alert addAction:sure];
        
        [self presentViewController:alert animated:YES completion:nil];

        
    }
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
