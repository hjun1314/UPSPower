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
@interface UPSEquipmentVC ()<YUFoldingTableViewDelegate>

@property (nonatomic,strong)YUFoldingTableView *tableView;
@property (nonatomic, assign)YUFoldingSectionHeaderArrowPosition arrowPosition;
@property (nonatomic,assign)BOOL isOpen;


@property (nonatomic,strong)UPSMainModel *mainModel;
@property (nonatomic,strong)UPSParentGroupModel *parentModel;
///parentGroup相关
//@property (nonatomic,strong)NSMutableArray *parentArr;
@property (nonatomic,strong)NSMutableArray *parentData;
///upsGroup相关
//@property (nonatomic,strong)NSMutableArray *upsArr;
@property (nonatomic,strong)NSMutableArray *upsData;




@end

@implementation UPSEquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
    [self setupNotification];
     UPSMainModel *mainModel = [UPSMainModel sharedUPSMainModel];
    self.mainModel = mainModel;
//    self.parentArr = self.mainModel.parentGroup;
//    self.upsArr = self.mainModel.groupUps;
    ///解析parentGroup
    NSMutableArray *parentG = [NSMutableArray array];
    for (int i = 0; i < self.mainModel.parentGroup.count; i++) {
        UPSParentGroupModel *p = [UPSParentGroupModel mj_objectWithKeyValues:self.mainModel.parentGroup[i]];
        [parentG addObject:p];
    }
    self.parentData = parentG;
    
    ///解析groupUps
    NSMutableArray *upsG = [NSMutableArray array];
    for (int i = 0; i < self.mainModel.groupUps.count; i++) {
        UPSGroupUPSModel *u = [UPSGroupUPSModel mj_objectWithKeyValues:self.mainModel.groupUps[i]];
        [upsG addObject:u];
    }
    self.upsData = upsG;
}

- (void)setupNav{
    self.navigationItem.title = @"设备状态";
    self.navigationItem.hidesBackButton = YES;
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

   
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入新修改组的名称" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"修改组名称";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"token"] = self.mainModel.token;
                params[@"userId"] = @(self.mainModel.userId);
                params[@"groupId"] = @(self.parentModel.groupId);
        
            [[UPSHttpNetWorkTool sharedApi]POST:@"deleteGroup" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                
                    NSLog(@"删除组成功%@",responseObject);
        
                } fail:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"删除组失败%@",error);
                }];
        

    }];
    [alert addAction:delete];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ///测试更改分组
        //http://192.168.1.147:12345/ups-interface/updateGroupName
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;;
        params[@"userId"] = @(self.mainModel.userId);
        params[@"newGroupName"] = alert.textFields[0].text;
        params[@"groupId"] = @(self.parentModel.groupId);
        [[UPSHttpNetWorkTool sharedApi]POST:@"updateGroupName" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"更改用户名成功%@",responseObject);
        self.parentModel.groupName = alert.textFields[0].text;
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        
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
    return self.parentData.count;
}

-(YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
    return self.arrowPosition ? :YUFoldingSectionHeaderArrowPositionLeft;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
//   UPSGroupUPSModel *groupM = self.upsData[section];
   NSArray *array = [self.parentData objectAtIndex:section];
//    NSLog(@"array.count%lu",(unsigned long)array.count);
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
    
    UPSParentGroupModel *parentModel = self.parentData[section];
    
    return parentModel.groupName;
}

- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    UPSGroupUPSModel *groupM = self.upsData[indexPath.section];
//    UPSGroupUPSModel *dd =  groupM[indexPath.row];
  //  [cell.normal setTitle:groupM.upsName forState:UIControlStateNormal];
    cell.textLabel.text = groupM.userDefinedUpsName;
    cell.detailTextLabel.text = groupM.originalUpsName;
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


- (NSArray<UITableViewRowAction *> *)yuTableView:(YUFoldingTableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    return @[rowAction,deleteAction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
