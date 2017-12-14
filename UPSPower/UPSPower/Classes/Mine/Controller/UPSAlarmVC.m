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
@interface UPSAlarmVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *titleView;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *data;
@property (nonatomic,strong)UPSMainModel *mainModel;

@property (nonatomic,strong)NSMutableArray *items;


@end

@implementation UPSAlarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupTitleView];
    [self setupTableView];
    [self setNontification];
    UPSMainModel *model = [UPSMainModel sharedUPSMainModel];
    self.mainModel = model;
}
- (void)setNav{
    
    self.navigationItem.title = @"告警定义设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"告警刷选" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem:)];
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
            [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.width - 75, SafeAreaTopHeight, 50, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
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
    NSArray *titles = @[@"事件名称",@"告警级别",@"激活告警"];
    NSUInteger count = titles.count;
    
    CGFloat titleBtnW = self.titleView.width / count;
    CGFloat titleBtnH = self.titleView.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleBtn = [[UIButton alloc]init];
        [self.titleView addSubview:titleBtn];
        titleBtn.frame = CGRectMake(i * titleBtnW, 0, titleBtnW, titleBtnH);
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    
}

- (void)setupTableView{
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35 + SafeAreaTopHeight, self.view.width, self.view.height - 35 - SafeAreaTopHeight)];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    tabelView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView = tabelView;
    [self.view addSubview:tabelView];
    
//    UPSAlarmBtn *sureBtn = [[UPSAlarmBtn alloc]init];
//    if (iphone4 || iphone5) {
//        sureBtn.frame = CGRectMake((self.view.width - 160) / 3, self.view.height - 120, 80, 40);
//    }else if (iphone6){
//        sureBtn.frame = CGRectMake((self.view.width - 200)/3, self.view.height - 120, 100, 40);
//    }else if (iphone6P){
//        sureBtn.frame = CGRectMake((self.view.width - 240)/3, self.view.height - 120, 120, 40);
//    }else if (iphoneX){
//        sureBtn.frame = CGRectMake((self.view.width - 200)/3, self.view.height - 150, 100, 40);
//    }
//    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [sureBtn setBackgroundColor:[UIColor cyanColor]];
//    sureBtn.layer.cornerRadius = 10;
//    sureBtn.clipsToBounds = YES;
//    [self.view addSubview:sureBtn];
//    
//    UPSAlarmBtn *resumeBtn = [[UPSAlarmBtn alloc]init];
//    if (iphone4 || iphone5) {
//        resumeBtn.frame =CGRectMake((self.view.width - 160) / 3 * 2 + 80, self.view.height - 120, 80, 40);
//    }else if (iphone6){
//        resumeBtn.frame = CGRectMake((self.view.width - 200)/ 3 * 2 + 100, self.view.height - 120, 100, 40);
//    }else if (iphone6P){
//        resumeBtn.frame = CGRectMake((self.view.width - 240)/ 3 * 2 + 120, self.view.height - 120, 120, 40);
//    }else if (iphoneX){
//        resumeBtn.frame = CGRectMake((self.view.width - 200)/ 3 * 2 + 100, self.view.height - 150, 100, 40);
//    }
//    [resumeBtn setTitle:@"还原" forState:UIControlStateNormal];
//    [resumeBtn setBackgroundColor:[UIColor cyanColor]];
//    resumeBtn.clipsToBounds = YES;
//    resumeBtn.layer.cornerRadius = 10;
//    [self.view addSubview:resumeBtn];
//    
    
}

- (void)setNontification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickLevelBtn) name:@"didClickLevelBtn" object:nil];
}

- (void)clickLevelBtn{
//   ///通过筛选获取告警设置
//    ///http://192.168.1.147:12345/ups-interface/screenConfigureType
//    UPSAlarmModel *model = [UPSAlarmModel sharedUPSAlarmModel];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"token"] = self.mainModel.token;;
//    params[@"userId"] = @(self.mainModel.userId);
//    params[@"typeId"] = @(model.typeId);
//    [[UPSHttpNetWorkTool sharedApi]POST:@"screenConfigureType" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSMutableArray *dataM = responseObject[@"data"];
//        NSMutableArray *tempArr = [NSMutableArray array];
//        for (int i = 0; i < dataM.count; i++) {
//            UPSScreeningAlarmModel *screeningModel = [UPSScreeningAlarmModel mj_objectWithKeyValues:dataM[i]];
//            [tempArr addObject:screeningModel];
//        }
//        NSLog(@"通过筛选获取告警设置成功%@",tempArr);
//
//
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//
//    }];
//
     
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    
    ///更新告警测试http://192.168.1.147:12345/ups-interface/settingUpsAlarm
    NSMutableArray *paramsArr = [NSMutableArray array];
    NSMutableArray *paramsData = [NSMutableArray array];
    ///取数组参数
    for (int i = 0; i < paramsData.count ; i++ ) {
        UPSUpdateAlermSettingModel *model = paramsData[i];
        
        NSString *upsSettingId = [[NSString alloc]initWithFormat:@"%ld",model.upsSettingId];
        NSString *isUsed = [[NSString alloc]initWithFormat:@"%d",model.isUse];
        
        NSDictionary *temp = @{@"upsSettingId": upsSettingId,@"isUsed":isUsed};
        
        [paramsArr addObject:temp];
    }

        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = self.mainModel.token;;
        params[@"userId"] = @(self.mainModel.userId);
    params[@"configureInputDTOList"] = paramsArr;
    
    [manager POST:@"http://192.168.1.147:12345/ups-interface/settingUpsAlarm" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSMutableArray *dataM = responseObject[@"data"];
                NSMutableArray *tempArr = [NSMutableArray array];
        
        
                for (int i = 0 ; i < dataM.count; i++) {
                    UPSUpdateAlermSettingModel *updateModel = [UPSUpdateAlermSettingModel mj_objectWithKeyValues:dataM[i]];
                    [tempArr addObject:updateModel];
                }
                NSLog(@"更新告警测试成功%@",tempArr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"更新告警测试失败%@",error);
    }];
//    [[UPSHttpNetWorkTool sharedApi]POST:@"settingUpsAlarm" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSMutableArray *dataM = responseObject[@"data"];
//        NSMutableArray *tempArr = [NSMutableArray array];
//
//
//        for (int i = 0 ; i < dataM.count; i++) {
//            UPSUpdateAlermSettingModel *updateModel = [UPSUpdateAlermSettingModel mj_objectWithKeyValues:dataM[i]];
//            [tempArr addObject:updateModel];
//        }
//        NSLog(@"更新告警测试成功%@",tempArr);
//
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"更新告警测试失败%@",error);
//    }];
    
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark- tableView数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *ID = @"alarmCell";
    UPSAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UPSAlarmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}

#pragma mark- 懒加载
- (NSMutableArray *)items {
    if (!_items) {
        
        // set title
//        YCXMenuItem *menuTitle = [YCXMenuItem menuTitle:@"全部" WithIcon:nil];
//        menuTitle.foreColor = [UIColor whiteColor];
//        menuTitle.titleFont = [UIFont boldSystemFontOfSize:20.0f];


        
        //set logout button
        
        YCXMenuItem *all = [YCXMenuItem menuItem:@"全 部" image:nil target:self action:@selector(clickAll)];
        
         YCXMenuItem *general = [YCXMenuItem menuItem:@"一 般" image:nil target:self action:@selector(clickGeneral)];
        
        YCXMenuItem *serious = [YCXMenuItem menuItem:@"严 重" image:nil target:self action:@selector(clickSerious)];
        
        YCXMenuItem *alarm = [YCXMenuItem menuItem:@"告 警" image:nil target:self action:@selector(clickAlarm)];
        alarm.foreColor = [UIColor whiteColor];
        alarm.alignment = NSTextAlignmentCenter;
//
        //set item
        _items = [@[
                  all,general,serious ,alarm
                   ] mutableCopy];
    }
    return _items;
}
- (void)clickAll{
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
    
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
    
        }];
    
}
-(void)clickGeneral{
    NSLog(@"点击了普通");
}
- (void)clickSerious{
    NSLog( @"点击了严重");
}
- (void)clickAlarm{
    NSLog(@"点击了告警");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
