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
@interface UPSSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UPSMainModel *mainModel;

@end

@implementation UPSSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报警信息";
    [self setupTableView];
    UPSMainModel *model = [UPSMainModel sharedUPSMainModel];
    self.mainModel = model;
    ///http://192.168.1.147:12345/ups-interface/getAlarmLog
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = self.mainModel.token;;
    params[@"userId"] = @(self.mainModel.userId);
    params[@"companyId"] = @(self.mainModel.companyId);
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
    
}
- (void)setupTableView{
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTopHeight  - SafeAreaTabbarHeight)];
//    tableView.backgroundColor = [UIColor brownColor];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
