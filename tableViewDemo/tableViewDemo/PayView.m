//
//  PayView.m
//  tableViewDemo
//
//  Created by Paul on 2017/7/27.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "PayView.h"

@interface PayView ()

@end

@implementation PayView


+ (instancetype)payView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

- (IBAction)calculator:(UIButton *)sender {
}
- (IBAction)payBtn:(UIButton *)sender {
}


@end
