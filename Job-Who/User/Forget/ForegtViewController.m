//
//  ForegtViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/26.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "ForegtViewController.h"

@interface ForegtViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *textPhone;
@property (strong, nonatomic) UITextField *textCode;
@property (strong, nonatomic) UIButton *buttonCode;
@property (strong, nonatomic) UIButton *buttonNext;
@end

@implementation ForegtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createNaviWithType:0 withViewController:self];
    self.naviView.titleLabel.text = @"输入手机号";
    [self createTextField];
    [self createButton];
    // Do any additional setup after loading the view.
}

#pragma mark - textField
- (void)createTextField {
    self.textPhone = [[UITextField alloc] init];
    self.textPhone.placeholder = @"请输入注册手机号";
    self.textPhone.layer.masksToBounds = YES;
    self.textPhone.layer.cornerRadius = 5;
    self.textPhone.clearButtonMode = UITextFieldViewModeAlways;
    self.textPhone.keyboardType = UIKeyboardTypeNumberPad;
    self.textPhone.backgroundColor = [UIColor whiteColor];
    self.textPhone.delegate = self;
    [self.view addSubview:self.textPhone];
    [self.textPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.15);
    }];
    
    self.textCode = [[UITextField alloc] init];
    self.textCode.placeholder = @"输入验证码";
    self.textCode.layer.masksToBounds = YES;
    self.textCode.layer.cornerRadius = 5;
    self.textCode.delegate = self;
    self.textCode.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textCode];
    [self.textCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.4, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.27);
    }];
    
}

#pragma mark - button
- (void)createButton {
    self.buttonCode = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonCode setTintColor:[UIColor whiteColor]];
    [self.buttonCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.buttonCode.backgroundColor = Color_System;
    self.buttonCode.layer.masksToBounds = YES;
    self.buttonCode.layer.cornerRadius = 5;
    [self.view addSubview:self.buttonCode];
    [self.buttonCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.35, Height * 0.07));
        make.right.mas_equalTo(self.view).with.offset(Width * -0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.27);
    }];
    
    self.buttonNext = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonNext setTintColor:[UIColor whiteColor]];
    [self.buttonNext setTitle:@"下一步" forState:UIControlStateNormal];
    self.buttonNext.backgroundColor = Color_System;
    self.buttonNext.layer.masksToBounds = YES;
    self.buttonNext.layer.cornerRadius = 5;
    [self.buttonNext addTarget:self action:@selector(buttonNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonNext];
    [self.buttonNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.39);
    }];
    
}
#pragma mark - 空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textPhone resignFirstResponder];
    [self.textCode resignFirstResponder];
}
#pragma mark - textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textCode resignFirstResponder];
    return YES;
}

#pragma mark - button点击
- (void)buttonNext:(UIButton *)button {
    NSInteger i = [self valiMobile:self.textPhone.text];
    if (0 == i) {
        if ([self.textCode.text isEqualToString:@""]) {
            [self alert];
        } else {
            ResetPasswordViewController *reset = [[ResetPasswordViewController alloc] init];
            [self changeNavigationBar];
            self.textCode.text = @"";
            self.textPhone.text = @"";
            [self.textPhone resignFirstResponder];
            [self.textCode resignFirstResponder];
            [self.navigationController pushViewController:reset animated:YES];
        }

    } else {
        [self alert];
    }
    

}

#pragma mark - 提示框
- (void)alert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号或者验证码不正确" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
