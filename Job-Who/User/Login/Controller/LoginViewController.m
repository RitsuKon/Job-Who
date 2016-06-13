//
//  LoginViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/25.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *logoLabel;
@property (strong, nonatomic) UITextField *textAccount;
@property (strong, nonatomic) UITextField *textPassword;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *buttonRegist;
@property (strong, nonatomic) UIButton *buttonForgetPass;
@property (strong, nonatomic) UIButton *showPassword;
@property (nonatomic, retain) UIApplication *app;
@property NSInteger j;

//@property ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createLogo];
    [self createLogoName];
    [self creatText];
    [self buttonClick];
    [self createNaviWithType:1 withViewController:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - logo头像
- (void)createLogo {
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a.png"]];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(Width * 0.3, Width
        *0.3));
        make.left.equalTo(self.view).with.offset(Width * 0.35);
        make.top.equalTo(self.view).with.offset(Height * 0.25);
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = Width * 0.15;
        self.imageView.layer.borderWidth = 0.3;
    }];
    
    
    
}

#pragma mark - logo名称
- (void)createLogoName {
    self.logoLabel = [[UILabel alloc] init];
    self.logoLabel.textAlignment = NSTextAlignmentCenter;
    self.logoLabel.text = @"街活";
    [self.logoLabel setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.view addSubview:self.logoLabel];
    [self.logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.3, Height
                                         *0.1));
        make.left.equalTo(self.view).with.offset(Width * 0.35);
        make.top.equalTo(self.view).with.offset(Height * 0.25 + Width * 0.3);
    }];
}

#pragma mark - 账号密码框
- (void)creatText {
    self.textAccount = [[UITextField alloc] init];
    self.textPassword = [[UITextField alloc] init];
    [self.textAccount setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.textPassword setTranslatesAutoresizingMaskIntoConstraints:YES];
    self.textAccount.clearButtonMode = UITextFieldViewModeAlways;
    self.textPassword.clearButtonMode = UITextFieldViewModeAlways;
    self.textAccount.placeholder = @"请输入手机号";
    self.textAccount.layer.masksToBounds = YES;
    self.textAccount.layer.cornerRadius = 5;
    self.textPassword.layer.masksToBounds = YES;
    self.textPassword.layer.cornerRadius = 5;
    self.textAccount.backgroundColor = [UIColor whiteColor];
    self.textPassword.backgroundColor = [UIColor whiteColor];
    self.textPassword.placeholder = @"请输入密码";
    self.textAccount.delegate = self;
    self.textAccount.keyboardType = UIKeyboardTypeNumberPad;
    self.textPassword.delegate = self;
    self.textPassword.secureTextEntry = YES;
    [self.view addSubview:self.textAccount];
    [self.view addSubview:self.textPassword];
    [self.textAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.25 + Width * 0.3 + Height * 0.1);
    }];
    [self.textPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.25 + Width * 0.3 + Height * 0.17 + 10);
    }];
    
}

#pragma mark - 按钮
- (void)buttonClick {
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTranslatesAutoresizingMaskIntoConstraints:YES];
    self.loginButton.tintColor = [UIColor whiteColor];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius =5;
    self.loginButton.backgroundColor = [UIColor colorWithRed:(CGFloat)0 / 255 green:(CGFloat)120 / 255 blue:(CGFloat)78 / 255 alpha:1];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.8, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.25 + Width * 0.3 + Height * 0.24 + 30);
    }];
    [self.loginButton addTarget:self action:@selector(buttonLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonRegist = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonRegist setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.buttonRegist setTitle:@"快速注册" forState:UIControlStateNormal];
    self.buttonRegist.tintColor = [UIColor colorWithRed:(CGFloat)0 / 255 green:(CGFloat)120 / 255 blue:(CGFloat)78 / 255 alpha:1];
    self.buttonRegist.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:self.buttonRegist];

    [self.buttonRegist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.3, Height * 0.07));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.25 + Width * 0.3 + Height * 0.31 + 30);
    }];
    [self.buttonRegist addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonForgetPass = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonForgetPass setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.buttonForgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.buttonForgetPass.tintColor = [UIColor colorWithRed:(CGFloat)0 / 255 green:(CGFloat)120 / 255 blue:(CGFloat)78 / 255 alpha:1];
    self.buttonForgetPass.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.buttonForgetPass addTarget:self action:@selector(buttonForget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonForgetPass];
    [self.buttonForgetPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.3, Height * 0.07));
        make.right.mas_equalTo(self.view).with.offset(Width * -0.1);
        make.top.mas_equalTo(self.view).with.offset(Height * 0.25 + Width * 0.3 + Height * 0.31 + 30);
    }];
    
    self.showPassword = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.showPassword setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.showPassword setImage:[[UIImage imageNamed:@"眼睛.png"] imageWithRenderingMode:1] forState:UIControlStateNormal];
    [self.showPassword addTarget:self action:@selector(passwordShow:) forControlEvents:UIControlEventTouchUpInside];
    [self.textPassword addSubview:self.showPassword];
    


    
}

#pragma mark - textField 代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    if (textField == self.textPassword) {
//        if ([self.textAccount.text isEqualToString:@""]) {
////            [self alert:1 withTextField:self.textAccount];
////            self.view.frame = CGRectMake(0, 0, Width, Height);
//        } else {
            self.showPassword.frame = CGRectMake(self.textPassword.frame.size.width * 0.83, self.textPassword.frame.size.height / 2 - Width *0.025, Width * 0.05, Width * 0.05);
            [self.textPassword bringSubviewToFront:self.showPassword];
//        }

    } else {
        self.textAccount.delegate = self;
    }

}
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (0 == self.j) {
//        if (textField == self.textAccount) {
//            NSInteger i = [self valiMobile:self.textAccount.text];
//            switch (i) {
//                case 1:
//                    [self alert:i withTextField:self.textAccount];
//                    textField.text = @"";
//                    
//                    break;
//                case 2:
//                    [self alert:i withTextField:self.textAccount];
//                    textField.text = @"";
//                    break;
//                default:
//                    break;
//            }
//            
//        }
//      }
//    }
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, Width, Height);
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.showPassword.frame = CGRectMake(0, 0, 0, 0);
    return  YES;
}

#pragma mark - button 点击
- (void)passwordShow:(UIButton *)button {
    self.textPassword.secureTextEntry = !self.textPassword.secureTextEntry;
    NSString *str = self.textPassword.text;
    if (!self.textPassword.secureTextEntry) {
        self.textPassword.text = @" ";
        self.textPassword.text = str;
    } else {
        self.textPassword.text = @"";
        [self.textPassword insertText:str];
    }

}

#pragma mark - 登录
- (void)buttonLogin:(UIButton *)button {
    AppDelegate *app = [[AppDelegate alloc] init];
    app = [[UIApplication sharedApplication] delegate];
    app.window.rootViewController = app.tb;
}

#pragma mark - 注册跳转
- (void)regist:(UIButton *)button {
    self.j = 1;
    [self.textAccount resignFirstResponder];
    [self.textPassword resignFirstResponder];
    self.textPassword.text = @"";
    self.textAccount.text = @"";
#pragma mark - 注册
//    RegistPhoneNumberViewController *registPhoneNumber = [[RegistPhoneNumberViewController alloc] init];
//    [self changeNavigationBar];
//    [self.navigationController pushViewController:registPhoneNumber animated:YES];
    
    ApproveViewController *approve = [[ApproveViewController alloc] init];
    [self changeNavigationBar];
    [self.navigationController pushViewController:approve animated:NO];
}

#pragma mark - 忘记密码
- (void)buttonForget:(UIButton *)button {
//    ForegtViewController *forget = [[ForegtViewController alloc] init];
//    [self changeNavigationBar];
//    [self.navigationController pushViewController:forget animated:YES];
//    SkillSelectViewController *skill= [[SkillSelectViewController alloc] init];
//    [self.navigationController pushViewController:skill animated:YES];
    ServiceViewController *ss =[[ServiceViewController alloc] init];
    [self.navigationController pushViewController:ss animated:YES];
}
#pragma mark - 获取键盘高度
- (void)keyboardShow:(NSNotification *)notification {
    self.textAccount.delegate = self;
        NSDictionary *userinfo = [notification userInfo];
        NSValue *value = [userinfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [value CGRectValue];
    self.view.frame = CGRectMake(0,-keyboardRect.size.height, Width, Height);
}





#pragma mark - 空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.textAccount.delegate = nil;
    [self.textAccount resignFirstResponder];
    [self.textPassword resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, Width, Height);
}
- (void)viewWillAppear:(BOOL)animated {
    self.j = 0;
    [self.navigationController setNavigationBarHidden:YES];
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
