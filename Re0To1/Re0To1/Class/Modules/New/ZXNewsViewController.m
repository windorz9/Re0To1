//
//  ZXNewsViewController.m
//  Re0To1
//
//  Created by windorz on 2019/6/4.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXNewsViewController.h"
#import "ZXNormalTableViewCell.h"
#import "ZXDetailViewController.h"
#import "ZXDeleteCellView.h"

@interface ZXNewsViewController () <UITableViewDataSource, UITableViewDelegate, ZXNormalTableViewCellDelegate>
/** TableView */
@property(nonatomic, strong) UITableView *tableView;
/** 数据源数组 */
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZXNewsViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [_dataArray addObject:@(i)];
        }
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

    [cell layoutTableViewCell];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZXDetailViewController *vc = [[ZXDetailViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ZXNormalTableViewCellDelegate
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteBtn:(UIButton *)deleteBtn {
    
    // 显示删除界面
    ZXDeleteCellView *deleteView = [[ZXDeleteCellView alloc] initWithFrame:self.view.bounds];
    // 获取按钮相对于 self.view 的坐标
    CGRect rect = [tableViewCell convertRect:deleteBtn.frame toView:nil];
    __weak typeof(self) wself = self;
    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
        NSLog(@"点击删除按钮");
        __strong typeof(self) strongSelf = wself;
        // 删除对应的数据源
        NSIndexPath *indexPath = [strongSelf.tableView indexPathForCell:tableViewCell];
        [strongSelf.dataArray removeObjectAtIndex:indexPath.row];
        [strongSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
}



@end
