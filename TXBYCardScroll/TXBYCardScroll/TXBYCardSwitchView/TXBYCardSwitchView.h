//
//  TXBYCardSwitchView.h
//  TXBYCardSwitchView
//
//  Created by YandL on 16/2/2.
//  Copyright © 2016年 YandL  All rights reserved.
//

#import <UIKit/UIKit.h>

#define TXBYUIColorWithHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1]

@class TXBYCardSwitchView;

@protocol TXBYCardSwitchViewDelegate <NSObject>

- (void)cardSwitchViewDidScroll:(TXBYCardSwitchView *)cardSwitchView index:(NSInteger)index;

@end

@interface TXBYCardSwitchView : UIView <UIScrollViewDelegate>

@property (nonatomic,assign) id<TXBYCardSwitchViewDelegate> delegate;
@property (nonatomic,strong) UIScrollView *cardSwitchScrollView;
@property (nonatomic,assign) float currentIndex;

- (void)setIndex:(NSInteger)index;

- (void)setCardSwitchViewAry:(NSArray *)cardSwitchViewAry delegate:(id)delegate;

@end
