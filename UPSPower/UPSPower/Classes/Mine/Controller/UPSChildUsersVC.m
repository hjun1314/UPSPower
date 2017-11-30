//
//  UPSChildUsersVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSChildUsersVC.h"
#import "UPSChildUserCell.h"
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
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)setNav{
    
    self.navigationItem.title = @"子用户管理";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    
}
- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    ///按钮点击
    UIButton *btn = [[UIButton alloc]init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.height.offset(40);
        make.width.offset(80);
    }];
    [btn setBackgroundColor:[UIColor cyanColor]];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)didClickBtn{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"添加用户名和密码"
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"password";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.secureTextEntry = YES;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        self.nameField = namefield;
        UITextField * passwordfiled = textfields[1];
        self.passwordField = passwordfiled;
         ///添加cell
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            NSString *s = [[NSString alloc] initWithFormat:@"hello"];
            [_data addObject:s];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [indexPaths addObject: indexPath];
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
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
    }
    cell.nameLabel.text = self.nameField.text;
    cell.passwordLabel.text = self.passwordField.text;

    return cell;
    
}
-(NSMutableArray *)data{
    if (_data == nil) {
        _data = @[@"aaa",@"bbb",@"ccc",@"ddd"].mutableCopy;
//        _data = [NSMutableArray array];
    }
    return _data;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
