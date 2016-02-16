//
//  HCActivatedTableViewController.m
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCActivatedTableViewController.h"
#import "HCTagManagerDetailViewController.h"

#import "HCTagManagerInfo.h"
#import "HCTagManagerApi.h"

#import "HCTagManagerHeader.h"
#import "HCTagManagerTableViewCell.h"

#define activatedcell @"activatedcell"
@interface HCActivatedTableViewController ()<HCTagManagerTableViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *categoryArray;
@end

@implementation HCActivatedTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = HCTabelHeadView(0.1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestHomeData];
    [self.tableView registerClass:[HCTagManagerTableViewCell class] forCellReuseIdentifier:activatedcell];

}

#pragma mark---UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCTagManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:activatedcell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    HCTagManagerInfo *info = self.dataSource[indexPath.section];
    cell.info = info;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark--UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_WIDTH - 60)/3 +50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HCTagManagerHeader *header = [[HCTagManagerHeader alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), 60)];
    if (section == 0) [self.categoryArray removeAllObjects];
    [self.categoryArray addObject:header];
    HCTagManagerInfo *info = self.dataSource[section];
    header.titleString = info.tagUserName;
    header.tag = section;
    [header addTarget:self action:@selector(handleHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
    if (info.isShowRow)
    {
        header.markImgView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HCTagManagerInfo *info = self.dataSource[section];
    if (info.isShowRow)
    {
        NSInteger count = info.imgArr.count % 3;
        NSInteger row = (count) ? 1 : 0;
        return ((int)info.imgArr.count/3) + row;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

#pragma mark---HCTagManagerTableViewCellDelegate

-(void)HCTagManagerTableViewCell:(NSIndexPath *)indexPath tag:(NSInteger)tag
{
    NSInteger index = tag+indexPath.row*3;
    HCTagManagerInfo *info = self.dataSource[indexPath.section];
    
    HCTagManagerDetailViewController *detailVC = [[HCTagManagerDetailViewController alloc]init];
    detailVC.data = @{@"data":info};
    detailVC.index = index;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - private methods

- (void)handleHeaderButton:(HCTagManagerHeader *)headerBtn
{
    HCTagManagerInfo *info = self.dataSource[headerBtn.tag];
    info.isShowRow = !info.isShowRow;
    [self.tableView reloadData];
}

#pragma  mark---Setter Or Getter

- (NSMutableArray *)categoryArray
{
    if (!_categoryArray)
    {
        _categoryArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _categoryArray;
}

#pragma mark - network

- (void)requestHomeData
{
    HCTagManagerApi *api = [[HCTagManagerApi alloc] init];
    api.Start = 1000;
    api.Count = 20;
    api.LabelStatus = @"已激活";
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSArray *array) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
        }else
        {
            [self showHUDError:message];
        }
    }];
}


@end