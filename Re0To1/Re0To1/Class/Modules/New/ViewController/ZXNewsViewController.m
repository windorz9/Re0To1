//
//  ZXNewsViewController.m
//  Re0To1
//
//  Created by windorz on 2019/6/4.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXNewsViewController.h"
#import "ZXNormalTableViewCell.h"
//#import "ZXDetailViewController.h"
#import "ZXMediator.h"
#import "ZXDeleteCellView.h"
#import "ZXListLoader.h"
#import "ZXListItem.h"
#import "ZXScreen.h"
#import "ZXSearchBar.h"
#import "ZXCommentManager.h"

@interface ZXNewsViewController () <UITableViewDataSource, UITableViewDelegate, ZXNormalTableViewCellDelegate>
/** TableView */
@property(nonatomic, strong) UITableView *tableView;
/** 数据源数组 */
@property(nonatomic, strong) NSArray *dataArray;
/** 网络请求 */
@property(nonatomic, strong) ZXListLoader *lisLoader;

@end

@implementation ZXNewsViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon/page_selected@2x.png"];
    }
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建一个最基本的 UITableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 添加一个网络请求
    ZXListLoader *listLoader = [[ZXListLoader alloc] init];
    __weak typeof(self) wself = self;
    [listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<ZXListItem *> *dataArray) {
        __strong typeof(self) strongSelf = wself;
        NSLog(@"");
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
    self.lisLoader = listLoader;
    
    // 添加一个导航栏分享按钮
    // 为什么在这里获取不到导航栏
    // 添加一个搜索栏
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    /**
    // 展示搜索框
    ZXSearchBar *searchBar = [[ZXSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - UI(20), self.navigationController.navigationBar.bounds.size.height)];
    [self.tabBarController.navigationItem setTitleView:searchBar];
     */
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - UI(20), self.navigationController.navigationBar.bounds.size.height)];
    [searchBtn addTarget:self action:@selector(_clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitle:@"弹出全景文本框" forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.tabBarController.navigationItem setTitleView:searchBtn];

}

#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZXNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[ZXNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellID"];
        cell.delegate = self;
    }

    ZXListItem *item = self.dataArray[indexPath.row];
    [cell layoutTableViewCellWithItem:item];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZXListItem *item = self.dataArray[indexPath.row];
    
    // 0. 普通跳转
    //    ZXDetailViewController *vc = [[ZXDetailViewController alloc] initWithUrlString:item.ariticleUrl];
    
    // 1. TargetAction 跳转
//    __kindof UIViewController *vc = [ZXMediator detailViewControllerWithUrl:item.ariticleUrl];
//    [self.navigationController pushViewController:vc animated:YES];
    
    // 2. URLScheme 跳转
//    [ZXMediator openUrl:@"detail://" params:@{
//                                              @"url" : item.ariticleUrl,
//                                              @"navigation" : self.navigationController
//                                              }];
    
    // 3. Protocol Class 进行跳转
    Class cls = [ZXMediator classForProtocol:@protocol(ZXDetailViewControllerProtocol)];
    [self.navigationController pushViewController:[[cls alloc] detailViewControllerWithUrl:item.ariticleUrl] animated:YES];
    
    // 添加处理已读状态
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniquekey];
    [tableView reloadData];
    
}

#pragma mark ZXNormalTableViewCellDelegate
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteBtn:(UIButton *)deleteBtn {
    
    // 显示删除界面
//    ZXDeleteCellView *deleteView = [[ZXDeleteCellView alloc] initWithFrame:self.view.bounds];
//    // 获取按钮相对于 self.view 的坐标
//    CGRect rect = [tableViewCell convertRect:deleteBtn.frame toView:nil];
//    __weak typeof(self) wself = self;
//    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
//        NSLog(@"点击删除按钮");
//        __strong typeof(self) strongSelf = wself;
//        // 删除对应的数据源
//        NSIndexPath *indexPath = [strongSelf.tableView indexPathForCell:tableViewCell];
//        [strongSelf.dataArray removeObjectAtIndex:indexPath.row];
//        [strongSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
    
}


#pragma mark Private Method
- (void)_clickSearchBtn {
    
    [[ZXCommentManager sharedManager] showCommentView];
    
}



@end
