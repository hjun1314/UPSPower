//
//  UPSEquipmentVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSEquipmentVC.h"
//#import "YUFoldingTableView.h"
#import "UPSEquipmentCell.h"
#import "UPSNormalVC.h"
#import "UPSUnknownVC.h"
#import "UPSFaultVC.h"
#import "UPSParentGroupModel.h"
#import "UPSMainModel.h"
#import "UPSMainVC.h"
#import "UPSAddGroup.h"
#import "UPSGroupUPSModel.h"
#import "UPSContactVC.h"
#import "UPSBaseInfoVC.h"
#import "CPMoveCellTableView.h"
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
@interface UPSEquipmentVC ()<UITableViewDelegate,UITableViewDataSource,CPMoveCellTableViewDelegate,CPMoveCellTableViewDataSource>{
    NSIndexPath *_indexPath; // 保存当前选中的单元格
}

@property (nonatomic,strong)CPMoveCellTableView *tableView;
/** 保存分组数据模型 */
//@property (nonatomic, strong) NSMutableArray *groupModelArr;
/** 保存旋转状态(展开/折叠) */
@property (nonatomic, strong) NSMutableArray *switchArr;


@property (nonatomic,strong)UPSMainModel *mainModel;
@property (nonatomic,strong)UPSParentGroupModel *parentModel;
///parentGroup相关
//@property (nonatomic,strong)NSMutableArray *parentArr;
@property (nonatomic,strong)NSMutableArray *parentData;
///upsGroup相关
//@property (nonatomic,strong)NSMutableArray *upsArr;
@property (nonatomic,strong)NSMutableArray *upsData;

@property (nonatomic,strong)NSMutableArray *upsMoveData;

@property (nonatomic,strong)NSMutableArray *cellData;

///修改ups设备名称
@property (nonatomic,strong)UITextField *textField;



@end

@implementation UPSEquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    //[self setupTableView];
    //    [self setupNotification];
    UPSMainModel *mainModel = [UPSMainModel sharedUPSMainModel];
    self.mainModel = mainModel;
    [self loadData];
    
    
  
    
    

}

- (void)setupNav{
    self.navigationItem.title = @"设备状态";
//    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarItem)];
   
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.tableView.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)loadData{

    self.parentData = [NSMutableArray array];
    self.upsData = [NSMutableArray array];
    
    ///刷新设备列表http://192.168.1.147:12345/ups-interface/refreshUpsList
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;
    params[@"userId"] = @(self.mainModel.userId);
    [[UPSHttpNetWorkTool sharedApi]POST:@"refreshUpsList" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *parentData = responseObject[@"data"][@"parentGroup"];
        NSMutableArray *upsData = responseObject[@"data"][@"groupUps"];
        NSMutableArray *upsM = [NSMutableArray array];
        NSLog(@"设备列表%@",responseObject);
        NSMutableArray *parentM = [NSMutableArray array];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i = 0; i < parentData.count; i++) {
            UPSParentGroupModel *p = [UPSParentGroupModel mj_objectWithKeyValues:parentData[i]];
            [parentM addObject:p];
            
           
//            p.groupCellData = tempArr;
            
            // 加个判断，防止多次重复调用这个方法时，造成数据累加无限添加
            if (self.switchArr.count < parentData.count) {
                [self.switchArr addObject:@NO];
            }
           
        }
        for (int j = 0; j < upsData.count; j++) {
            UPSGroupUPSModel *u = [UPSGroupUPSModel mj_objectWithKeyValues:upsData[j]];
            [upsM addObject:u];
        }
        NSMutableArray *totalArray = [NSMutableArray arrayWithArray:parentM];
        [totalArray addObjectsFromArray:upsM];
        self.cellData = totalArray;
        
        self.parentData = parentM;
        self.upsData = upsM;
       // NSMutableArray *p = [NSMutableArray array];
       // NSMutableArray *u = [NSMutableArray array];
//        for (UPSParentGroupModel *parentModel in p) {
//            NSInteger groupId = parentModel.groupId;
//            for (UPSGroupUPSModel *upsModel in u) {
//                if (groupId == upsModel.groupId) {
//                    [tempArr addObject:upsModel];
//                }
//            }
//            parentModel.groupCellData = tempArr;
//        }
        
        [self.tableView reloadData];
    }
                                   fail:^(NSURLSessionDataTask *task, NSError *error) {
                                       
                                   }];
    
    
}

- (void)clickRightBarItem{
    
    UPSContactVC *contactVc = [[UPSContactVC alloc]init];
    contactVc.parentGroup = self.parentData;
    contactVc.upsGroup = self.upsData;
    [self.navigationController pushViewController:contactVc animated:YES];
    
}


#pragma mark- 代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.parentData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    UPSParentGroupModel *parentModel = self.parentData[section];
        UPSGroupUPSModel *upsModel = self.upsData[section];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (UPSParentGroupModel *parentModel in self.parentData) {
        NSInteger ID = parentModel.groupId;
     
        for (UPSGroupUPSModel *upsModel in self.upsData) {
            if (ID == upsModel.groupId ) {
                [tempArr addObject:upsModel];
            }
        }
        parentModel.groupCellData = tempArr;
    }
    self.cellData = tempArr;
  
//    if (parentModel.groupId == upsModel.groupId) {
//
//    }
    
//    NSLog(@"parentModel.groupId。。。。。%ld",(long)parentModel.groupId);
//    NSLog(@"upsModel.groupId------%ld",(long)upsModel.groupId);
    if ([self.switchArr[section] boolValue] == YES ) {
        return  self.upsData.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    UPSGroupUPSModel *upsGroup = self.cellData[indexPath.row];
    UPSParentGroupModel *parentGroup = self.parentData[indexPath.section];
    if (upsGroup.groupId == parentGroup.groupId) {
        cell.textLabel.text = upsGroup.userDefinedUpsName;
        cell.detailTextLabel.text = upsGroup.originalUpsName;

    }
    // 添加单元格的长按手势
//      UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognized:)];
//    [cell addGestureRecognizer:longPress];
    return cell;
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self.view endEditing:YES];
    // 取消选中后的高亮状态(默认是：选中单元格后一直处于高亮状态，直到下次重新选择)
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    _indexPath = indexPath;
    UPSGroupUPSModel *upsGroup = self.upsData[indexPath.row];
    ///查看ups历史数据http://192.168.1.147:12345/ups-interface/checkUpsSituation
    ///显示ups基本信息http://192.168.1.147:12345/ups-interface/checkUpsBaseParameter
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;
    params[@"userId"] = @(self.mainModel.userId);
    params[@"upsId"] = @(upsGroup.id);
    [[UPSHttpNetWorkTool sharedApi]POST:@"checkUpsBaseParameter" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        UPSBaseInfoVC *baseVC = [[UPSBaseInfoVC alloc]init];
        [self.navigationController pushViewController:baseVC animated:YES];
        NSLog(@"%@获取UPS历史数据成功@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取ups历史数据失败%@",error);
    }];
    
}


//
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60 / 375.0 * kScreenW;
}
// 分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50 / 375.0 * kScreenW;
}
//// 分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        return 10.0f;
//    } else {
        return 1.0f;
    //}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320 / 375.0 * kScreenW, 50 / 375.0 * kScreenW)];
    view.backgroundColor = [UIColor whiteColor];
    // 边界线
    UIView *borderView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 / 375.0 * kScreenW, kScreenW, 0.5)];
    borderView.backgroundColor = RGB_HEX(0xC8C7CC);
    [view addSubview:borderView];
    //    // 展开箭头
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15 / 375.0 * kScreenW, 19 / 375.0 * kScreenW, 14 / 375.0 * kScreenW, 12 / 375.0 * kScreenW)];
    imageView.image = [UIImage imageNamed:@"pulldownList.png"];
    [view addSubview:imageView];
    // 分组名Label
    UILabel *groupLable = [[UILabel alloc]initWithFrame:CGRectMake(45 / 375.0 * kScreenW, 0, kScreenW, 50 / 375.0 * kScreenW)];
    UPSParentGroupModel *model = _parentData[section];
    groupLable.text =  model.groupName;
    //    groupLable.text = @"哈根达斯";
    groupLable.textColor = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1.0];
    groupLable.font = [UIFont systemFontOfSize:16];
    [view addSubview:groupLable];
    view.userInteractionEnabled = YES;
    // 初始化一个手势
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openClick:)];
    // 给view添加手势
    [view addGestureRecognizer:myTap];
    view.tag = 1000 + section;
    
    CGFloat rota;
    if ([self.switchArr[section] boolValue] == NO) {
        rota = 0;
    } else {
        rota = M_PI_2; //π/2
    }
    imageView.transform = CGAffineTransformMakeRotation(rota);//箭头偏移π/2
    return view;
}

- (void)openClick:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    NSInteger section = sender.view.tag - 1000;
    if ([self.switchArr[section] boolValue] == NO) {
        [self.switchArr replaceObjectAtIndex:section withObject:@YES];
    } else {
        [self.switchArr replaceObjectAtIndex:section withObject:@NO];
    }
    if (section >= 0) {
        // 刷新分区
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *clearView = [[UIView alloc]init];
    clearView.backgroundColor = [UIColor clearColor];
    return clearView;
}
#pragma mark- 移动修改cell

/** 1.指定tableView那些行(cell)可以移动 */
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // if (indexPath.row == 0) {
    //  return NO; //cell不能移动
    //} else {
    return YES; //cell可以移动
    // }
}
/** 2.移动cell后的操作:数据源进行更新 */
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    //1. 存储将要被移动的位置的对象
//    NSString *str = [self.upsData objectAtIndex:sourceIndexPath.row];
//    //2. 将对象从原位置移除
//    [self.upsData removeObjectAtIndex:sourceIndexPath.row];
//    //3. 将对象插入到新位置
//    [self.upsData insertObject:str atIndex:destinationIndexPath.row];
//    //刷新表格
//    [self.tableView reloadData];
//}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController * editAlert = [UIAlertController alertControllerWithTitle:@"修改ups设备名称" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            self.textField = textField;
        }];
       
        [self presentViewController:editAlert animated:YES completion:nil];
        
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [editAlert addAction:action3];
        UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //修改UPS设备名称http://192.168.1.147:12345/ups-interface/updateUpsName
            UPSGroupUPSModel *upsGroup = self.upsData[indexPath.row];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"token"] = self.mainModel.token;
            params[@"userId"] = @(self.mainModel.userId);
            params[@"upsId"] = @(upsGroup.id);
            params[@"newUpsName"] = self.textField.text;
            [[UPSHttpNetWorkTool sharedApi]POST:@"updateUpsName" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                upsGroup.userDefinedUpsName = self.textField.text;
                [self.tableView reloadData];
                [SVProgressHUD showSuccessWithStatus:@"设备名修改成功"];
//                NSLog(@"设备名修改成功%@",responseObject);
                
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
//                NSLog(@"设备名修改失败%@",error);
            }];
            
            
            
           
        }];
        [editAlert addAction:action4];
    }];
    
    
    
    return @[editAction];
}
#pragma mark- 移动cell相关
//必选
- (NSArray *)originalArrayDataForTableView:(CPMoveCellTableView *)tableView{
    return _upsData;
}

- (void)tableView:(CPMoveCellTableView *)tableView newArrayDataForDataSource:(NSArray *)newArray{
    _upsData = [NSMutableArray arrayWithArray:newArray];
}

#pragma mark- 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[CPMoveCellTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTopHeight - SafeAreaTabbarHeight)style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSMutableArray *)switchArr {
    if (!_switchArr) {
        _switchArr = [[NSMutableArray alloc]init];
    }
    return _switchArr;
}

- (NSMutableArray *)upsMoveData{
    if (_upsMoveData == nil) {
        _upsMoveData = [NSMutableArray array];
    }
    return _upsMoveData;
}
- (NSMutableArray *)cellData{
    if (_cellData == nil) {
        _cellData = [NSMutableArray array];
    }
    return _cellData;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
