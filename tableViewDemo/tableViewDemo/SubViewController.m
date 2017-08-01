//
//  SubViewController.m
//  tableViewDemo
//
//  Created by Paul on 2017/7/28.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "SubViewController.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SubViewController ()<UIScrollViewDelegate>

/** TipLabel */
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTipLabel];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"textid"];
    
}
- (void)setupTipLabel {
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, 64)];
    tipLabel.text = @"下拉返回";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:tipLabel];
    self.tipLabel = tipLabel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textid" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"cell- %zd",indexPath.row];
    
    return cell;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < -30) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:nil userInfo:nil];
        
    }else {
        scrollView.bounces = YES;
        self.tableView.scrollEnabled = YES;
    }

}



@end
