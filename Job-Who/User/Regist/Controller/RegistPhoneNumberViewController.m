//
//  RegistPhoneNumberViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/26.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "RegistPhoneNumberViewController.h"

@interface RegistPhoneNumberViewController ()
@property (strong, nonatomic) UITextField *textPhone;
@property (strong, nonatomic) UIButton *buttonNext;
@end

@implementation RegistPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviWithType:0 withViewController:self];
    self.naviView.titleLabel.text = @"注册";

    [self settingsForView];
    [self createTextfield];
    [self creatButton];
    // Do any additional setup after loading the view.
}

#pragma mark - vc设置
- (void)settingsForView {
    self.view.backgroundColor = [UIColor lightGrayColor];
//    [self.navigationController setNavigationBarHidden:NO];
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(CGFloat)0 / 255 green:(CGFloat)120 / 255 blue:(CGFloat)78 / 255 alpha:1];
//    self.title = @"注册";
    
}

#pragma mark- textField
- (void)createTextfield {
    self.textPhone = [[UITextField alloc] init];
    self.textPhone.placeholder = @"请输入手机号";
    self.textPhone.layer.masksToBounds = YES;
    self.textPhone.backgroundColor = [UIColor whiteColor];
    self.textPhone.layer.cornerRadius = 5;
    self.textPhone.clearButtonMode = UITextFieldViewModeAlways;
    self.textPhone.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.textPhone];
    [self.textPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.15);
    }];
}
#pragma mark - 按钮
- (void)creatButton {
    self.buttonNext = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonNext.layer.masksToBounds = YES;
    self.buttonNext.layer.cornerRadius = 5;
    [self.buttonNext setTitle:@"下一步" forState:UIControlStateNormal];
    self.buttonNext.backgroundColor = [UIColor colorWithRed:(CGFloat)0 / 255 green:(CGFloat)120 / 255 blue:(CGFloat)78 / 255 alpha:1];
    [self.buttonNext setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.buttonNext];
    [self.buttonNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.27);
    }];
    [self.buttonNext addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - button点击事件
- (void)button:(UIButton *)button {
    CodeViewController *code = [[CodeViewController alloc] init];
    code.str = [NSString stringWithString:self.textPhone.text];

    NSInteger i = [self valiMobile:self.textPhone.text];
    switch (i) {
        case 1:
            [self alert:i withTextField:self.textPhone];
            self.textPhone.text = @"";
            break;
        case 2:
            [self alert:i withTextField:self.textPhone];
            self.textPhone.text = @"";
            break;
            
        default:
            [self changeNavigationBar];
            self.textPhone.text = @"";
            [self.textPhone resignFirstResponder];
            [self.navigationController pushViewController:code animated:YES];
            break;
    }
}
#pragma mark - 空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textPhone resignFirstResponder];
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
