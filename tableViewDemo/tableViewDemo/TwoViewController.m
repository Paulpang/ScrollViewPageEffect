//
//  TwoViewController.m
//  tableViewDemo
//
//  Created by Paul on 2017/7/26.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "TwoViewController.h"
#import "UIView+Extension.h"
#import "SubViewController.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define TitilesViewH  40

@interface TwoViewController ()<UIScrollViewDelegate>
/** 顶部视图 */
@property (nonatomic, weak) UIScrollView *titleView;
/** 底部的scrollView */
@property (nonatomic, weak) UIScrollView *contentView;
/** 顶部title */
@property (nonatomic, weak) UIButton *titleBtn;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 标题按钮 */
@property (nonatomic, weak) UIButton *button;
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;

@end

@implementation TwoViewController

#pragma mark - 监听事件
- (void)didClickTitleBtn:(UIButton *)button {
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        //        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.width = 20;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}


#pragma mark - 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"出借";
    self.view.backgroundColor = [UIColor greenColor];
    // 0.添加下拉返回
//    [self setupTipLabel];
    // 1.添加子控制器
    [self setupChildControllers];
    // 3.设置底部的scrollowView
    [self setupContentView];
    // 2.设置顶部的scrollowView
    [self setupTitleView];
    
}

// MARK: -- 设置底部的scrollView
- (void)setupContentView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame) + 64, kScreenWidth, kScreenHeight)];
    
    
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:contentView];
    //    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}
// MARK: -- 设置顶部标题的scrollView
- (void)setupTitleView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, TitilesViewH)];
    titleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor blueColor];
    indicatorView.height = 4;
    indicatorView.tag = -1;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部子控件
    NSInteger count = self.childViewControllers.count;
    //    CGFloat width = kScreenWidth/count;
    CGFloat width = kScreenWidth/4;
    CGFloat height = self.titleView.height;
    
    for (NSInteger i = 0; i < count; ++i) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitle:vc.title forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor: [UIColor whiteColor] forState:UIControlStateDisabled];
        
        [button addTarget:self action:@selector(didClickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:button];
        self.titleBtn = button;
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            //            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.width = 20;
            self.indicatorView.centerX = button.centerX;
        }
        titleView.contentSize = CGSizeMake((i+1) * width, 0);
    }
    [titleView addSubview:indicatorView];
    
}

- (void)setupChildControllers {
    
    SubViewController *activitiesVC = [[SubViewController alloc] init];
    activitiesVC.title = @"活动专区";
    [self addChildViewController:activitiesVC];
    
    SubViewController *sanbiaoVC = [[SubViewController alloc] init];
    sanbiaoVC.title = @"散标专区";
    [self addChildViewController:sanbiaoVC];
    
    SubViewController *qutouwenyingVC = [[SubViewController alloc] init];
    qutouwenyingVC.title = @"去投稳赢";
    [self addChildViewController:qutouwenyingVC];
    
    //    HYXDDingqiyouxuanController *dingqiyouxuanVC = [[HYXDDingqiyouxuanController alloc] init];
    //    dingqiyouxuanVC.title = @"定期优选";
    //    [self addChildViewController:dingqiyouxuanVC];
    //
    SubViewController *bianxianVC = [[SubViewController alloc] init];
    bianxianVC.title = @"变现专区";
    [self addChildViewController:bianxianVC];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 滚动标题栏（self.titlesScrollView）
    self.button = self.titleView.subviews[index];
    CGFloat titlesW = self.titleView.frame.size.width;
    CGFloat offsetX = self.button.center.x - titlesW * 0.5;
    // 最大的偏移量
    CGFloat maxOffsetX = self.titleView.contentSize.width - titlesW;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    CGPoint offset = CGPointMake(offsetX, self.titleView.contentOffset.y);
    [self.titleView setContentOffset:offset animated:YES];
    
    UIViewController *vc = self.childViewControllers[index];
    // 如果子控制器的view已经在上面，就直接返回
    if (vc.view.superview) return;
    
    // 添加
    CGFloat vcW = scrollView.frame.size.width;
    CGFloat vcH = scrollView.frame.size.height - TitilesViewH-49-40;
    CGFloat vcX = index * vcW;
    CGFloat vcY = TitilesViewH;
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    [scrollView addSubview:vc.view];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self didClickTitleBtn:self.titleView.subviews[index]];
}





@end
