//
//  ViewController.m
//  TXBYCardScroll
//
//  Created by YandL on 16/12/10.
//  Copyright © 2016年 YandL. All rights reserved.
//

#import "ViewController.h"
#import "TXBYCardSwitchView.h"
#import "TXBYAlertView.h"

@interface ViewController ()

@property (nonatomic, strong) TXBYCardSwitchView *cardSwitchView;

@property (nonatomic,strong) NSArray *dicAry;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:151/255.0 green:190/255.0 blue:230/255.0 alpha:1.0];
    _cardSwitchView = [[TXBYCardSwitchView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 450)];
    [_cardSwitchView setCardSwitchViewAry:[self ittemsCardSwitchViewAry] delegate:self];
    [self.view addSubview:_cardSwitchView];
}

- (NSArray *)dicAry {
    if (!_dicAry) {
        _dicAry = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"card" ofType:@"plist"]];
    }
    return _dicAry;
}

/**
 *  准备添加到卡片切换View上的View数组
 */
- (NSArray *)ittemsCardSwitchViewAry {
    NSMutableArray *ary = [NSMutableArray new];
    
    for (int index = 0; index < self.dicAry.count; index ++) {
        NSDictionary *felicityDic = self.dicAry[index];
        
        NSString *title = felicityDic[@"title"];
        NSString *image = felicityDic[@"image"];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 230, 460)];
        backView.tag = index;
        
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, 20)];
        [backView addSubview:headImageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headImageView.frame.size.width, 20)];
        titleLabel.center = headImageView.center;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:23];
        titleLabel.textColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0];
        [backView addSubview:titleLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 230, 350)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:image];
        imageView.userInteractionEnabled = YES;
        imageView.tag = index;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        [backView addSubview:imageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(25, imageView.frame.origin.y + imageView.frame.size.height + 20, 180, 40);
        button.tag = index;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        [button setTitle:@"点我点我" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.userInteractionEnabled = YES;
        [backView addSubview:button];
        
        [ary addObject:backView];
    }
    return ary;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self.cardSwitchView setIndex:tap.view.tag];
}

- (void)btnClick:(UIButton *)btn {
    TXBYAlertView *aleView = [TXBYAlertView alertWithTitle:@"你好" message:[NSString stringWithFormat:@"你点第%ld个干什么哟", btn.tag + 1] buttonTitles:@"尴尬", nil];
    [aleView showWithClickBlock:^(NSInteger index) {
//        [self btnClick:btn];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
