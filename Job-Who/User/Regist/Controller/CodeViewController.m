//
//  CodeViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/26.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "CodeViewController.h"

@interface CodeViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *textCode;
@property (strong, nonatomic) UIButton *buttonNext;
@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createNaviWithType:0 withViewController:self];
    self.naviView.titleLabel.text = @"验证码";
    [self createLabel];
    [self createTextField];
    [self createButton];
    // Do any additional setup after loading the view.
}

#pragma mark - label
- (void)createLabel {
    self.label = [[UILabel alloc] init];
    self.label.text = [NSString stringWithFormat:@"验证码已发送至%@", self.str];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.13);
    }];
}

#pragma mark - textField
- (void)createTextField {
    self.textCode = [[UITextField alloc] init];
    self.textCode.layer.masksToBounds= YES;
    self.textCode.delegate = self;
    self.textCode.backgroundColor = [UIColor whiteColor];
    self.textCode.clearButtonMode = UITextFieldViewModeAlways;
    self.textCode.placeholder = @"输入验证码";
    self.textCode.layer.cornerRadius = 5;
    [self.view addSubview:self.textCode];
    [self.textCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.25);
    }];
}

#pragma mark - button
- (void)createButton {
    self.buttonNext = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonNext setTintColor:[UIColor whiteColor]];
    [self.buttonNext setTitle:@"下一步" forState:UIControlStateNormal];
    self.buttonNext.layer.masksToBounds = YES;
    self.buttonNext.layer.cornerRadius = 5;
    self.buttonNext.backgroundColor = [UIColor colorWithRed:(CGFloat)0 / 255 green:(CGFloat)120 / 255 blue:(CGFloat)78 / 255 alpha:1];
    [self.view addSubview:self.buttonNext];
    [self.buttonNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.37);
    }];
    [self.buttonNext addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textCode resignFirstResponder];
}

#pragma mark - textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textCode resignFirstResponder];
    return YES;
}
#pragma mark - 点击
- (void)button:(UIButton *)button {
    SettingPassWordViewController *spw = [[SettingPassWordViewController alloc] init];
    [self changeNavigationBar];
    [self.navigationController pushViewController:spw animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
