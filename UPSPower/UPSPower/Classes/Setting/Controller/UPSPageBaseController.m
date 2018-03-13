//
//  UPSPageBaseController.m
//  UPS
//
//  Created by hjun on 2017/9/15.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSPageBaseController.h"

NSString *kReachabilityChangedNotification = @"kNetworkReachabilityChangedNotification";
@interface UPSPageBaseController ()<UITableViewDataSource, UITableViewDelegate>

/**
 *  获取表格数据、子类重写
 */
- (void)getDataWithTableView;


@end

@implementation UPSPageBaseController

#pragma mark - 懒加载
//- (SVProgressHUD *)HUD{
//    if (_HUD == nil) {
//        _HUD = [[SVProgressHUD alloc]init];
//
//    }
//    return _HUD;
//}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)configSuperViewFrame:(CGRect)frame{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)addMJRefreshHeader:(BOOL)isHaveHeader addFooter:(BOOL)isHaveFooter{
    if (isHaveHeader) {
        //[self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        [self.tableView.mj_header beginRefreshing];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    }
    if (isHaveFooter) {
        //[self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    
}

- (void)headerRereshing{
    NSLog(@"子类需要重写getDataWithTableView、下拉刷新");
   // [self.dataArray removeAllObjects];
    [self checkNetworkState];
    [self.tableView.mj_header endRefreshing];
}

- (void)footerRereshing{
    NSLog(@"子类需要重写getDataWithTableView、上拉加载");
    [self checkNetworkState];
}

- (void)checkNetworkState{
    if (!self.dataArray.count) {
        self.currPage = 1;
    }else{
        self.currPage ++;
    }
    [self getDataWithTableView];
}

- (void)getDataWithTableView{
    NSLog(@"子类需要重写加载数据");
}


#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"子类需要重写Section");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"子类需要重写numberOfRowsInSection");
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"子类需要重写cellForRowAtIndexPath");
    NSString *ID = @"CELLID";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HidenKeybord;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
