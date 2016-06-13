//
//  OrderTableViewHeaderFooterView.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/1.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "OrderCancelView.h"

@interface OrderCancelView()
@property (strong, nonatomic) UIImageView *imaggeView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIButton *buttonCancel;

@end

@implementation OrderCancelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self createImageView];
        [self createLabel];
        [self createButton];
    }
    return self;
}

- (void)createImageView {
    self.imaggeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"喇叭.png"]];
    [self addSubview:self.imaggeView];
    [self.imaggeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.mas_equalTo(self).with.offset(Width * 0.01);
        make.top.mas_equalTo(self).with.offset(2);
    }];
}

- (void)createLabel {
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor lightGrayColor];
    self.label.font = [UIFont systemFontOfSize:13];
    self.label.text= @"超过30分钟无人接单,系统将自动取消订单";
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, self.frame.size.height));
        make.left.mas_equalTo(self).with.offset(Width * 0.01 + 20);
        make.top.mas_equalTo(self).with.offset(0);
    }];
}
- (void)createButton {
    self.buttonCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonCancel setImage:[[UIImage imageNamed:@"叉叉.png"] imageWithRenderingMode:1] forState:UIControlStateNormal];
    [self.buttonCancel addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.buttonCancel];
    [self.buttonCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.right.mas_equalTo(self).with.offset(Width * -0.01);
        make.top.mas_equalTo(self).with.offset(2);
    }];
}
- (void)button:(UIButton *)button {
    [self removeFromSuperview];
    self.block(button);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
