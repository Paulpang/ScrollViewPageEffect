//
//  UIView+Extension.h
//  NewQutoubao
//
//  Created by 庞小江 on 16/8/11.
//  Copyright © 2016年 Hengyuanxinda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)


@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

/**
 * 从xib价值控件
 */
+ (instancetype)viewFromXib;

@end
