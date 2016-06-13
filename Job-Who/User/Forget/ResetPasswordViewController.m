//
//  ResetPasswordViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/26.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createNaviWithType:0 withViewController:self];
    self.naviView.titleLabel.text = @"设置新密码";
    self.textSetting.placeholder = @"输入新密码";
    [self.buttonRegist setTitle:@"完成" forState:UIControlStateNormal];
    [self.buttonRegist addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

#pragma mark - 点击事件
- (void)button:(UIButton *)button {
    [self alert];
}

#pragma mark - 提示框
- (void)alert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设置成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
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
