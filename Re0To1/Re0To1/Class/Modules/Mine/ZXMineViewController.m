//
//  ZXMineViewController.m
//  Re0To1
//
//  Created by windorz on 2019/9/3.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXMineViewController.h"
#import "ZXLogin.h"
#import <UIImageView+WebCache.h>

@interface ZXMineViewController () <UITableViewDelegate, UITableViewDataSource>
/** TableView */
@property (nonatomic, strong) UITableView *tableView;
/** TableViewHeaderView */
@property (nonatomic, strong) UIView *tableViewHeaderView;
/** HeaderViewImageView */
@property (nonatomic, strong) UIImageView *headerImageView;

@end

@implementation ZXMineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon/home_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 添加集合视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark Private Method
- (void)handleTapGesture {
    // 处理单击手势
    __weak typeof(self) weakSelf = self;
    if (![[ZXLogin sharedLogin] isLogin]) {
        // 没有登录的时候拉起登录
        [[ZXLogin sharedLogin] logInWithFinishBlock:^(BOOL isLogin) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            // SDK 流程判断是否登录
            if (isLogin) {
                [strongSelf.tableView reloadData];
            }
        }];
    } else {
        // 点击退出登录
        [[ZXLogin sharedLogin] logOut];
        [self.tableView reloadData];
    }
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCellID"];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        _tableViewHeaderView.backgroundColor = [UIColor whiteColor];

        // 添加一个头部的 ImageView
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 140)];
        [_tableViewHeaderView addSubview:_headerImageView];
        _headerImageView.backgroundColor = [UIColor whiteColor];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
        _headerImageView.clipsToBounds = YES;
        _headerImageView.userInteractionEnabled = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
        [_headerImageView addGestureRecognizer:tap];
    }

    return _tableViewHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        cell.textLabel.text = [[ZXLogin sharedLogin] isLogin] ? [ZXLogin sharedLogin].nick : @"昵称";
    } else {
        cell.textLabel.text = [[ZXLogin sharedLogin] isLogin] ? [ZXLogin sharedLogin].address : @"地区";
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (![[ZXLogin sharedLogin] isLogin]) {
        // 没登录设置普通图片
        [_headerImageView setImage:[UIImage imageNamed:@"icon.bundle/icon.png"]];
    } else {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[[ZXLogin sharedLogin] avatarUrl]]];
    }
}

@end
