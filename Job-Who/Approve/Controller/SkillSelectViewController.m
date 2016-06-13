//
//  SkillSelectViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/8.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "SkillSelectViewController.h"


@interface SkillSelectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *arrayTitle;//技能标题
@property (strong, nonatomic) NSMutableArray *arrayForRun;//跑腿
@property (strong, nonatomic) NSMutableArray *arrayForHome;//家政
@property (strong, nonatomic) NSMutableArray *arrayForCar;//车辆
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *dic;//存选择的技能的字典
@property (strong, nonatomic) NSMutableArray *arr;//存字典的数组
@end

@implementation SkillSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self changeNavigationBar];
    [self dataForSkill];
    [self createNaviWithType:0 withViewController:self];
    self.naviView.titleLabel.text = @"技能选择";
    self.view.backgroundColor = [UIColor lightGrayColor];
//    self.dic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.arr = [NSMutableArray arrayWithCapacity:0];
    [self createTableView];
    // Do any additional setup after loading the view.
}
#pragma mark - 创建tableview
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, Width, Height - 74) style:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SkillSelectTableViewCell class] forCellReuseIdentifier:@"skillSelect"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SkillSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"skillSelect"];
    if (3 == indexPath.section) {
        self.tableView.separatorStyle = 0;
        cell.backgroundColor = self.tableView.backgroundColor;
        cell.i = 3;
        cell.touchBlock = ^(UIButton *button) {
#pragma mark - 提交审核---未完成
            
        };
    } else {
        if (0 == indexPath.section) {
            cell.i = 0;
        } else if (1 == indexPath.section) {
            cell.i = 1;
        } else {
            cell.i = 2;
        }
        cell.arrayForRun = [NSMutableArray array];
        cell.arrayForHome = [NSMutableArray array];
        cell.arrayForCar = [NSMutableArray array];
        cell.arrayForRun = self.arrayForRun;
        cell.arrayForHome = self.arrayForHome;
        cell.arrayForCar = self.arrayForCar;
//        NSLog(@"%ld",cell.arrayForRun.count);
        cell.block = ^(SkillDetailTableViewCell *cellSkill) {
            NSString *section = [NSString stringWithFormat:@"%ld", cellSkill.i];
            NSString *row = [NSString stringWithFormat:@"%ld", cellSkill.j];
            self.dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:cellSkill.skillLabel.text, @"skill", section, @"section", row, @"row", nil];
            [self.arr addObject:self.dic];
        
            
        };
        cell.blockCancel = ^(SkillDetailTableViewCell *cellSkill) {
            int flag = 0;
            int tag = 0;
            for (int i = 0; i < self.arr.count; i ++) {
                if ([[self.arr[i] objectForKey:@"skill"] isEqualToString:cellSkill.skillLabel.text]) {
                    flag = 1;
                    tag = i;
                    break;
                } else {
                    continue;
                }
            }
            if (1 == flag) {
                [self.arr removeObjectAtIndex:tag];
            }

        };
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return self.arrayForRun.count * Height * 0.07;
    } else if (1 == indexPath.section) {
        return self.arrayForHome.count * Height * 0.07;
    } else if (2 == indexPath.section) {
        return self.arrayForCar.count * Height * 0.07;
    } else {
        return Height * 0.07;
    }
}
#pragma mark - 技能标题下的数据解析
- (void)dataForSkill {
    self.arrayTitle = [NSMutableArray arrayWithObjects:@"跑腿", @"家政", @"车辆", nil];
    self.arrayForRun = [NSMutableArray arrayWithObjects:@"帮我送", @"帮我买", @"帮我办", nil];
    self.arrayForHome = [NSMutableArray arrayWithObjects:@"保洁清洗", @"保姆月嫂", @"电器维修", nil];
    self.arrayForCar = [NSMutableArray arrayWithObjects:@"顺风车", @"代驾", @"跨车捎带", @"婚车", nil];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (3 == section) {
        return nil;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height * 0.07)];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(Width * 0.05 , view.frame.size.height / 2 - 8, 16, 16);
        [view addSubview:imageView];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(Width * 0.05 + 21, 0 , Width *0.3, view.frame.size.height);
        [view addSubview:label];
        if (0 == section) {
            imageView.image = [UIImage imageNamed:@"标题0.png"];
            label.text = @"跑腿";
        } else if (1 == section) {
            imageView.image = [UIImage imageNamed:@"标题1.png"];
            label.text = @"家政";
        } else {
            imageView.image = [UIImage imageNamed:@"标题2.png"];
            label.text = @"车辆";
        }
        label.font = [UIFont systemFontOfSize:15];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (3 == section) {
        return 10;
    } else {
        return Height *0.07;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (2 == section) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, Width, 20);
        [view addSubview:label];
//        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:12];
        NSString *str = [NSString stringWithFormat:@"*车辆以下的技能必须将个人驾驶证"];
        NSString *str2 = [NSString stringWithFormat:@"照片提交审核*"];
        NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str attributes:nil];
        NSMutableAttributedString *muStr2 = [[NSMutableAttributedString alloc] initWithString:str attributes:nil];
        muStr = [self attributeString:str withLocation:0 withLength:1];
        muStr2 = [self attributeString:str2 withLocation:str2.length - 1 withLength:1];
        
         [muStr appendAttributedString:muStr2];
        label.attributedText = muStr;
        return view;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (2 == section) {
        return 20;
    } else {
        return 10;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:YES];
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
