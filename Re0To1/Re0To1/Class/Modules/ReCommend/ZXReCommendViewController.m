//
//  ZXReCommendViewController.m
//  Re0To1
//
//  Created by windorz on 2019/8/27.
//  Copyright © 2019 Q. All rights reserved.
//

#import "ZXReCommendViewController.h"

@interface ZXReCommendViewController () <UIGestureRecognizerDelegate>

@end

@implementation ZXReCommendViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon/like_selected@2x.png"];
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    
    // 创建 UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    
    NSArray *colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor]];
    
    for (int i = 0; i < 5; i++) {
        
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            view.backgroundColor = colors[i];
            view;
        })];
        
    }
    
    // 创建一个接受点击事件的视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    view.backgroundColor = [UIColor yellowColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    tap.delegate = self;
    [view addGestureRecognizer:tap];
    
    
    [scrollView addSubview:view];
    
    
    
    
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    
    
    
}

- (void)handleTapGesture {
    
    
    NSLog(@"Tap");
    
}


#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return YES;
}



@end
