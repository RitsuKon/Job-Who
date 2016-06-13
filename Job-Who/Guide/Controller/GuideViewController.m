//
//  GuideViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/24.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *guideScrollView;
@property (nonatomic, retain) UIButton *buttonClick;
@property (nonatomic, retain) UIApplication *app;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initForGuideScrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化scrollView
- (void)initForGuideScrollView {
    self.guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    self.guideScrollView.contentSize = CGSizeMake(Width * 3, 0);
    self.guideScrollView.pagingEnabled = YES;
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame = self.guideScrollView.frame;
    imageView1.backgroundColor = [UIColor redColor];
    [self.guideScrollView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.frame = CGRectMake(Width, 0, Width, Height);
    imageView2.backgroundColor = [UIColor yellowColor];
    [self.guideScrollView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.frame = CGRectMake(Width * 2, 0, Width, Height);
    imageView3.backgroundColor = [UIColor blueColor];
    [self.guideScrollView addSubview:imageView3];
    [self.view addSubview:self.guideScrollView];
    self.guideScrollView.delegate = self;
    

    
}
#pragma mark - scrollView滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.guideScrollView.contentOffset.x == Width * 2) {
        if (self.buttonClick == NULL) {
            [self initForButton];
        }
    }
}
#pragma mark - 初始化button
- (void)initForButton {
    self.buttonClick = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.buttonClick.frame = CGRectMake(100, 100, 100, 50);
    [self.buttonClick setTitle:@"立即体验" forState:0];
    self.buttonClick.layer.masksToBounds = YES;
    self.buttonClick.layer.cornerRadius = 5;
    self.buttonClick.backgroundColor = [UIColor yellowColor];
    [self.buttonClick addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.guideScrollView addSubview:self.buttonClick];
    [self.buttonClick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(Height * 0.8, 100, Height * 0.15, 100));
    }];

}

#pragma mark - button点击事件
- (void)button:(UIButton *)button {
    LoginViewController *login = [[LoginViewController alloc] init];
    AppDelegate *app = [[AppDelegate alloc] init];
    app.naviForLogin = [[UINavigationController alloc] initWithRootViewController:login];
    app = [[UIApplication sharedApplication] delegate];
    app.window.rootViewController = app.naviForLogin;
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
