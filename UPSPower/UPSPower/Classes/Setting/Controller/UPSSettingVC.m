//
//  UPSSettingVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSSettingVC.h"
#import "YUFoldingTableView.h"
#import "UPSSettingCell.h"
@interface UPSSettingVC ()<YUFoldingTableViewDelegate>
@property (nonatomic,strong)YUFoldingTableView *tableView;
@property (nonatomic, assign)YUFoldingSectionHeaderArrowPosition arrowPosition;
@property (nonatomic,assign)BOOL isOpen;
@end

@implementation UPSSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"报警信息";
    [self setupTableView];
}
- (void)setupTableView{
    
    
    YUFoldingTableView *tableView = [[YUFoldingTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 40, kScreenW, kScreenH - 104)];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.foldingDelegate =self;
    if (self.arrowPosition) {
        tableView.foldingState = YUFoldingSectionStateShow;
    }
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, headView.width, 30)];
    title.text = @"报警记录";
    [headView addSubview:title];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTab)];
    [headView addGestureRecognizer:tap];
    
    
}
///手势的点击
- (void)clickTab{
    if (!self.isOpen) {
        self.tableView.hidden = NO;
    }else{self.tableView.hidden = YES;
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
}
#pragma mark- 代理方法
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return 5;
}

-(YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
    return self.arrowPosition ? :YUFoldingSectionHeaderArrowPositionLeft;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    return 1;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"11.11";
    }else if (section == 1){
        return @"11.12";
    }else if (section == 2){
        return @"11.13";
    }else if (section == 3){
        return @"11.14";
    }else{
        return @"11.15";
        
    }
    
}
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UPSSettingCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UPSSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
