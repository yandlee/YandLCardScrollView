//
//  TXBYAlertView.h
//  TXBYAlertViewDemo
//
//  Created by fergusding on 15/5/26.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TXBYAlertViewDelegate;

@interface TXBYAlertView : UIView

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (weak, nonatomic) id<TXBYAlertViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message delegate:(id<TXBYAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

typedef void (^alertClickBlock)(NSInteger index);

/**
 *  用于回调cell的block
 */
@property (nonatomic, copy) alertClickBlock block;

/**
 *  显示alertView
 */
- (void)show;

/**
 *  显示alertView 带点击回调
 */
- (void)showWithClickBlock:(alertClickBlock)block;

/**
 *  快速创建一个alertView 带点击回调
 */
+ (TXBYAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSString *)btnTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  隐藏
 */
- (void)hide;

/**
 *  设置标题颜色 默认黑色
 *  设置标题字体 默认14.0
 */
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

/**
 *  设置内容颜色 默认黑色
 *  设置内容字体 默认12.0
 */
- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size;


/**
 *  设置每个按钮颜色 默认黑色
 *  设置内容字体 默认16.0
 */
- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index;

@end

/**
 *  点击协议 可用showWithClickBlock方法替代
 */
@protocol TXBYAlertViewDelegate <NSObject>

- (void)alertView:(TXBYAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
