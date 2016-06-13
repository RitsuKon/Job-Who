//
//  AddressSelectViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/28.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "AddressSelectViewController.h"

@interface AddressSelectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableViewForAddress;
@property (strong, nonatomic) DetailAddressTableViewCell *cellDetail;
@property (strong, nonatomic) UIButton *buttonSave;
@end

@implementation AddressSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviWithType:2 withViewController:self];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.naviView.titleLabel.text = @"选择地址";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTableView];
    [self createButton];
    // Do any additional setup after loading the view.
}

#pragma mark - table
- (void)createTableView {
    self.tableViewForAddress = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + Height * 0.05, Width, Height * 0.1) style:1];
    self.tableViewForAddress.delegate = self;
    self.tableViewForAddress.dataSource = self;
    self.tableViewForAddress.scrollEnabled = NO;
    self.tableViewForAddress.rowHeight = Height * 0.05;
    [self.tableViewForAddress registerClass:[UITableViewCell class] forCellReuseIdentifier:@"addressShow"];
    [self.tableViewForAddress registerClass:[DetailAddressTableViewCell class] forCellReuseIdentifier:@"addressDetail"];
    [self.view addSubview:self.tableViewForAddress];

    
}
#pragma mark - button
- (void)createButton {
    self.buttonSave = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonSave setTintColor:[UIColor whiteColor]];
    self.buttonSave.layer.masksToBounds = YES;
    self.buttonSave.layer.cornerRadius = 5;
    [self.buttonSave setTitle:@"保存" forState:UIControlStateNormal];
    self.buttonSave.backgroundColor = Color_System;
    [self.buttonSave addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonSave];
    [self.buttonSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.5, Height * 0.08));
        make.left.mas_equalTo(self.view).with.offset(Width * 0.25);
        make.top.mas_equalTo(self.view).with.offset(64 + Height * 0.2);
        
    }];
    
}
#pragma mark - button点击事件
- (void)button:(UIButton *)button {
    
    [self.cellDetail.textFieldForAddress resignFirstResponder];
    [self alert];
    
}
#pragma mark - 提示框
- (void)alert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SendForMeViewController *sendForMe = [[SendForMeViewController alloc] init];

        
        NSArray *temArray = self.navigationController.viewControllers;
        
        for(UIViewController *temVC in temArray)
            
        {
            
            if ([temVC isKindOfClass:[SendForMeViewController class]])
                
            {
                sendForMe = (SendForMeViewController *)temVC;
                if (0 == self.tagAddress) {
                    sendForMe.getLta = self.poiInfo.pt.latitude;
                    sendForMe.getLon = self.poiInfo.pt.longitude;
                    sendForMe.addressReceive = [NSString stringWithFormat:@"%@%@",self.poiInfo.name, self.cellDetail.textFieldForAddress.text];
                } else {
                    sendForMe.lta = self.poiInfo.pt.latitude;
                    sendForMe.lon = self.poiInfo.pt.longitude;

                    sendForMe.addressDetail = [NSString stringWithFormat:@"%@%@",self.poiInfo.name,self.cellDetail.textFieldForAddress.text];
                }
                [self.navigationController popToViewController:sendForMe animated:YES];
                
            }
            
        }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressShow"];
    self.cellDetail = [tableView dequeueReusableCellWithIdentifier:@"addressDetail"];
    cell.selectionStyle = 0;
    self.cellDetail.selectionStyle = 0;
    if (indexPath.row == 0) {
        cell.textLabel.text = self.poiInfo.name;
        return cell;
        
    } else {
        return self.cellDetail;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.cellDetail.textFieldForAddress resignFirstResponder];
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
