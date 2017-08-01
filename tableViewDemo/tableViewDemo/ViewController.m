//
//  ViewController.m
//  tableViewDemo
//
//  Created by Paul on 2017/7/26.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"



@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)jump:(UIButton *)sender {
    
    OneViewController *oneVC = [[OneViewController alloc] init];
    
    [self.navigationController pushViewController:oneVC animated:YES];
    
}




@end
