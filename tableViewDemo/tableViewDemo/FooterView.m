//
//  FooterView.m
//  tableViewDemo
//
//  Created by Paul on 2017/7/27.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "FooterView.h"

@implementation FooterView

+ (instancetype)footerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
