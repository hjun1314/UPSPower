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
@interface UPSEquipmentVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSIndexPath *_indexPath; // 保存当前选中的单元格
}

@property (nonatomic,strong)UITableView *tableView;
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



@end

@implementation UPSEquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    //[self setupTableView];
    //    [self setupNotification];
    [self loadData];
}

- (void)setupNav{
    self.navigationItem.title = @"设备状态";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarItem)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.tableView.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)loadData{
    UPSMainModel *mainModel = [UPSMainModel sharedUPSMainModel];
    self.mainModel = mainModel;
    
    self.parentData = [NSMutableArray array];
    self.upsData = [NSMutableArray array];
    
    ///刷新设备列表http://192.168.1.147:12345/ups-interface/refreshUpsList
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = mainModel.token;
    params[@"userId"] = @(mainModel.userId);
    [[UPSHttpNetWorkTool sharedApi]POST:@"refreshUpsList" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *parentData = responseObject[@"data"][@"parentGroup"];
        NSLog(@"设备列表%@",responseObject);
        NSMutableArray *parentM = [NSMutableArray array];
        for (int i = 0; i < parentData.count; i++) {
            UPSParentGroupModel *p = [UPSParentGroupModel mj_objectWithKeyValues:parentData[i]];
            [parentM addObject:p];
            // 加个判断，防止多次重复调用这个方法时，造成数据累加无限添加
            if (self.switchArr.count < parentData.count) {
                [self.switchArr addObject:@NO];
            }
        }
        self.parentData = parentM;
        
        //解析groupUps
        NSMutableArray *upsData = responseObject[@"data"][@"groupUps"];
        NSMutableArray *upsM = [NSMutableArray array];
        for (int i = 0; i < upsData.count; i++) {
            UPSGroupUPSModel *u = [UPSGroupUPSModel mj_objectWithKeyValues:upsData[i]];
            [upsM addObject:u];
        }
        self.upsData = upsM;
        
        [self.tableView reloadData];
    }
                                   fail:^(NSURLSessionDataTask *task, NSError *error) {
                                       
                                   }];
    
    
}
- (void)clickRightBarItem{
    
    UPSContactVC *contactVc = [[UPSContactVC alloc]init];
    contactVc.parentGroup = self.parentData;
    [self.navigationController pushViewController:contactVc animated:YES];
    //    ///添加分组
    //    ///http://192.168.1.147:12345/ups-interface/addGroup
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加分组" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //        textField.placeholder = @"请输入新分组名称";
    //    }];
    //    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //        params[@"token"] = self.mainModel.token;;
    //        params[@"userId"] = @(self.mainModel.userId);
    //        params[@"newGroupName"] = alert.textFields[0].text;
    //
    //        [[UPSHttpNetWorkTool sharedApi]POST:@"addGroup" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
    //
    //            NSDictionary *dict = responseObject[@"data"];
    //            NSMutableArray *dataM = [NSMutableArray array];
    //            UPSAddGroup *add = [UPSAddGroup mj_objectWithKeyValues:dict];
    //            [dataM addObject:add];
    //
    //            NSLog(@"%@添加分组成功",responseObject);
    //
    //        } fail:^(NSURLSessionDataTask *task, NSError *error) {
    //            NSLog(@"添加分组失败%@",error);
    //
    //        }];
    //    }];
    //    [alert addAction:cancel];
    //    [alert addAction:sure];
    //    [self presentViewController:alert animated:YES completion:nil];
}

/////头部长按点击
//- (void)clickHeadViewBtn:(NSNotification *)info{
//
//
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入新修改组的名称" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"修改组名称";
//    }];
//
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:cancel];
//    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"token"] = self.mainModel.token;
//        params[@"userId"] = @(self.mainModel.userId);
//        params[@"groupId"] = @(self.parentModel.groupId);
//
//        [[UPSHttpNetWorkTool sharedApi]POST:@"deleteGroup" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//
//            NSLog(@"删除组成功%@",responseObject);
//
//        } fail:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"删除组失败%@",error);
//        }];
//
//
//    }];
//    [alert addAction:delete];
//    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        ///测试更改分组
//        //http://192.168.1.147:12345/ups-interface/updateGroupName
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"token"] = self.mainModel.token;;
//        params[@"userId"] = @(self.mainModel.userId);
//        params[@"newGroupName"] = alert.textFields[0].text;
//        params[@"groupId"] = @(self.parentModel.groupId);
//        [[UPSHttpNetWorkTool sharedApi]POST:@"updateGroupName" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"更改用户名成功%@",responseObject);
//            self.parentModel.groupName = alert.textFields[0].text;
//
//        } fail:^(NSURLSessionDataTask *task, NSError *error) {
//
//        }];
//
//
//    }];
//    [alert addAction:sure];
//    [self presentViewController:alert animated:YES completion:nil];
//
//}
//
//
//#pragma mark- 创建点击通知
//- (void)setupNotification{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickUnknownBtn) name:@"clickUnknownBtn" object:nil];
//    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickFaultBtn) name:@"clickFaultBtn" object:nil];
//    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickNormalBtn) name:@"clickNormalBtn" object:nil];
//}
//- (void)clickUnknownBtn{
//    UPSUnknownVC *unknown = [[UPSUnknownVC alloc]init];
//    [self.navigationController pushViewController:unknown animated:YES];
//
//    ///更改UPS名称http://192.168.1.147:12345/ups-interface/updateUpsName
//    //
//    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    //    params[@"token"] = self.mainModel.token;;
//    //    params[@"userId"] = @(self.mainModel.userId);
//
//
//}
////- (void)clickFaultBtn{
////    UPSFaultVC *fault = [[UPSFaultVC alloc]init];
////    [self.navigationController pushViewController:fault animated:YES];
////}
////- (void)clickNormalBtn{
////    UPSNormalVC *normal = [[UPSNormalVC alloc]init];
////    [self.navigationController pushViewController:normal animated:YES];
////
////}
//
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}
//
//
//#pragma mark- 代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.parentData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //
    //    UPSGroupUPSModel *parentModel = self.upsData[section];
    if ([self.switchArr[section] boolValue] == YES) {
        return self.upsData.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    UPSGroupUPSModel *upsGroup = self.upsData[indexPath.row];
    cell.textLabel.text = upsGroup.userDefinedUpsName;
    cell.detailTextLabel.text = upsGroup.originalUpsName;
    // 添加单元格的长按手势
    //    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
    //    longPressed.minimumPressDuration = 1;
    //    [cell.contentView addGestureRecognizer:longPressed];
    return cell;
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    // 取消选中后的高亮状态(默认是：选中单元格后一直处于高亮状态，直到下次重新选择)
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _indexPath = indexPath;
    // 获取当前UPS设备对象,并传给详情页面
    //    BRGroupModel *gModel = self.groupModelArr[indexPath.section];
    //    BRContactsModel *model = gModel.contacts[indexPath.row];
    //    NSLog(@"点击了：%@", model.name);
}
///** 长按手势的执行方法 */
//- (void)longPressToDo:(UILongPressGestureRecognizer *)gesture {
//    if(gesture.state == UIGestureRecognizerStateBegan) {
//        CGPoint point = [gesture locationInView:self.tableView];
//        _indexPath = [self.tableView indexPathForRowAtPoint:point];
//        // 弹出框
//        [self gestureAlert];
//        if(_indexPath == nil) return ;
//    }
//}
///** 弹出框方法 */
//- (void)gestureAlert {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击了删除");
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"移至分组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击了移至分组");
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [self presentViewController:alert animated:YES completion:nil];
//}
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
    groupLable.text = [NSString stringWithFormat:@"%@", model.groupName];
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

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    //1. 存储将要被移动的位置的对象
//    NSString *str = [self.upsData objectAtIndex:sourceIndexPath.row];
//    //2. 将对象从原位置移除
//    [self.upsMoveData removeObjectAtIndex:sourceIndexPath.row];
//    //3. 将对象插入到新位置
//    [self.upsMoveData insertObject:str atIndex:destinationIndexPath.row];
//    //刷新表格
//    [self.tableView reloadData];
//}


#pragma mark- 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTopHeight - SafeAreaTabbarHeight)];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
