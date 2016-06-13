//
//  NavigationView.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/31.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "NaView.h"

@interface NaView()<UISearchBarDelegate>
@property (strong, nonatomic) UIButton *buttonBack;
@property (strong, nonatomic) UIButton *buttonCollect;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *buttonLocation;
@property (strong, nonatomic) UISwitch *switchButton;
@end

@implementation NaView

- (instancetype) initWithFrame:(CGRect)frame withType:(NSInteger )i {
    self = [super initWithFrame:(CGRect)frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        switch (i) {
            case 0:
                self.frame = CGRectMake(0, 0, Width, 64);
                [self createLabel];
                [self createButton];
                break;
            case 1:
                self.frame = CGRectMake(0, 0, 0, 0);
                break;
            case 2:
                self.frame = CGRectMake(0, 0, Width, 64);
                [self createLabel];
                [self createButton];
                [self createCollect];
                break;
            case 3:
                self.frame = CGRectMake(0, 0, Width, 64);
                [self createLabel];
                [self createImage];
                [self createLocationButton];
                break;
            case 4:
                [self createLabel];
                [self createButton];
                [self createButtonRight];
                break;
            case 5:
                [self createLabel];
                [self createButton];
                [self createSwitch];
            default:
                break;
        }

    }
    return self;
}

- (void)createLabel {
    self.titleLabel = [[UILabel alloc] init];
//    self.titleLabel.text = @"sdasd";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.3, 64));
        make.left.mas_equalTo(self).with.offset(Width * 0.35);
        make.top.mas_equalTo(self).with.offset(10);
        
    }];
}
- (void)createButton {
    self.buttonBack = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonBack setImage:[[UIImage imageNamed:@"左箭头.png"] imageWithRenderingMode:1]forState:UIControlStateNormal];
    [self.buttonBack addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.buttonBack];
    [self.buttonBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(self).with.offset(Width * 0.05);
        make.top.mas_equalTo(self).with.offset(32);
        
    }];
    

}
- (void)createCollect {
    self.buttonCollect = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonCollect setImage:[[UIImage imageNamed:@"collect.png"] imageWithRenderingMode:1]forState:UIControlStateNormal];
    [self.buttonCollect addTarget:self action:@selector(buttonCollect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.buttonCollect];
    [self.buttonCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(self).with.offset(Width * -0.05);
        make.top.mas_equalTo(self).with.offset(32);
        
    }];
}
- (void)createSearchBar {
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.showsCancelButton = YES;
    self.searchBar.delegate = self;
    [self addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.75, 20));
        make.left.mas_equalTo(self).with.offset(Width * 0.125);
        make.top.mas_equalTo(self).with.offset(32);
        
    }];
}
- (void)createImage {
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"定位灰.png"]];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(self).with.offset(Width * 0.35 - 20);
        make.top.mas_equalTo(self).with.offset(32);
        
    }];
}
- (void)createLocationButton {
    self.buttonLocation = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.buttonLocation];
    [self.buttonLocation setImage:[[UIImage imageNamed:@"箭头下.png"] imageWithRenderingMode:1] forState:UIControlStateNormal];
    [self.buttonLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(self).with.offset(Width * - 0.35 + 20);
        make.top.mas_equalTo(self).with.offset(32);
        
    }];
}
- (void)createButtonRight {
    self.buttonRight = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonRight.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.buttonRight addTarget:self action:@selector(buttonRight:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.buttonRight];
    [self.buttonRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.15, 20));
        make.right.mas_equalTo(self).with.offset(Width * - 0.05);
        make.top.mas_equalTo(self).with.offset(32);
        
    }];
}
- (void)createSwitch {
    self.switchButton = [[UISwitch alloc] init];
    [self addSubview:self.switchButton];
    [self.switchButton setOn:NO];
    
//    [self.switchButton set];
//    self.switchButton.backgroundColor = Color_System;
    [self.switchButton addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventValueChanged];
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.15, 20));
        make.right.mas_equalTo(self).with.offset(Width * - 0.05);
        make.top.mas_equalTo(self).with.offset(26);
        
    }];
}
- (void)switchButton:(UISwitch *)switchButton {
    self.blockSwitch(switchButton);
}
- (void)buttonRight:(UIButton *)button {
    self.blockRight(button);
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.cancelBlock(searchBar);
}
- (void)buttonCollect:(UIButton *)button {
    self.blockCollect(button);
}
- (void)button:(UIButton *)button {
    self.block(button);
}

@end
