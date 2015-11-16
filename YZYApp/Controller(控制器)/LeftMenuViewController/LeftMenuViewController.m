//
//  LeftMenuViewController.m
//  YZYApp
//
//  Created by 123 on 15/10/13.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "LeftMenuViewController.h"
#define SLIDE_OFFSET_PORTRAIT 100

@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *menuTableViewDataSource;
    NSMutableArray *groupTableViewDataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@property (weak, nonatomic) IBOutlet UITableView *groupTableView;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem.image = [[UIImage imageNamed:@"menu-button"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _menuTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    
    [self makeMenuTableViewDataSource];
}

- (void)makeMenuTableViewDataSource{
    menuTableViewDataSource = [NSMutableArray new];
    NSArray *dataSource = @[@"精彩内容",@"Discover校友",@"通知",@"我的学校"];
    [menuTableViewDataSource addObjectsFromArray:dataSource];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _groupTableView) {
        UIView *groupHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(7, 15, 100, 20)];
        title.textColor = [UIColor whiteColor];
        title.text = @"关注小组";
        title.font = [UIFont fontWithName:@"ProximaNova-Light" size:13.0];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, 36, tableView.frame.size.width - 15, 1)];
        line.backgroundColor = [UIColor grayColor];
        
        [groupHeaderView addSubview:title];
        [groupHeaderView addSubview:line];
        
        return groupHeaderView;
    }
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == _groupTableView) {
       UIButton * _addGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addGroupBtn.frame = CGRectMake(5, 2, tableView.frame.size.width - SLIDE_OFFSET_PORTRAIT -16, 40);
        [_addGroupBtn setImage:[UIImage imageNamed:@"添加小组"] forState:UIControlStateNormal];
        [_addGroupBtn addTarget:self action:@selector(addGroup) forControlEvents:UIControlEventTouchUpInside];
        return _addGroupBtn;
    }
    return [UIView new];
}
- (void)addGroup{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _menuTableView) {
        return menuTableViewDataSource.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _menuTableView) {
        static NSString *menuCellID = @"menuCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellID];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = menuTableViewDataSource[indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:menuTableViewDataSource[indexPath.row]];
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
