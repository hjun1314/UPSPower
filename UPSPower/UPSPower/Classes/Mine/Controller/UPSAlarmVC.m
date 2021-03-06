//
//  UPSAlarmVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/24.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSAlarmVC.h"
#import "UPSAlarmCell.h"
#import "UPSAlarmBtn.h"
#import "UPSMainModel.h"
#import "UPSAlarmModel.h"
#import "UPSScreeningAlarmModel.h"
#import "UPSUpdateAlermSettingModel.h"
#import "YCXMenu.h"
#import "UIView+Toast.h"
@interface UPSAlarmVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *titleView;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UPSMainModel *mainModel;

///右上角items相关
@property (nonatomic,strong)NSMutableArray *items;
///显示告警列表
@property (nonatomic,strong)NSMutableArray *alarmArr;
///已选的告警合集
@property (nonatomic,strong)NSMutableArray *alarmData;

///全选按钮
@property (nonatomic,strong)UIButton *selectAllBtn;
///是否全选
@property (nonatomic,assign)BOOL isSelect;

///运行信息
@property (nonatomic,strong)NSMutableArray *runArr;
///一般告警
@property (nonatomic,strong)NSMutableArray *generalArr;
///严重告警
@property (nonatomic,strong)NSMutableArray *seriousArr;


@property (nonatomic,assign)int flag;


@property (nonatomic,strong)NSMutableArray *dataM;




@end

@implementation UPSAlarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupTitleView];
    [self setupTableView];
    //    [self setNontification];
    self.alarmData = [NSMutableArray array];
    self.alarmArr = [NSMutableArray array];
    UPSMainModel *model = [UPSMainModel sharedUPSMainModel];
    self.mainModel = model;
    [SVProgressHUD show];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;;
    params[@"userId"] = @(self.mainModel.userId);
    [[UPSHttpNetWorkTool sharedApi]POST:@"upsAlarmConfigureList" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        kWeakSelf(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakself.view makeToast:@"加载成功" duration:0.5 position:CSToastPositionCenter];
            NSMutableArray *dataM = responseObject[@"data"];
            weakself.dataM = dataM;
            NSMutableArray *tempArr = [NSMutableArray array];
            for (int i = 0 ; i < dataM.count; i++) {
                UPSAlarmModel *alermModel = [UPSAlarmModel mj_objectWithKeyValues:dataM[i]];
                [tempArr addObject:alermModel];
            }
            NSLog(@"告警信息成功%@",tempArr);
            weakself.alarmArr = tempArr;
            weakself.dataM = dataM;
            [weakself.tableView reloadData];
            
        });
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        kWeakSelf(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakself.view makeToast:@"加载失败" duration:0.5 position:CSToastPositionCenter];
        });
    }];
    
}
- (void)setNav{
    
    self.navigationItem.title = @"告警定义设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"select"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}
- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickRightItem:(id)sender{
    
    if (sender == self.navigationItem.rightBarButtonItem){
        [YCXMenu setTintColor:UICOLOR_RGB(33, 151, 216, 1)];
        [YCXMenu setSelectedColor:[UIColor redColor]];
        if ([YCXMenu isShow]){
            [YCXMenu dismissMenu];
        } else {
            [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.width - 50, SafeAreaTopHeight, 50, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
                //NSLog(@"%@",item);
            }];
        }
    }
    
    
}
- (void)setupTitleView{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, self.view.width, 35)];
    titleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.titleView = titleView;
    [self.view addSubview:titleView];
    [self setupTitleButtons];
    
}

- (void)setupTitleButtons{
    CGFloat titleBtnW = self.titleView.width * 0.2;
    CGFloat titleBtnBw = self.titleView.width *0.4;
    CGFloat titleBtnH = self.titleView.height;
    UPSAlarmBtn *codeBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(0, 0, titleBtnW, titleBtnH)];
    [codeBtn setTitle:@" 编 码" forState:UIControlStateNormal];
    [self.titleView addSubview:codeBtn];
    [codeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    UPSAlarmBtn *eventBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(titleBtnW, 0, titleBtnBw, titleBtnH)];
    [eventBtn setTitle:@"事件名称" forState:UIControlStateNormal];
    [self.titleView addSubview:eventBtn];
    [eventBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    eventBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    UPSAlarmBtn *alarmBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(titleBtnW + titleBtnBw, 0, titleBtnW, titleBtnH)];
    [alarmBtn setTitle:@"报警级别" forState:UIControlStateNormal];
    [self.titleView addSubview:alarmBtn];
    [alarmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    alarmBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    UPSAlarmBtn *activationBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake((titleBtnW *2 + titleBtnBw), 0, titleBtnW, titleBtnH)];
    [activationBtn setTitle:@" 激活" forState:UIControlStateNormal];
    [self.titleView addSubview:activationBtn];
    activationBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    self.selectAllBtn = activationBtn;
    [activationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activationBtn setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    [activationBtn setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateSelected];
    [activationBtn addTarget:self action:@selector(clickActivationBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)setupTableView{
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35 + SafeAreaTopHeight, self.view.width, self.view.height - 35 - SafeAreaTopHeight-SafeAreaTabbarHeight)];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    //    tabelView.backgroundColor = [UIColor redColor];
    tabelView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView = tabelView;
    [self.view addSubview:tabelView];
    
    
}
- (void)clickActivationBtn:(UIButton *)sender{
    [self.alarmData removeAllObjects];
    sender.selected = !sender.selected;
    self.isSelect = sender.selected;
    ///主要代码
    if (self.isSelect) {
        for (UPSAlarmModel *model in self.alarmArr) {
            [self.alarmData addObject:model];
        }
        ///http://192.168.1.147:12345/ups-interface/settingUpsAlarm
        [self clickLevelBtn];
    }else{
        [self.alarmData removeAllObjects];
    }
    [self.tableView reloadData];
}
//- (void)setNontification{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickLevelBtn) name:@"didClickLevelBtn" object:nil];
//}

- (void)clickLevelBtn{
    
    ///更新告警测试http://192.168.1.147:12345/ups-interface/settingUpsAlarm
    //    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.alarmArr.count];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (UPSAlarmModel *model in self.alarmArr) {
        //        [array addObject:[NSString stringWithFormat:@"%ld",model.upsSettingId]];
        //         [array addObject:[NSString stringWithFormat:@"%d",model.isUse]];
        //        UPSAlarmModel *model = [[UPSAlarmModel alloc]init];
        //        model.upsSettingId = [dict[@"upsSettingId"]integerValue];
        //        model.isUse = [dict[@"isUse"]boolValue];
        //        [tempArr addObject:@(model.upsSettingId)];
        //        [tempArr addObject:@(model.isUse)];
        
        //        NSLog(@"model%@",model);
        
        NSString *upsSettingId = [[NSString alloc]initWithFormat:@"%ld",model.upsSettingId];
        NSString *isUsed = [[NSString alloc]initWithFormat:@"%d",model.isUse];
        //
        NSDictionary *temp = @{@"upsSettingId": upsSettingId,@"isUsed":isUsed};
        [tempArr addObject:temp];
    }
    
    
    
    
    //    if (!jsonData) {
    //
    //        NSLog(@"%@",error);
    //
    //    }else{
    
    //        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //}
    //    NSMutableArray *array = [NSMutableArray arrayWithCapacity:tempArr.count];
    
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempArr.firstObject options:NSJSONWritingPrettyPrinted error:nil];
    //    [params setObject:jsonData forKey:@"configureInputDTOList"];
    
    //    params[@"configureInputDTO"] = [tempArr firstObject];
    //    [params setObject:[tempArr componentsJoinedByString:@","] forKey:@"configureInputDTO"];
    
    //    NSMutableArray *paramsArr = [NSMutableArray arrayWithCapacity:paramsData.count];
    //    NSLog(@"paramsArr%@",paramsArr);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempArr.firstObject options:NSJSONWritingPrettyPrinted error:nil];
    //    NSLog(@"jsonData%@",jsonData);
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\" withString:@"" options:NSLiteralSearch range:range2];
    jsonString=[jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    //去掉字符串中的换行符
    NSRange range3 = {0,mutStr.length};
    
    //
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range3];
    
    //    NSString *ssss = nil;
    //    ssss = [mutStr substringWithRange:range3];
    //    if ([ssss isEqualToString:@"/"]) {
    //        [ssss stringByReplacingCharactersInRange:range3 withString:@""];
    //    }NSLog(@"ssss%@",ssss);
    //    [mutStr replaceOccurrencesOfString:@"\\" withString:@"" options:NSLiteralSearch range:range3];
    //    NSString *str = @"{\"upsSettingId\":\"143\",\"isUsed\":\"1\"}";
    //    NSData *datasss = [NSJSONSerialization dataWithJSONObject:str options:NSJSONWritingPrettyPrinted  error:nil];
    //    NSString *jsonsssss = [[NSString alloc]initWithData:datasss encoding:NSUTF8StringEncoding ];
    //    NSLog(@"jsonsssss%@",jsonsssss);
    
    //    params[@"configreInputDTOList"] = jsonsssss;
    //    NSLog(@"params%@",params);
    //        NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //        params[@"configureInputDTO"] = mutStr;
    //        params[@"token"] = self.mainModel.token;;
    //        params[@"userId"] = @(self.mainModel.userId);
    //        [[UPSHttpNetWorkTool sharedApi]POST:@"settingUpsAlarm" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
    //            NSMutableArray *dataM = responseObject[@"data"];
    //            NSMutableArray *tempArr = [NSMutableArray array];
    //            NSLog(@"....%@",responseObject);
    //
    //            for (int i = 0 ; i < dataM.count; i++) {
    //                UPSUpdateAlermSettingModel *updateModel = [UPSUpdateAlermSettingModel mj_objectWithKeyValues:dataM[i]];
    //                [tempArr addObject:updateModel];
    //            }
    //            NSLog(@"更新告警测试成功%@",tempArr);
    //
    //        } fail:^(NSURLSessionDataTask *task, NSError *error) {
    //            NSLog(@"更新告警测试失败%@",error);
    //        }];
    
    //    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //    configuration.HTTPAdditionalHeaders = @{@"token":self.mainModel.token,@"userId":[NSString stringWithFormat:@"%ld",(long)self.mainModel.userId]};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:self.mainModel.token forHTTPHeaderField:@"token"];
    //    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",@(self.mainModel.userId)] forHTTPHeaderField:@"userId"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"configureInputDTO"] = tempArr.firstObject;
    //    params[@"token"] = self.mainModel.token;;
    params[@"userId"] = @(self.mainModel.userId);
    
    
    [manager POST:@"http://192.168.1.120:10000/ups-interface/settingUpsAlarm" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *dataM = responseObject[@"data"];
        NSMutableArray *temp = [NSMutableArray array];
        NSLog(@"....%@",responseObject);
        
        for (int i = 0 ; i < dataM.count; i++) {
            UPSUpdateAlermSettingModel *updateModel = [UPSUpdateAlermSettingModel mj_objectWithKeyValues:dataM[i]];
            [temp addObject:updateModel];
        }
        NSLog(@"更新告警测试成功%@",temp);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    //    [[UPSHttpNetWorkTool sharedApi]POST:@"settingUpsAlarm" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
    //        NSLog(@".....%@",responseObject);
    //    } fail:^(NSURLSessionDataTask *task, NSError *error) {
    //
    //    }];
}

//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}


#pragma mark- tableView数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.flag == 1) {
        
        return self.runArr.count;
    }
    else if (self.flag == 2){
        return self.generalArr.count;
    }else if (self.flag == 3){
        return self.seriousArr.count;
    }else if(self.flag == 4){
        return self.alarmArr.count;
    }else{
        return self.alarmArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"alarmCell";
    UPSAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UPSAlarmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isSelected = self.isSelect;
    ///是否被选中
    if ([self.alarmData containsObject:[self.alarmArr objectAtIndex:indexPath.row]]) {
        cell.isSelected = YES;
    }
    __weak typeof(self) weakSelf = self;
    cell.cartBlock = ^(BOOL select) {
        ///选中就加入数组
        if (select) {
            
            [weakSelf.alarmData addObject:[weakSelf.alarmArr objectAtIndex:indexPath.row]];
        }else{
            ///移除
            [weakSelf.alarmData removeObject:[weakSelf.alarmArr objectAtIndex:indexPath.row]];
        }
        //全选
        if (weakSelf.alarmData.count == weakSelf.alarmArr.count) {
            weakSelf.selectAllBtn.selected = YES;
        }else{
            weakSelf.selectAllBtn.selected = NO;
        }
        
    };
    [cell reloadDataWith:[self.alarmArr objectAtIndex:indexPath.row]];
    
    UPSAlarmModel *model = self.alarmArr[indexPath.row];
    
    
    //    cell.textLabel.text = model.alarmCode;
    [cell.nameBtn setTitle:model.alarmCode forState:UIControlStateNormal];
    [cell.eventBtn setTitle:model.alarmName forState:UIControlStateNormal];
    [cell.levelBtn setTitle:model.typeName forState:UIControlStateNormal];
    
    if (self.flag == 1) {
        UPSScreeningAlarmModel *runModel = self.runArr[indexPath.row];
        [cell.nameBtn setTitle:model.alarmCode forState:UIControlStateNormal];
        [cell.eventBtn setTitle:runModel.alarmName forState:UIControlStateNormal];
        [cell.levelBtn setTitle:runModel.typeName forState:UIControlStateNormal];
    }else if (self.flag == 2){
        UPSScreeningAlarmModel *generalModel = self.generalArr[indexPath.row];
        [cell.nameBtn setTitle:model.alarmCode forState:UIControlStateNormal];
        [cell.eventBtn setTitle:generalModel.alarmName forState:UIControlStateNormal];
        [cell.levelBtn setTitle:generalModel.typeName forState:UIControlStateNormal];
        
    }else if (self.flag == 3){
        UPSScreeningAlarmModel *seriousModel = self.seriousArr[indexPath.row];
        [cell.nameBtn setTitle:model.alarmCode forState:UIControlStateNormal];
        [cell.eventBtn setTitle:seriousModel.alarmName forState:UIControlStateNormal];
        [cell.levelBtn setTitle:seriousModel.typeName forState:UIControlStateNormal];
        
    }else if (self.flag == 4){
        UPSAlarmModel *model = self.alarmArr[indexPath.row];
        //    cell.textLabel.text = model.alarmCode;
        [cell.nameBtn setTitle:model.alarmCode forState:UIControlStateNormal];
        [cell.eventBtn setTitle:model.alarmName forState:UIControlStateNormal];
        [cell.levelBtn setTitle:model.typeName forState:UIControlStateNormal];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UPSAlarmModel *model = self.alarmArr[indexPath.row];
    NSLog(@"dddddd%@",model.alarmName);
    NSMutableArray *paramsArr = [NSMutableArray array];
    NSString *upsSettingId = [[NSString alloc]initWithFormat:@"%ld",model.upsSettingId];
    NSString *isUsed = [[NSString alloc]initWithFormat:@"%d",model.isUse];
    
    NSDictionary *temp = @{@"upsSettingId": upsSettingId,@"isUsed":isUsed};
    NSLog(@"temp%@",temp);
    [paramsArr addObject:temp];
    NSLog(@"paramsArr%@",paramsArr);
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}

#pragma mark- 懒加载
- (NSMutableArray *)items {
    if (!_items) {
        
        YCXMenuItem *all = [YCXMenuItem menuItem:@"全部告警" image:nil target:self action:@selector(clickAll:)];
        
        YCXMenuItem *runInfo = [YCXMenuItem menuItem:@"运行信息" image:nil target:self action:@selector(clickRunInfo:)];
        runInfo.tag = 10;
        YCXMenuItem *general = [YCXMenuItem menuItem:@"一般告警" image:nil target:self action:@selector(clickGeneral:)];
        general.tag = 20;
        YCXMenuItem *serious = [YCXMenuItem menuItem:@"严重告警" image:nil target:self action:@selector(clickSerious:)];
        serious.tag = 30;
        serious.foreColor = [UIColor whiteColor];
        serious.alignment = NSTextAlignmentCenter;
        //set item
        _items = [@[
                    all,runInfo,general ,serious
                    ] mutableCopy];
    }
    return _items;
}
///点击了全部筛选
- (void)clickAll:(UIButton *)all{
    self.flag = 4;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;;
    params[@"userId"] = @(self.mainModel.userId);
    [[UPSHttpNetWorkTool sharedApi]POST:@"upsAlarmConfigureList" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *dataM = responseObject[@"data"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i = 0 ; i < dataM.count; i++) {
            UPSAlarmModel *alermModel = [UPSAlarmModel mj_objectWithKeyValues:dataM[i]];
            [tempArr addObject:alermModel];
        }
        NSLog(@"告警信息成功%@",tempArr);
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [self.tableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
///运行信息
-(void)clickRunInfo:(UIButton *)run{
    
    ///http://192.168.1.147:12345/ups-interface/screenConfigureType
    self.flag = 1;
    //    [self.generalArr removeAllObjects];
    //    [self.seriousArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;;
    params[@"userId"] = @(self.mainModel.userId);
    params[@"typeId"] = @(1);
    [[UPSHttpNetWorkTool sharedApi]POST:@"screenConfigureType" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *dataM = responseObject[@"data"];
        NSMutableArray *runArr = [NSMutableArray array];
        for (int i = 0; i < dataM.count; i++) {
            UPSScreeningAlarmModel *screenModel = [UPSScreeningAlarmModel mj_objectWithKeyValues:dataM[i]];
            [runArr addObject:screenModel];
        }
        self.runArr = runArr;
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [self.tableView reloadData];
        NSLog(@"运行信息成功%@",runArr);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
///一般告警
- (void)clickGeneral:(UIButton *)general{
    self.flag = 2;
    //    [self.runArr removeAllObjects];
    //   [self.seriousArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;;
    params[@"userId"] = @(self.mainModel.userId);
    params[@"typeId"] = @(2);
    [[UPSHttpNetWorkTool sharedApi]POST:@"screenConfigureType" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *dataM = responseObject[@"data"];
        NSMutableArray *generalArr = [NSMutableArray array];
        for (int i = 0; i < dataM.count; i++) {
            UPSScreeningAlarmModel *screenModel = [UPSScreeningAlarmModel mj_objectWithKeyValues:dataM[i]];
            [generalArr addObject:screenModel];
        }
        self.generalArr = generalArr;
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [self.tableView reloadData];
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
///严重告警
- (void)clickSerious:(UIButton *)serious{
    self.flag = 3;
    //    [self.runArr removeAllObjects];
    //    [self.generalArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;;
    params[@"userId"] = @(self.mainModel.userId);
    params[@"typeId"] = @(3);
    [[UPSHttpNetWorkTool sharedApi]POST:@"screenConfigureType" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *dataM = responseObject[@"data"];
        NSMutableArray *seriousArr = [NSMutableArray array];
        for (int i = 0; i < dataM.count; i++) {
            UPSScreeningAlarmModel *screenModel = [UPSScreeningAlarmModel mj_objectWithKeyValues:dataM[i]];
            [seriousArr addObject:screenModel];
        }
        self.seriousArr = seriousArr;
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [self.tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    ///测试更新告警设置http://192.168.1.147:12345/ups-interface/settingUpsAlarm
    //    UPSAlarmModel *model = [UPSAlarmModel sharedUPSAlarmModel];
    //    NSString *setting = [NSString stringWithFormat:@"%ld",(long)model.upsSettingId];
    //    NSString *isUsed = [NSString stringWithFormat:@"%d",model.isUse];
    //
    //     NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //        params[@"token"] = self.mainModel.token;;
    //        params[@"userId"] = @(self.mainModel.userId);
    //        params[@"configureInputDTO"] = @{@"upsSettingId":setting,@"isUse":isUsed};
    //    [[UPSHttpNetWorkTool sharedApi]POST:@"settingUpsAlarm" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
    //        NSLog(@"成功%@",responseObject);
    //    } fail:^(NSURLSessionDataTask *task, NSError *error) {
    //        NSLog(@"失败%@",error);
    //    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
