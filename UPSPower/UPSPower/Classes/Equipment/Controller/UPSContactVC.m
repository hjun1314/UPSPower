//
//  UPSContactVC.m
//  UPSPower
//
//  Created by hjun on 2017/12/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSContactVC.h"
#import "UPSMainModel.h"
#import "UPSParentGroupModel.h"
#import "UPSGroupUPSModel.h"
#import "UPSAddGroup.h"
@interface UPSContactVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSIndexPath *_indexPath; // 保存当前选中的单元格
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *addHeadView;

@property (nonatomic,strong)UPSMainModel *mainModel;


@end

@implementation UPSContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分组管理";
    [self initUI];
    UPSMainModel *mainModel = [UPSMainModel sharedUPSMainModel];
    self.mainModel = mainModel;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)initUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(clickEditBtn:)];
    self.tableView.hidden = NO;
}

- (void)clickEditBtn:(UIBarButtonItem *)sender {
//    NSLog(@"点击了编辑按钮");
    //设置tableView的编辑状态
    _tableView.editing = !_tableView.editing;
    if (_tableView.isEditing == YES) {
        sender.title = @"完成";
    } else {
        sender.title = @"编辑";
    }
}

#pragma mark- 懒加载视图
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.addHeadView;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.tableFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIView *)addHeadView {
    if(_addHeadView == nil) {
        _addHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
        _addHeadView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 14, 32, 32)];
        imageView.image = [UIImage imageNamed:@"add.png"];
        [_addHeadView addSubview:imageView];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(52, 0, 100, 60)];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.text = @"添加分组";
        [_addHeadView addSubview:label];
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 60 - 0.5, kScreenW, 0.5)];
        view1.backgroundColor = RGB_HEX(0xC8C7CC);
        [_addHeadView addSubview:view1];
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        addBtn.frame = CGRectMake(0, 0, kScreenW, 60);
        [addBtn addTarget:self action:@selector(addGroupAlert) forControlEvents:UIControlEventTouchUpInside];
        [_addHeadView addSubview:addBtn];
        [_tableView.tableHeaderView addSubview:_addHeadView];
    }
    return _addHeadView;
}

/** 弹出框 */
- (void)addGroupAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加分组" message:@"请输入新的分组名称" preferredStyle:UIAlertControllerStyleAlert];
    //添加有文本输入框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入分组名";
        //设置文本清空按钮
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 读取文本框的值显示出来
        UITextField *addGroupTF = alert.textFields.firstObject;
        // 发送添加请求...http://192.168.1.147:12345/ups-interface/addGroup
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;
        params[@"userId"] = @(self.mainModel.userId);
        params[@"newGroupName"] = addGroupTF.text;
        [[UPSHttpNetWorkTool sharedApi]POST:@"addGroup" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"添加组成功%@",responseObject);
            NSDictionary *dictM = responseObject[@"data"];
            NSMutableArray *addGroupArr = [NSMutableArray array];
            UPSAddGroup *addGroup = [UPSAddGroup mj_objectWithKeyValues:dictM];
            [addGroupArr addObject:addGroup];
            [self.parentGroup addObject:addGroupArr.firstObject];
            [self.tableView reloadData];
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark- UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.parentGroup.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //if (indexPath.row != 0) {
    cell.textLabel.textColor = RGB_HEX(0x363636);
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    UPSParentGroupModel *model = _parentGroup[indexPath.row];
    cell.textLabel.text = model.groupName;
    // }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中后的高亮状态(默认是：选中单元格后一直处于高亮状态，直到下次重新选择)
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _indexPath = indexPath;
    //    if (indexPath.row != 0) {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改分组名" message:@"请输入新的分组名称" preferredStyle:UIAlertControllerStyleAlert];
    //添加有文本输入框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入分组名";
        //设置文本清空按钮
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 读取文本框的值显示出来
        UITextField *alterGroupTF = alert.textFields.firstObject;
        //            NSLog(@"新修改的分组名：%@", alterGroupTF.text);
        // 发送修改请求...http://192.168.1.147:12345/ups-interface/updateGroupName
        NSMutableArray *parentArr = [NSMutableArray array];
        for (int i = 0; i < self.parentGroup.count; i++) {
            UPSParentGroupModel *parentG = [UPSParentGroupModel mj_objectWithKeyValues:self.parentGroup[i]];
            [parentArr addObject:parentG];
            if (alterGroupTF.text == parentG.groupName) {
                [SVProgressHUD showErrorWithStatus:@"组名不能重复"];
            }
        }
        UPSParentGroupModel *dModel = _parentGroup[indexPath.section];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;
        params[@"userId"] = @(self.mainModel.userId);
        params[@"groupId"] = @(dModel.groupId);
        params[@"newGroupName"] = alterGroupTF.text;
        //        if (alterGroupTF.text == dModel.groupName) {
        //            [SVProgressHUD showErrorWithStatus:@"组名不能重复"];
        //        }else{
        [[UPSHttpNetWorkTool sharedApi]POST:@"updateGroupName" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"组名修改成功%@",responseObject);
            dModel.groupName = alterGroupTF.text;
            [self.tableView reloadData];
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"组名修改失败%@",error);
        }];
        
        // }
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    // }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (indexPath.row == 0) {
    //        return 0;
    //  } else {
    return 50 / 375.0 * kScreenW;
    // }
}

/** 指定哪些行的 cell 可以进行编辑 (UITableViewDataSource 协议方法) */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //if (indexPath.row == 0) {
    // return NO; // 第一行不能编辑
    // } else {
    return YES;
    //}
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

#pragma mark --删除cell
/** 1.单元格返回的编辑风格(添加/删除/不可编辑,三种风格)(UITableViewDelegate协议中方法) */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

/** 2.提交编辑状态/效果 (UITableViewDataSource协议中方法) */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma mark- 点击 删除 按钮的操作
    //判断编辑状态是删除时
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UPSParentGroupModel *dModel = _parentGroup[indexPath.row];
        // 发送删除请求...
        ///http://192.168.1.147:12345/ups-interface/deleteGroup
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;
        params[@"userId"] = @(self.mainModel.userId);
        params[@"groupId"] = @(dModel.groupId);
        UPSGroupUPSModel *upsGroup = self.upsGroup[indexPath.row];
        if (upsGroup == nil) {
            [[UPSHttpNetWorkTool sharedApi]POST:@"deleteGroup" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"分组删除成功%@",responseObject);
                
                //if (dModel.memberNum == 0) {
                //  1. 更新数据源(数组): 根据indexPaht.row作为数组下标, 从数组中删除数据
                [self.groupModelArr removeObjectAtIndex:indexPath.row];
                // 2. TableView中 删除一个cell (以动画的形式删除指定的cell)
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"分组删除失败error");
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"该分组中有UPS设备信息，请移动后再进行删除"];
        }
        
    }
}

#pragma mark- 移动
/** 1.指定tableView那些行(cell)可以移动 */
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // if (indexPath.row == 0) {
    //  return NO; //cell不能移动
    //} else {
    return YES; //cell可以移动
    // }
}
/** 2.移动cell后的操作:数据源进行更新 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //1. 存储将要被移动的位置的对象
    NSString *str = [self.groupModelArr objectAtIndex:sourceIndexPath.row];
    //2. 将对象从原位置移除
    [self.groupModelArr removeObjectAtIndex:sourceIndexPath.row];
    //3. 将对象插入到新位置
    [self.groupModelArr insertObject:str atIndex:destinationIndexPath.row];
    //刷新表格
    [self.tableView reloadData];
}

//点击左边删除按钮时,显示的右边删除button的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除分组";
}

- (NSMutableArray *)groupModelArr {
    if(_parentGroup == nil) {
        _parentGroup = [[NSMutableArray alloc] init];
    }
    return _parentGroup;
}

#pragma mark- cell分割线左对齐(两个方法)
- (void)viewDidLayoutSubviews {
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}



@end
