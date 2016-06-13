//
//  SettingPassWordViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/26.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "SettingPassWordViewController.h"

@interface SettingPassWordViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UIButton *showPassword;
@end

@implementation SettingPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviWithType:0 withViewController:self];
    self.naviView.titleLabel.text = @"设置密码";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createTextSetting];
    [self createButton];
    // Do any additional setup after loading the view.
}

#pragma mark - 设置密码
- (void)createTextSetting {
    self.textSetting = [[UITextField alloc] init];
    self.textSetting.placeholder = @"设置密码";
    self.textSetting.layer.masksToBounds = YES;
    self.textSetting.delegate = self;
    self.textSetting.clearButtonMode = UITextFieldViewModeAlways;
    self.textSetting.secureTextEntry = YES;
    self.textSetting.layer.cornerRadius = 5;
    self.textSetting.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textSetting];
    [self.textSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.15);
    }];
    
}

#pragma mark - button
- (void)createButton {
    self.buttonRegist = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonRegist setTintColor:[UIColor whiteColor]];
    [self.buttonRegist setTitle:@"注册" forState:UIControlStateNormal];
    self.buttonRegist.backgroundColor = [UIColor colorWithRed:(CGFloat)0 / 255 green:(CGFloat)120 / 255 blue:(CGFloat)78 / 255 alpha:1];
    self.buttonRegist.layer.masksToBounds = YES;
    self.buttonRegist.layer.cornerRadius = 5;
    [self.buttonRegist addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonRegist];
    [self.buttonRegist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.27);
    }];
    self.showPassword = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.showPassword setImage:[[UIImage imageNamed:@"眼睛.png"] imageWithRenderingMode:1] forState:UIControlStateNormal];
    [self.showPassword addTarget:self action:@selector(passwordShow:) forControlEvents:UIControlEventTouchUpInside];
    [self.textSetting addSubview:self.showPassword];
}

#pragma mark - 空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.showPassword.frame = CGRectMake(0, 0, 0, 0);
    [self.textSetting resignFirstResponder];
}

#pragma mark - textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.showPassword.frame = CGRectMake(0, 0, 0, 0);
    [self.textSetting resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.showPassword.frame = CGRectMake(self.textSetting.frame.size.width * 0.83, self.textSetting.frame.size.height / 2 - Width *0.025, Width * 0.05, Width * 0.05);
    [self.textSetting bringSubviewToFront:self.showPassword];
}

#pragma mark - button 点击
- (void)passwordShow:(UIButton *)button {
    self.textSetting.secureTextEntry = !self.textSetting.secureTextEntry;
    NSString *str = self.textSetting.text;
    if (!self.textSetting.secureTextEntry) {
        self.textSetting.text = @" ";
        self.textSetting.text = str;
    } else {
        self.textSetting.text = @"";
        [self.textSetting insertText:str];
    }
    
}

- (void)buttonClick:(UIButton *)button {
    if (![self.textSetting.text isEqualToString:@""]) {
        self.textSetting.text = @"";
        [self.textSetting resignFirstResponder];
        [self alert];
    } else {
        [self alertFailed];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 成功提示框
- (void)alert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {

        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark - 失败提示框
- (void)alertFailed {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
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
