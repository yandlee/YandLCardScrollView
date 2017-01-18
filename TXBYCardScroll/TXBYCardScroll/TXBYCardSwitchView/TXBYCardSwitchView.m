//
//  TXBYCardSwitchView.m
//  TXBYFelicity
//
//  Created by YandL on 16/2/2.
//  Copyright © 2016年 YandL  All rights reserved.
//

#import "TXBYCardSwitchView.h"

@implementation TXBYCardSwitchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cardSwitchScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _cardSwitchScrollView.backgroundColor = [UIColor clearColor];
        _cardSwitchScrollView.showsHorizontalScrollIndicator = NO;
        _cardSwitchScrollView.delegate = self;
        [self addSubview:_cardSwitchScrollView];
    }
    return self;
}

- (void)setIndex:(NSInteger)index {
    CGFloat ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    [self.cardSwitchScrollView setContentOffset:CGPointMake((230 + (ScreenWidth - 230) / 4) * index, 0) animated:YES];
}

- (void)setCardSwitchViewAry:(NSArray *)cardSwitchViewAry delegate:(id)delegate {
    _delegate = delegate;

    float space = 0;
    float width = 0;
    float viewWidth = 0;
    for (UIView *view in cardSwitchViewAry) {
        
        NSInteger index = [cardSwitchViewAry indexOfObject:view];
        
        if (index == 0) {
            viewWidth = view.frame.size.width;
        }
        
        space = self.frame.size.width - viewWidth;
        width = viewWidth + space/4;
        
        view.frame = CGRectMake(space/2 + (view.frame.size.width + space/4)*index, 0, viewWidth, view.frame.size.height);

        CGFloat y = index * width;
        CGFloat value = (0-y)/width;
        CGFloat scale = fabs(cos(fabs(value)*M_PI/5));
        
        view.transform = CGAffineTransformMakeScale(1.0, scale);
        view.alpha = scale * scale * scale;
        [_cardSwitchScrollView addSubview:view];
    }
    
    _cardSwitchScrollView.contentSize = CGSizeMake((space/2 + width*cardSwitchViewAry.count)+space/4, _cardSwitchScrollView.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    if (offset < 0) {
        return;
    }
    
    float space = 0;
    float viewWidth = 0;
    for (UIView *view in _cardSwitchScrollView.subviews) {
        NSInteger index = [_cardSwitchScrollView.subviews indexOfObject:view];
        
        if (index == 0) {
            viewWidth = view.frame.size.width;
        }
        space = self.frame.size.width - viewWidth;
        CGFloat width = viewWidth + space/4;
        CGFloat y = index * width;
        CGFloat value = (offset-y)/width;
        CGFloat scale = fabs(cos(fabs(value)*M_PI/5));
        
        view.transform = CGAffineTransformMakeScale(1.0, scale);
        view.alpha = scale * scale * scale;
    }
    
    float a = offset/(viewWidth + space/4);
    
    if (a - (int)a > 0.5) {
        _currentIndex = (int)a + 1;
    } else {
        _currentIndex = (int)a;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [self scrollToViewCenter];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollToViewCenter];
}

- (void)scrollToViewCenter {
    float space = 0;
    float viewWidth = 0;
    for (UIView *view in _cardSwitchScrollView.subviews) {
        NSInteger index = [_cardSwitchScrollView.subviews indexOfObject:view];
        
        if (index == 0) {
            viewWidth = view.frame.size.width;
        }
        space = self.frame.size.width - viewWidth;
    }
    
    [_cardSwitchScrollView scrollRectToVisible:CGRectMake(_currentIndex*(viewWidth + space/4), 0, _cardSwitchScrollView.frame.size.width, _cardSwitchScrollView.frame.size.height) animated:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(cardSwitchViewDidScroll:index:)]) {
        [_delegate cardSwitchViewDidScroll:self index:_currentIndex];
    }
}

@end
