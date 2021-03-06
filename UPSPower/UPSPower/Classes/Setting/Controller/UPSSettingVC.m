//
//  UPSSettingVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSSettingVC.h"
#import "UPSSettingCell.h"
#import "SDAutoLayout.h"
#import "UPSSettingModel.h"
#import "UPSMainModel.h"
#import "UPSAlarmRecordModel.h"
#import "UPSSingalAlarmRecordModel.h"
#import "GKCover.h"
#import "UPSAlarmView.h"
#import "YCXMenu.h"
#import "YCXMenuItem.h"
@interface UPSSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UPSMainModel *mainModel;
@property (nonatomic,strong)NSMutableArray *items;

@end

@implementation UPSSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupTableView];
    //[self configSuperViewFrame:CGRectMake(0, 0, kScreenW, kScreenH - SafeAreaTabbarHeight)];
    UPSMainModel *model = [UPSMainModel sharedUPSMainModel];
    self.mainModel = model;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;;
    params[@"userId"] = @(self.mainModel.userId);
    params[@"companyId"] = @(self.mainModel.companyId);
    //    params[@"pages"] = @(self.currPage);
    [[UPSHttpNetWorkTool sharedApi]POST:@"getAlarmLog" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *dataM = responseObject[@"data"];
        NSMutableArray *alarmRecordArr = [NSMutableArray array];
        for (int i = 0; i < dataM.count; i++) {
            UPSAlarmRecordModel *alarmRecordModel = [UPSAlarmRecordModel mj_objectWithKeyValues:dataM[i]];
            [alarmRecordArr addObject:alarmRecordModel];
        }
        self.dataArr = alarmRecordArr;
        [self.tableView reloadData];
        NSLog(@"获取告警记录成功%@",responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    //[self addMJRefreshHeader:NO addFooter:YES];
//   [self.tableView.mj_header beginRefreshing];
   
}
- (void)setNav{
    self.title = @"报警信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"select"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarItem:)];
}

- (void)setupTableView{


    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - SafeAreaTabbarHeight)];
//    tableView.backgroundColor = [UIColor brownColor];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}
//- (void)headerRereshing{
//    [self.dataArray removeAllObjects];
//    [self checkNetworkState];
//    [self.tableView.mj_header endRefreshing];
//}
//- (void)footerRereshing{
//    [self checkNetworkState];
//    [self.tableView.mj_footer beginRefreshing];
//}

//- (void)checkNetworkState{
//    if (!self.dataArray.count) {
//        self.currPage = 1;
//    }else{
//        self.currPage ++;
//    }
//    [self getDataWithTableView];
//}
//- (void)getDataWithTableView{
//    ///http://192.168.1.147:12345/ups-interface/getAlarmLog
//    UPSMainModel *model = [UPSMainModel sharedUPSMainModel];
//    self.mainModel = model;
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"token"] = self.mainModel.token;;
//    params[@"userId"] = @(self.mainModel.userId);
//    params[@"companyId"] = @(self.mainModel.companyId);
////    params[@"pages"] = @(self.currPage);
//    [[UPSHttpNetWorkTool sharedApi]POST:@"getAlarmLog" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSMutableArray *dataM = responseObject[@"data"];
//        NSMutableArray *alarmRecordArr = [NSMutableArray array];
//        for (int i = 0; i < dataM.count; i++) {
//            UPSAlarmRecordModel *alarmRecordModel = [UPSAlarmRecordModel mj_objectWithKeyValues:dataM[i]];
//            [alarmRecordArr addObject:alarmRecordModel];
//        }
//        self.dataArray = alarmRecordArr;
//        [self.tableView reloadData];
//        NSLog(@"获取告警记录成功%@",responseObject);
//
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//
//    }];
//
//}

- (void)clickRightBarItem:(id)sender{
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
   
#pragma mark- 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDCell = @"settingCell";
    UPSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"UPSSettingCell" owner:nil options:nil]firstObject];
    }
    if (indexPath.row==0) {
        
        cell.topLine.sd_layout.topEqualToView(cell.point).leftSpaceToView(cell.contentView,8.5).widthIs(1).bottomSpaceToView(cell.point, 0);
        
        cell.bottomLine.sd_layout.topEqualToView(cell.point).leftSpaceToView(cell.contentView,8.5).widthIs(1).bottomSpaceToView(cell.contentView, 0);
    }
    
    if (indexPath.row == self.dataArr.count - 1) {
        
        cell.topLine.sd_layout.topEqualToView(cell.contentView).leftSpaceToView(cell.contentView,8.5).widthIs(1).bottomSpaceToView(cell.point, 0);
        
        cell.bottomLine.sd_layout.topEqualToView(cell.point).leftSpaceToView(cell.contentView,8.5).widthIs(1).heightIs(0);
    }
//    UPSAlarmRecordModel *record = self.dataArr[indexPath.row];
//    cell.textLabel.text = record.happenTime;
////
    cell.model = self.dataArr[indexPath.row];
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataArr[indexPath.row];
    
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[UPSSettingCell class] contentViewWidth:[self cellContentViewWith]];
    
    //    GZTimeLineModel *model = self.TimeLineData[indexPath.row];
    //
    //    return [self.GZTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[GZTableViewCell class] contentViewWidth:self.view.frame.size.width];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ///http://192.168.1.147:12345/ups-interface/alarmLogDetails
//    UPSMainModel *model = [UPSMainModel sharedUPSMainModel];
//    self.mainModel = model;
    ///http://192.168.1.147:12345/ups-interface/getAlarmLog
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    UPSAlarmRecordModel *RecordModel = self.dataArr[indexPath.row];

    params[@"token"] = self.mainModel.token;;
    params[@"userId"] = @(self.mainModel.userId);
    params[@"upsId"] = @(RecordModel.upsId);
    params[@"happenTime"] = RecordModel.happenTime;
    [[UPSHttpNetWorkTool sharedApi]POST:@"alarmLogDetails" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *dataM = responseObject[@"data"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i = 0 ; i < dataM.count; i++) {
            UPSSingalAlarmRecordModel *singalModel = [UPSSingalAlarmRecordModel mj_objectWithKeyValues:dataM[i]];
            [tempArr addObject:singalModel];
            UPSAlarmView *greenView = [UPSAlarmView new];
            greenView.backgroundColor = [UIColor whiteColor];
                greenView.alarmLabel.text = singalModel.alarmCode;
                greenView.nameLabel.text = singalModel.alarmDesc;
            greenView.happenLabel.text = [UPSTool stringWithNsdate:singalModel.happenTime];
            greenView.removeLabel.text = [UPSTool stringWithNsdate:singalModel.removeTime];
            greenView.gk_size = CGSizeMake(kScreenW *0.7, 155);
            
            [GKCover translucentWindowCenterCoverContent:greenView animated:YES];
        }
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
  
}
#pragma mark- 懒加载
- (NSMutableArray *)items {
    if (!_items) {
        
        YCXMenuItem *all = [YCXMenuItem menuItem:@"20条信息" image:nil target:self action:@selector(clickAll:)];
        
        YCXMenuItem *runInfo = [YCXMenuItem menuItem:@"30条信息" image:nil target:self action:@selector(clickRunInfo:)];
        runInfo.tag = 10;
        YCXMenuItem *general = [YCXMenuItem menuItem:@"50条信息" image:nil target:self action:@selector(clickGeneral:)];
        general.tag = 20;
        YCXMenuItem *serious = [YCXMenuItem menuItem:@"100条信息" image:nil target:self action:@selector(clickSerious:)];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
