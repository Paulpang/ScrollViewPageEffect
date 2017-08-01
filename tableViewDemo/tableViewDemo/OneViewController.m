//
//  OneViewController.m
//  tableViewDemo
//
//  Created by Paul on 2017/7/26.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "OneViewController.h"
#import "PayView.h"
#import "FooterView.h"
#import "TwoViewController.h"


#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define PayViewH 44

@interface OneViewController ()<UIScrollViewDelegate>
/** oneScrollView */
@property (nonatomic, strong) UIScrollView *scrollView;
/** view */
@property (nonatomic, strong) UIView *contentView;
/** payView */
@property (nonatomic, strong) PayView *payView;
/** footerView */
@property (nonatomic, strong) FooterView *footerView;
@property (assign, nonatomic)float TopViewScale;
/** UIVIEW */
@property (nonatomic, strong) UIView *twoView;
/** twoVC */
@property (nonatomic, strong) TwoViewController *twoVC;


@end

@implementation OneViewController

- (PayView *)payView {
    if (_payView == nil) {
        _payView = [PayView payView];
        _payView.frame = CGRectMake(0, ScreenHeight - PayViewH, ScreenWidth, PayViewH);
    }
    return _payView;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - PayViewH)];
        _contentView.backgroundColor = [UIColor blueColor];
        
        CGFloat footerViewH = 44;
        FooterView *footerView = [FooterView footerView];
        footerView.frame = CGRectMake(0, _contentView.frame.size.height - footerViewH, ScreenWidth, footerViewH);
        footerView.backgroundColor = [UIColor redColor];
        self.footerView = footerView;
        
        [_contentView addSubview:self.footerView];
    }
    return _contentView;
}


- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - PayViewH)];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.pagingEnabled = YES;//进行分页
//        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.contentSize = CGSizeMake(ScreenWidth, (ScreenHeight - PayViewH) * 2);
        
        // 添加第一个 View
        [_scrollView addSubview:self.contentView];
        // 添加第二个 View
        [_scrollView addSubview:self.twoVC.view];
        
        
    }
    return _scrollView;
   
}

// 第二个界面
- (UIView *)twoView {
    if (_twoView == nil) {
        _twoView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - PayViewH, ScreenWidth, ScreenHeight - PayViewH)];
        _twoView.backgroundColor = [UIColor yellowColor];
    }
    return _twoView;
}



- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    twoVC.view.frame = CGRectMake(0, ScreenHeight - PayViewH, ScreenWidth, ScreenHeight - PayViewH);
    self.twoVC = twoVC;
    [self addChildViewController:self.twoVC];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.payView];
    
}

- (void)backToTop {
    NSLog(@"==========");
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToTop) name:@"notification" object:nil];
    
    [self setupUI];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView.contentOffset.y <0) {
        NSLog(@" scrollView =  %f",scrollView.contentOffset.y);
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y > 30 && scrollView.contentOffset.y < ScreenHeight - PayViewH){
        NSLog(@" scrollView =  %f",scrollView.contentOffset.y);
        scrollView.pagingEnabled = NO;
        [self.scrollView setContentOffset:CGPointMake(0, ScreenHeight - PayViewH) animated:YES];
        
    }else {
        NSLog(@" scrollView =  %f",scrollView.contentOffset.y);
        scrollView.pagingEnabled = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }];
        
    }

}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
   
    [self scrollViewDidEndDragging:scrollView willDecelerate:YES];
    
}






@end
