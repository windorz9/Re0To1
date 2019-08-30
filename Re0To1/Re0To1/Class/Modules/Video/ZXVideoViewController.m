//
//  ZXVideoViewController.m
//  Re0To1
//
//  Created by windorz on 2019/8/27.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXVideoViewController.h"
#import "ZXVideoCoverCell.h"

@interface ZXVideoViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

static NSString *const CollectionViewID = @"CollectionViewID";
@implementation ZXVideoViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon/video_selected@2x.png"];
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 插件一个集合视图
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [collectionView registerClass:[ZXVideoCoverCell class] forCellWithReuseIdentifier:CollectionViewID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
}

#pragma mark UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZXVideoCoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    [cell layoutWithVideoCoverUrl:@"icon.bundle/videoCover@3x.png" videoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    return cell;

}

#pragma mark <##>UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (indexPath.item % 3 == 0) {
//
//        return CGSizeMake(self.view.bounds.size.width, 100);
//    } else {
//
//        return CGSizeMake((self.view.bounds.size.width - 10)/2, 300);
//
//    }
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
