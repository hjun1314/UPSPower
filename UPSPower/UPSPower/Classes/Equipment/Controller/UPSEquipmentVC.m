//
//  UPSEquipmentVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSEquipmentVC.h"
#import "YUFoldingTableView.h"
#import "UPSEquipmentCell.h"
#import "UPSNormalVC.h"
#import "UPSUnknownVC.h"
#import "UPSFaultVC.h"
#import "UPSParentGroupModel.h"
#import "UPSMainModel.h"
#import "UPSMainVC.h"
#import "UPSAddGroup.h"
#import "UPSGroupUPSModel.h"
@interface UPSEquipmentVC ()<YUFoldingTableViewDelegate>{
    FMDatabase * dataBase;
    NSMutableArray * _usernameArr;
    NSMutableArray * _passwordArr;
    UIAlertController * _alert;
}

@property (nonatomic,strong)YUFoldingTableView *tableView;
@property (nonatomic, assign)YUFoldingSectionHeaderArrowPosition arrowPosition;
@property (nonatomic,assign)BOOL isOpen;


@property (nonatomic,strong)UPSMainModel *mainModel;


@end

@implementation UPSEquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
    [self setupNotification];
//     UPSMainModel *mainModel = [UPSMainModel sharedUPSMainModel];
//    self.mainModel = mainModel;
//   self.dataArr = mainModel.parentGroup;
//    NSLog(@"self.dataArr%@",self.dataArr);
    // 1 获取数据库对象
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path=[path stringByAppendingPathComponent:@"userInfo.sqlite"];
    
    dataBase=[FMDatabase databaseWithPath:path];
    // 2 打开数据库，如果不存在则创建并且打开
    BOOL open=[dataBase open];
    if(open){
        NSLog(@"数据库打开成功");
    }
    //3 创建表
    NSString * create1=@"CREATE TABLE IF NOT EXISTS A_user (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,username TEXT,password TEXT)";
    BOOL c1= [dataBase executeUpdate:create1];
    if(c1){
        NSLog(@"创建表成功");
    }
    
    _alert = [UIAlertController alertControllerWithTitle:@"请输入账号密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"账号";
    }];
    [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"密码";
    }];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [_alert addAction:action1];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!_alert.textFields[0].text||!_alert.textFields[1].text) {
            return ;
        }
        //        4 插入数据
        NSString * insertSql= @" INSERT INTO A_user(username, password)VALUES(?,?)";
        //    插入语句
        bool inflag1=[dataBase executeUpdate:insertSql,_alert.textFields[0].text,_alert.textFields[1].text];
        if(inflag1){
            NSLog(@"插入数据成功");
            [self selectForm];
            [self.tableView reloadData];
        }
    }];
    [_alert addAction:action2];
    
    _usernameArr = [[NSMutableArray alloc] init];
    _passwordArr = [[NSMutableArray alloc] init];
    
    self.tableView.tableFooterView = [UIView new];
    [self selectForm];

}
//数据库查询操作
- (void)selectForm{
    [_usernameArr removeAllObjects];
    [_passwordArr removeAllObjects];
    //    5查询数据FMDB的FMResultSet提供了多个方法来获取不同类型的数据
    NSString * sql=@" select * from A_user ";
    FMResultSet *result=[dataBase executeQuery:sql];
    
    while(result.next){
        NSString * username =[result stringForColumn:@"username"];
        [_usernameArr addObject:username];
        NSString * password =[result stringForColumn:@"password"];
        [_passwordArr addObject:password];
    }
}


- (void)setupNav{
    self.navigationItem.title = @"设备状态";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加分组" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarItem)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}
- (void)clickRightBarItem{
    ///添加分组
    ///http://192.168.1.147:12345/ups-interface/addGroup
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加分组" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新分组名称";
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;;
        params[@"userId"] = @(self.mainModel.userId);
        params[@"newGroupName"] = alert.textFields[0].text;
        
        [[UPSHttpNetWorkTool sharedApi]POST:@"addGroup" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary *dict = responseObject[@"data"];
            NSMutableArray *dataM = [NSMutableArray array];
            UPSAddGroup *add = [UPSAddGroup mj_objectWithKeyValues:dict];
            [dataM addObject:add];
            
            NSLog(@"%@添加分组成功",responseObject);
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"添加分组失败%@",error);
            
        }];
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)setupTableView{
    
    YUFoldingTableView *tableView = [[YUFoldingTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTabbarHeight - SafeAreaTopHeight )];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.foldingDelegate =self;
    
    if (self.arrowPosition) {
        tableView.foldingState = YUFoldingSectionStateShow;
    }
    
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, 35)];
//    headView.backgroundColor = UICOLOR_RGB(245, 245, 245, 1);
//    [self.view addSubview:headView];
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, headView.width, 25)];
//    title.text = @"设备";
//    [headView addSubview:title];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTab)];
//    [headView addGestureRecognizer:tap];
//    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickHeadViewBtn:) name:@"clickHeadView" object:nil];
   
}
///头部长按点击
- (void)clickHeadViewBtn:(NSNotification *)info{
//    UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"是否删除该组" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancel1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert1 addAction:cancel1];
//
//    UIAlertAction *sure1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        ///http://192.168.1.147:12345/ups-interface/deleteGroup
////        UPSParentGroupModel *parentG = [UPSParentGroupModel a];
////        NSMutableDictionary *params = [NSMutableDictionary dictionary];
////        params[@"token"] = self.mainModel.token;
////        params[@"userId"] = @(self.mainModel.userId);
////        params[@"groupId"] = @(parentG.groupId);
////
////        [[UPSHttpNetWorkTool sharedApi]POST:@"deleteGroup" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
////
////            NSLog(@"删除组成功%@",responseObject);
////
////        } fail:^(NSURLSessionDataTask *task, NSError *error) {
////            NSLog(@"删除组失败%@",error);
////        }];
////
////
//    }];
//    [alert1 addAction:sure1];
//    [self presentViewController:alert1 animated:YES completion:nil];
    
   
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入新修改组的名称" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"修改组名称";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:delete];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ///测试更改分组
        ///http://192.168.1.147:12345/ups-interface/updateUpsGroup
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;;
        params[@"userId"] = @(self.mainModel.userId);
        params[@"newGroupName"] = alert.textFields[0].text;
//        params[@"groupId"] = 
        
        
        
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark- 创建点击通知
- (void)setupNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickUnknownBtn) name:@"clickUnknownBtn" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickFaultBtn) name:@"clickFaultBtn" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickNormalBtn) name:@"clickNormalBtn" object:nil];
}
- (void)clickUnknownBtn{
    UPSUnknownVC *unknown = [[UPSUnknownVC alloc]init];
    [self.navigationController pushViewController:unknown animated:YES];
    
    ///更改UPS名称http://192.168.1.147:12345/ups-interface/updateUpsName
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"token"] = self.mainModel.token;;
//    params[@"userId"] = @(self.mainModel.userId);
    
    
}
//- (void)clickFaultBtn{
//    UPSFaultVC *fault = [[UPSFaultVC alloc]init];
//    [self.navigationController pushViewController:fault animated:YES];
//}
//- (void)clickNormalBtn{
//    UPSNormalVC *normal = [[UPSNormalVC alloc]init];
//    [self.navigationController pushViewController:normal animated:YES];
//
//}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark- 代理方法
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{   // UPSMainModel *mainModel = [UPSMainModel sharedUPSMainModel];
    return self.dataArr.count;
}

-(YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
    return self.arrowPosition ? :YUFoldingSectionHeaderArrowPositionLeft;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
//    UPSGroupUPSModel *groupM = self.upsArr[section];
//    NSArray *array = [self.upsArr objectAtIndex:section];
    return 1;
    
    
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    
    UPSParentGroupModel *parentModel = self.dataArr[section];
    
    return parentModel.groupName;
}

- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UPSGroupUPSModel *groupM = self.upsArr[indexPath.section];
//    UPSGroupUPSModel *dd =  groupM[indexPath.row];
  //  [cell.normal setTitle:groupM.upsName forState:UIControlStateNormal];
    cell.textLabel.text = groupM.upsName;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}


- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSLog(@"ddddd");
    }
}


- (NSArray<UITableViewRowAction *> *)yuTableView:(YUFoldingTableView *)yuTableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController * editAlert = [UIAlertController alertControllerWithTitle:@"修改账号密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            //            textField.text = _usernameArr[indexPath.row];
        }];
        [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            //            textField.text = _passwordArr[indexPath.row];
        }];
        [self presentViewController:editAlert animated:YES completion:nil];
        
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [editAlert addAction:action3];
        UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //    修改语句
            BOOL flag=  [dataBase executeUpdate:@" UPDATE A_user SET username = ?,password = ? WHERE id = ?;",editAlert.textFields[0].text,editAlert.textFields[1].text,@(indexPath.row+1)];
            if(flag){
                NSLog(@"修改成功");
                [self selectForm];
                [self.tableView reloadData];
            }
        }];
        [editAlert addAction:action4];
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //        删除语句
        BOOL dflag= [dataBase executeUpdate:@"delete from A_user WHERE username = ?",_usernameArr[indexPath.row]];
        if(dflag){
            NSLog(@"删除");
            [_usernameArr removeObjectAtIndex:indexPath.row];
            [_passwordArr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }
        
    }];
    
    return @[editAction,deleteAction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
