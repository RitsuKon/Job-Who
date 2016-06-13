//
//  NavigationView.h
//  Job-Who
//
//  Created by 金洪生 on 16/5/31.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^buttonClick)(UIButton *button);
typedef void(^buttonCollect)(UIButton *button);
typedef void(^buttonRight)(UIButton *button);
typedef void (^cancel)(UISearchBar *searchBar);
typedef void (^switchBlock)(UISwitch *switchButton);
@interface NaView : UIView
@property (copy, nonatomic) buttonClick block;
@property (copy, nonatomic) buttonCollect blockCollect;
@property (copy, nonatomic) buttonRight blockRight;
@property (copy, nonatomic) cancel cancelBlock;
@property (copy, nonatomic) switchBlock blockSwitch;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic) UIButton *buttonRight;

- (instancetype) initWithFrame:(CGRect)frame withType:(NSInteger )i;
@end
