//
//  ServiceViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/9.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSInteger i;//开工按钮的判断
@property (assign, nonatomic) NSInteger j;//能够修改的cell的判断
@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createNaviWithType:5 withViewController:self];
    self.naviView.titleLabel.text = @"服务主页";
    self.naviView.backgroundColor = [UIColor clearColor];
    self.naviView.titleLabel.textColor = [UIColor whiteColor];
    __weak typeof(self)weakSelf = self;
    self.naviView.blockSwitch = ^(UISwitch *switchButton) {
        if (switchButton.on) {
            weakSelf.i = 1;
        } else {
            weakSelf.i = 2;
        }
        [weakSelf.tableView reloadData];

    };
    [self createTableView];
    [self.view bringSubviewToFront:self.naviView];
    // Do any additional setup after loading the view.
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,- 20, Width, Height) style:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = 0;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.tableView registerClass:[MyServiceTableViewCell class] forCellReuseIdentifier:@"myService"];
    [self.tableView registerClass:[InfoServiceTableViewCell class] forCellReuseIdentifier:@"infoService"];
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#pragma sasdadawd
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        MyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myService"];
        cell.i = self.i;
        return cell;
    } else {
        InfoServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoService"];
        if (1 == indexPath.section) {
            cell.showLabel.text = @"技能";
        } else if (2 == indexPath.section) {
            cell.showLabel.text = @"简介";
        } else if (3 == indexPath.section) {
            cell.showLabel.text = @"个人相册";
        } else if (4 == indexPath.section) {
            cell.showLabel.text = @"个人服务";
        } else {
            cell.showLabel.text = @"服务评价";
        }
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return Height * 0.5;
    } else {
        return Height * 0.07;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

        return CGFLOAT_MIN;

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
