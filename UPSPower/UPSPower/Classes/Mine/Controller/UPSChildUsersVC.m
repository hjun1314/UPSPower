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
@interface UPSChildUsersVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UITextField *passwordField;



@end

@implementation UPSChildUsersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupUI];
    [self setupNotification];
    self.view.backgroundColor = [UIColor whiteColor];
//     _data = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
   
    _data = [NSMutableArray array];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UPSChileUserCellModel getName];
    [UPSChileUserCellModel getPassWord];
}
- (void)setNav{
    
    self.navigationItem.title = @"子用户管理";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBtn)];
    
}
- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickRightBtn{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"添加用户名和密码"
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"账号";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"密码";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
        textField.secureTextEntry = YES;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        self.nameField = namefield;
        //        [UPSChileUserCellModel saveName:self.nameField.text];
        UITextField * passwordfiled = textfields[1];
        self.passwordField = passwordfiled;
        //        [UPSChileUserCellModel savePassword:self.passwordField.text];
        //        passwordfiled.text = [UPSChileUserCellModel getPassWord];
        ///添加cell
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSString *s = @"";
        [_data addObject:s];
        NSInteger row = self.data.count;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [indexPaths addObject: indexPath];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)setupUI{
    ///tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 35, kScreenW, kScreenH - SafeAreaTopHeight - SafeAreaTabbarHeight - 35)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    ///titleView
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, 35)];
    titleView.backgroundColor = UICOLOR_RGB(245, 245, 245, 1);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    [self setupTitleViewBtn];
    
//    ///按钮点击
//    UIButton *btn = [[UIButton alloc]init];
//    [self.view addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//    make.bottom.equalTo(self.view.mas_bottom).offset(-80);
//        make.height.offset(40);
//        make.width.offset(80);
//    }];
//    [btn setBackgroundColor:[UIColor cyanColor]];
////    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setTitle:@"添加" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupTitleViewBtn{
    NSArray *titles = @[@"用户名",@"密码",@"操作"];
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

#pragma mark- 删除按钮点击方法
- (void)setupNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickDeleteBtn:) name:@"didDeleteBtn" object:nil];
}
- (void)didClickDeleteBtn:(UIButton *)btn{
    NSArray *visiblecells = [self.tableView visibleCells];
    for (UPSChildUserCell *cell in visiblecells) {
        if (cell.tag == btn.tag) {
            [_data removeObjectAtIndex:cell.tag];
            [self.tableView reloadData];
        }
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark- uitableviewDelegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CELL";
    UPSChildUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UPSChildUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//
//        UITextField *nameLabel = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, kScreenW / 3, 30)];
//        nameLabel.textAlignment = NSTextAlignmentCenter;
//        nameLabel.borderStyle = UITextBorderStyleNone;
//        nameLabel.textAlignment = NSTextAlignmentCenter;
//        nameLabel.userInteractionEnabled = NO;
//        nameLabel.text = self.nameField.text;
//
//        [cell.contentView addSubview:nameLabel];
//
//        UITextField *passwordLabel = [[UITextField alloc]initWithFrame:CGRectMake(kScreenW / 3, 0, kScreenW / 3, 30)];
//        passwordLabel.borderStyle = UITextBorderStyleNone;
//        passwordLabel.secureTextEntry = YES;
//        passwordLabel.textAlignment = NSTextAlignmentCenter;
//        passwordLabel.userInteractionEnabled = NO;
//        passwordLabel.text = self.passwordField.text;
//        [cell.contentView addSubview:passwordLabel];
//
//        UIButton *fixBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenW / 3)*2, 0, kScreenW / 6, 30)];
//        [fixBtn setImage:[UIImage imageNamed:@"fix"] forState:UIControlStateNormal];
//        [cell.contentView addSubview:fixBtn];
//
//
//        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenW / 3) * 2 + kScreenW /6, 0, kScreenW / 6, 30)];
//        [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//        [cell.contentView addSubview:deleteBtn];
//        [deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.row;
    cell.btnClick = ^{
        NSLog(@"点击了哪一行。。。%ld",(long)indexPath.row);
    };
    cell.nameLabel.text = self.nameField.text;
    cell.passwordLabel.text = self.passwordField.text;
    [UPSChileUserCellModel saveName:cell.nameLabel.text];
    [UPSChileUserCellModel savePassword:cell.passwordLabel.text];
//    
    return cell;
    
}
- (void)clickDeleteBtn:(UIButton *)btn{
    
    NSArray *visiblecells = [self.tableView visibleCells];
    for(UITableViewCell *cell in visiblecells)
    {
        if(cell.tag == btn.tag)
        {
            [_data removeObjectAtIndex:cell.tag];
            [_data removeLastObject];
//            NSLog(@"%ld cell.tag",cell.tag);
            // 定义按钮的功能，现在为删除
            [_tableView reloadData];
            //break;
        }
    }
}
#pragma mark- 代理方法
///让TableView 进入编辑状态
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    /** 首先调用父类的方法. */
    [super setEditing:editing animated:animated];
    
    /** 使tableView处于编辑状态. */
    [self.tableView setEditing:editing animated:animated];
}

///指定哪行cell可以进行编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


///指定cell的编辑状态（删除还是插入）
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 不同的行, 可以设置不同的编辑样式, 编辑样式是一个枚举类型 */
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleInsert;
    }
}

///指定 tableView 哪些行(cell) 可以移动 (UITableViewDataSource协议方法)

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 指定哪些行(cell)可以移动 */
    if (0 == indexPath.row) {
        return NO;  /**< NO cell不能移动 */
    } else {
        return YES; /**< YES cell可以移动 */
    }
}
///3 . 移动 cell 后的操作: 数据源进行更新

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    /**  1. 从原位置移除,在从原位置移除之前, 需要保存一下原位置的数据, 同时持有一次. */
    NSString *str = [self.data objectAtIndex:sourceIndexPath.row];
    
    [self.data removeObjectAtIndex:sourceIndexPath.row];
    
    /** 2. 添加到目的位置, 同时释放一次 */
    [self.data insertObject:str atIndex:destinationIndexPath.row];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_data removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        /** 1. 更新数据源:向数组中添加数据. */
        [self.data insertObject:@"abcd" atIndex:indexPath.row];
        
        /** 2. TableView中插入一个cell. */
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
      
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
