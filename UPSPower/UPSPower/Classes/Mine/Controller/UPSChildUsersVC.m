//
//  UPSChildUsersVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSChildUsersVC.h"
#import "UPSChildUserCell.h"
#import "UPSChileUserCellModel.h"
#import "UPSMainModel.h"
#import "UPSChildUserAccountModel.h"
#import "UPSAddChildModel.h"
@interface UPSChildUsersVC ()<UITableViewDelegate,UITableViewDataSource>{
    FMDatabase * dataBase;
    NSMutableArray * _usernameArr;
    NSMutableArray * _passwordArr;
    //    UIAlertController * _alert;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UITextField *passwordField;

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)UPSMainModel *mainModel;


@end

@implementation UPSChildUsersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    //[self setupFMDB];
    [self setupUI];
    UPSMainModel *model = [UPSMainModel sharedUPSMainModel];
    self.mainModel = model;
    ///显示子账号列表http://192.168.1.147:12345/ups-interface/getAccountList
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;
    params[@"userId"] = @(self.mainModel.userId);
    [[UPSHttpNetWorkTool sharedApi]POST:@"getAccountList" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"显示子账号列表%@",responseObject);
        //            NSMutableArray *tempArr = [NSMutableArray array];
        NSMutableArray *dict = responseObject[@"data"];
        //        NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:@"0", nil];
        self.dataArr = [UPSChildUserAccountModel mj_objectArrayWithKeyValuesArray:dict];
        //            for (int i = 0; i < dict.count; i++) {
        //                UPSChildUserAccountModel *account = [UPSChildUserAccountModel mj_objectWithKeyValues:dict[i]];
        //                [tempArr addObject:account];
        ////                [self.tableView reloadData];
        //            }
        //            self.dataArr = tempArr;
        //
        [self.tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void)setNav{
    
    self.navigationItem.title = @"子用户管理";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBtn)];
    
}
- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

///点击rightItem
- (void)clickRightBtn{
    //[self presentViewController:_alert animated:YES completion:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入账号密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"账号";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!alert.textFields[0].text||!alert.textFields[1].text) {
            return ;
        }
        
        ///http://192.168.1.147:12345/ups-interface/addChildrenAccount添加子账户
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;
        params[@"userId"] = @(self.mainModel.userId);
        params[@"username"] = alert.textFields[0].text;
        params[@"password"] = alert.textFields[1].text;
        
        [[UPSHttpNetWorkTool sharedApi]POST:@"addChildrenAccount" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"添加子账户成功%@",responseObject);
            NSMutableArray *tempArr = [NSMutableArray array];
            NSDictionary *dict = responseObject[@"data"];
            UPSAddChildModel *model = [UPSAddChildModel mj_objectWithKeyValues:dict];
            [tempArr addObject:model];
            //            alert.textFields[0].text = model.username;
            
            NSString *ChildrenUserId = responseObject[@"data"][@"childrenUserId"];
            [UPSAddChildModel saveChildrenUserId:[ChildrenUserId integerValue]];
            //            [self.dataArr addObject:@"0"];
            //            [self.dataArr addObjectsFromArray:tempArr];
            [self.tableView reloadData];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"添加子账户失败%@",error);
        }];
        
    }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}

- (void)setupUI{
    
    ///tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  35+SafeAreaTopHeight, kScreenW, kScreenH  - SafeAreaTabbarHeight - 35-SafeAreaTopHeight)style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    ///titleView
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, 35)];
    titleView.backgroundColor = UICOLOR_RGB(245, 245, 245, 1);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    [self setupTitleViewBtn];
    
    
}

- (void)setupTitleViewBtn{
    NSArray *titles = @[@"用户名",@"密码"];
    NSUInteger count = titles.count;
    
    CGFloat titleBtnW = self.titleView.width / count;
    CGFloat titleBtnH = self.titleView.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        [self.titleView addSubview:titleLabel];
        titleLabel.frame = CGRectMake(i * titleBtnW, 0, titleBtnW, titleBtnH);
        titleLabel.text = titles[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSString *str = self.dataArr[indexPath.row];
    //    if ([str isEqualToString:@"0"]) {
    UPSChildUserCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UPSChildUserCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    UPSAddChildModel *model = self.dataArr[indexPath.row];
    //        cell.textLabel.text = @"hahaha";
    //        cell.detailTextLabel.text = @"呵呵呵呵";
    //            cell.passwordLabel.text = _dataArr[indexPath.row];
    cell.passwordLabel.secureTextEntry = YES;
    cell.nameLabel.text = model.username;
    cell.passwordLabel.text = @"111111";
    return cell;
    //    }
    //        return nil;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UPSChildUserAccountModel *model = self.dataArr[indexPath.row];
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController * editAlert = [UIAlertController alertControllerWithTitle:@"修改账号密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            //            textField.text = _usernameArr[indexPath.row];
        }];
        [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            //            textField.text = _passwordArr[indexPath.row];
            textField.secureTextEntry = YES;
        }];
        [self presentViewController:editAlert animated:YES completion:nil];
        
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [editAlert addAction:action3];
        UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ///修改子账号名称
            /// http://192.168.1.147:12345/ups-interface/updateAccount
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"token"] = self.mainModel.token;;
            params[@"userId"] = @(self.mainModel.userId);
            params[@"childrenUserId"] = @(model.userId);
            params[@"newUsername"] = editAlert.textFields[0].text;
            params[@"password"] = editAlert.textFields[1].text;
            params[@"originalUsername"] = model.username;
            
            [[UPSHttpNetWorkTool sharedApi]POST:@"updateAccount" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"子账号修改成功%@",responseObject);
                
                [self.tableView reloadData];
                [SVProgressHUD showSuccessWithStatus:@"子账号名称修改成功"];
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"子账号修改失败%@",error);
            }];
        }];
        [editAlert addAction:action4];
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //        删除语句
        
        ///删除子账号http://192.168.1.147:12345/ups-interface/deleteChildrenAccount
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;;
        params[@"userId"] = @(self.mainModel.userId);
        params[@"childrenUserId"] = @(model.userId);
        [[UPSHttpNetWorkTool sharedApi]POST:@"deleteChildrenAccount" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"删除子账号成功%@",responseObject);
            [self.dataArr removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self.tableView reloadData];
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"删除子账号失败%@",error);
        }];
        
    }];
    
    return @[editAction,deleteAction];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
