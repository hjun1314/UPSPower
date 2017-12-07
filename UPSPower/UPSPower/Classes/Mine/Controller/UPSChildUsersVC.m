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
@interface UPSChildUsersVC ()<UITableViewDelegate,UITableViewDataSource>{
    FMDatabase * dataBase;
    NSMutableArray * _usernameArr;
    NSMutableArray * _passwordArr;
    UIAlertController * _alert;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UITextField *passwordField;

@property (nonatomic,strong)UPSMainModel *mainModel;


@end

@implementation UPSChildUsersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupFMDB];
    [self setupUI];
    UPSMainModel *model = [UPSMainModel sharedUPSMainModel];
    self.mainModel = model;
    
   
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
     [self presentViewController:_alert animated:YES completion:nil];
}

- (void)setupUI{
    
    ///tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 35, kScreenW, kScreenH - SafeAreaTopHeight - SafeAreaTabbarHeight - 35)];
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

///数据库相关
- (void)setupFMDB{
    
    ///获取数据库对象
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"userInfo.sqlite"];
    dataBase = [FMDatabase databaseWithPath:path];
    
    ///打开数据库
    BOOL open = [dataBase open];
    
    ///创建表
    
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
        textField.secureTextEntry = YES;
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
        
        ///http://192.168.1.147:12345/ups-interface/addChildrenAccount添加子账户
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;
        params[@"userId"] = @(self.mainModel.userId);
        params[@"username"] = _alert.textFields[0].text;
        params[@"password"] = _alert.textFields[1].text;
        
        [[UPSHttpNetWorkTool sharedApi]POST:@"addChildrenAccount" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"添加子账户成功%@",responseObject);
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"添加子账户失败%@",error);
        }];
        
        
    }];
    [_alert addAction:action2];
    
    _usernameArr = [[NSMutableArray alloc] init];
    _passwordArr = [[NSMutableArray alloc] init];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _usernameArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UPSChildUserCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UPSChildUserCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.passwordLabel.text = _passwordArr[indexPath.row];
    cell.passwordLabel.secureTextEntry = YES;
    cell.nameLabel.text = _usernameArr[indexPath.row];

    return cell;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController * editAlert = [UIAlertController alertControllerWithTitle:@"修改账号密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = _usernameArr[indexPath.row];
        }];
        [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = _passwordArr[indexPath.row];
            textField.secureTextEntry = YES;
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
            [_usernameArr removeObjectAtIndex:indexPath.row];
            [_passwordArr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }
        
    }];
    
    return @[editAction,deleteAction];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
