//
//  ViewController.m
//  DFLLabelView
//
//  Created by 杭州移领 on 17/2/9.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "ViewController.h"
#import "DFLLabelView.h"
#import "DFLConst.h"
#import "SelectCategoryView.h"
#import "SizeCategoryView.h"
#import "CategoryCell.h"
#import "SizeCell.h"
#define TABLEVIEWHEADERHEIGHT 200
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) UIView *tableViewHeaderView;
@end

@implementation ViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"CategoryCell"];
         [_tableView registerClass:[SizeCell class] forCellReuseIdentifier:@"SizeCell"];
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, TABLEVIEWHEADERHEIGHT)];
        self.tableViewHeaderView = [[UIView alloc] initWithFrame:self.backView.bounds];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 30)];
        label.backgroundColor = [UIColor yellowColor];
        [self.tableViewHeaderView addSubview:label];
        [self.backView addSubview:self.tableViewHeaderView];
        self.tableViewHeaderView.backgroundColor = [UIColor redColor];
        _tableView.tableHeaderView = self.backView;
        [_tableView insertSubview:self.tableViewHeaderView atIndex:0];
     
    }
    return _tableView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *datas = @[
                       @{@"颜色":@[@"红",@"蓝",@"黑",@"黄",@"绿"]},
                       @{@"大小":@[@"180",@"170",@"160",@"175",@"185"]},
                       @{@"品牌":@[@"大宝",@"gucci",@"雅霜"]},
                       ];
    NSDictionary *dic = @{
                          @"颜色":@[@"红",@"蓝",@"黑",@"黄",@"绿"],
                          @"大小":@[@"180",@"170",@"160",@"175",@"185"],
                          @"品牌":@[@"大宝",@"gucci",@"雅霜"],
                          };
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
        cell.categorys = @[
                           @"男装",
                           @"化妆品",
                           @"电脑办公",
                           @"男装",
                           @"化妆品",
                           @"电脑办公",
                           @"男装",
                           @"化妆品",
                           @"电脑办公",
                           ];
        
        return cell;
    } else if (1 == indexPath.section) {
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
        cell.categorys = @[
                           @"男装",
                           @"化妆品",
                           @"电脑办公",
                           @"男装",
                           @"化妆品",
                           @"电脑办公",
                           @"男装",
                           @"化妆品",
                           @"电脑办公",
                           ];
        
        return cell;

    
   } else  {
        SizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SizeCell" forIndexPath:indexPath];
        cell.sizeArray = @[
                           @(indexPath.row).stringValue ,
                           @"化妆品",
                           @"电脑办公",
                           @"男装",
                           @"化妆品",
                           @"电脑办公",
                           @"男装",
                           @"化妆品",
                           @"电脑办公",
                           ];
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return [CategoryCell getCellHeight:@[
                                             @"男装",
                                             @"化妆品",
                                             @"电脑办公",
                                             @"男装",
                                             @"化妆品",
                                             @"电脑办公",
                                             @"男装",
                                             @"化妆品",
                                             @"电脑办公",
                                             ]];
    }else if (1==  indexPath.section){
        return [CategoryCell getCellHeight:@[
                                             @"男装",
                                             @"化妆品",
                                             @"电脑办公",
                                             @"男装",
                                             @"化妆品",
                                             @"电脑办公",
                                             @"男装",
                                             @"化妆品",
                                             @"电脑办公",
                                             ]];

    } else {
        return [SizeCell getCellHeight:@[
                                         @(indexPath.row).stringValue ,
                                         @"化妆品",
                                         @"电脑办公",
                                         @"男装",
                                         @"化妆品",
                                         @"电脑办公",
                                         @"男装",
                                         @"化妆品",
                                         @"电脑办公",
                                         ]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = self.backView.frame;
    if (scrollView.contentOffset.y <= 0) {
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
    frame.size.height = (scrollView.contentOffset.y) + TABLEVIEWHEADERHEIGHT;
    self.backView.frame = frame;
    self.tableViewHeaderView.center = self.backView.center;
//    [self.tableView insertSubview:self.tableViewHeaderView atIndex:0];
}


@end
