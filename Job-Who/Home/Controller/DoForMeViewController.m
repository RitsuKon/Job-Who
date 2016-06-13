//
//  DoForMeViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/8.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "DoForMeViewController.h"

@interface DoForMeViewController ()<CNContactPickerDelegate>
@property (strong, nonatomic) CNContactPickerViewController *con;
@property(strong, nonatomic) CNContact *contact;//联系人
@end

@implementation DoForMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviView.titleLabel.text = @"帮我办";
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceTableViewCell *cellService = [tableView dequeueReusableCellWithIdentifier:@"service"];
    if (0 == indexPath.section) {
        ReceiveAndGetTableViewCell *cellReceiveAndGet = [tableView dequeueReusableCellWithIdentifier:@"ReceiveAndGet"];
            NSString *str = @"服务地点*";
            cellReceiveAndGet.addressLabel.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            
            if (self.addressDetail == NULL) {
                self.addressDetail = @"";
            }
            
            cellReceiveAndGet.address.text = [NSString stringWithFormat:@"%@%@",self.addressStr, self.addressDetail];
            self.get = [NSString stringWithFormat:@"%@", cellReceiveAndGet.address.text];
            cellReceiveAndGet.addressImage.image = [UIImage imageNamed:@"定位绿.png"];
        
        return cellReceiveAndGet;
    } else if (1 == indexPath.section) {
        DateTableViewCell *cellDate = [tableView dequeueReusableCellWithIdentifier:@"date"];
        cellDate.time.text = @"请选择服务时间";
        [cellDate.buttonReceive setTitle:@"立即服务" forState:UIControlStateNormal];
        NSString *str = @"服务时间*";
        cellDate.timeLabel.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
        __weak typeof(cellDate) weakSelf = cellDate;
        if (0 == self.timeTag) {
            cellDate.block = ^(UIButton *button) {
                weakSelf.time.text = [self getDateFromSystem];
                self.receiveTime = [NSString stringWithFormat:@"%@",weakSelf.time.text];
            };
            //            cellDate.time.text = self.strTime;
        } else {
            cellDate.time.text = self.strTime;
            self.receiveTime = [NSString stringWithFormat:@"%@",cellDate.time.text];
        }
        
        return cellDate;
    } else if (2 == indexPath.section) {
        GoodsTableViewCell *cellGoods = [tableView dequeueReusableCellWithIdentifier:@"goods"];
            cellGoods.i = 3;
            cellGoods.goodsImage.image = [UIImage imageNamed:@"信息.png"];
            cellGoods.goodsLabel.text = @"物品信息";
            cellGoods.goodsView.text = @"排队占座,医院挂号,统统帮你搞定";
            cellGoods.block = ^(UITextView *textView) {
                self.keyboardTag = 1;
                self.sendTableView.scrollEnabled = NO;
            };
            cellGoods.blockBack = ^(UITextView *textView) {
                self.keyboardTag = 0;
                if (0 == self.cancelTag) {
                    self.sendTableView.frame = CGRectMake(0, 84, Width, Height - 84);
                } else {
                    self.sendTableView.frame = CGRectMake(0, 64, Width, Height - 64);
                }
                self.sendTableView.scrollEnabled = YES;
            };
            cellGoods.textViewBlock = ^(UITextView *textView) {
                self.goodInfo = [NSString stringWithFormat:@"%@",textView.text];
                if ([textView.text isEqualToString:@""]) {
                    textView.text = @"排队占座,医院挂号,通通帮你搞定";
                }
            };
        
        return cellGoods;
    } else if (3 == indexPath.section) {
        TelephoneTableViewCell *cellTele = [tableView dequeueReusableCellWithIdentifier:@"tele"];
        
        cellTele.returnBlock = ^(UITextField *textField) {
            self.keyboardTag = 0;
            if (0 == self.cancelTag) {
                self.sendTableView.frame = CGRectMake(0, 84, Width, Height - 84);
            } else {
                self.sendTableView.frame = CGRectMake(0, 64, Width, Height - 64);
            }
            self.sendTableView.scrollEnabled = YES;
        };
        cellTele.beginBlock = ^(UITextField *textField) {
            self.keyboardTag = 1;
            
            if (0 == self.cancelTag) {
                self.sendTableView.frame = CGRectMake(0, 84 + self.sendTableView.contentOffset.y - 216, Width, Height - 84);
            } else {
                self.sendTableView.frame = CGRectMake(0, 64 + self.sendTableView.contentOffset.y - 216, Width, Height - 64);
            }
            [self.view bringSubviewToFront:self.naviView];
            self.sendTableView.scrollEnabled = NO;
        };
                    cellTele.endBlock = ^(UITextField *textField) {
                self.receiveNumber = [NSString stringWithFormat:@"%@",textField.text];
            };
            cellTele.teleImage.image = [UIImage imageNamed:@"电话 (1).png"];
            NSString *str = @"收货人电话*";
            cellTele.teleLabel.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            [cellTele.buttonRight setImage:[[UIImage imageNamed:@"通讯录 (1).png"]imageWithRenderingMode:1] forState:UIControlStateNormal];
            cellTele.telephone.text = self.receiveNumber;
            cellTele.block = ^(UIButton *button) {
                self.numberTag = 1;
                self.con = [[CNContactPickerViewController alloc] init];
                self.con.delegate = self;
                [self presentViewController:self.con animated:YES completion:^{
                    
                }];
            };
        
        
        return cellTele;
    } else if (4 == indexPath.section) {
        self.tagRepeat = 0;
        cellService.i = self.tagRepeat;
        cellService.labelTitle.text = @"服务费";
        if (0 == self.lta || 0 == self.lon || 0 == self.getLta || 0 == self.getLon) {
            self.money1 = 0;
            cellService.moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.money1];

        } else {
            self.instance = [self distanceBetweenLtaBegin:self.lta withLonBegin:self.lon withLtaEnd:self.getLta withLonEnd:self.getLon];
#pragma mark - 根据距离算钱------未完成
            self.money1 = 10;
            cellService.moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.money1];

        }
        
        return cellService;
    } else if (5 == indexPath.section) {
        self.tagRepeat = 1;
        cellService.i = self.tagRepeat;
        cellService.labelTitle.text = @"加小费";
        if ([self.strMoney isEqualToString:@""] || [self.strMoney isEqualToString:@"0"]) {
            
            cellService.moneyText.placeholder = @"请输入小费金额";
        } else {
            
            cellService.moneyText.text = self.strMoney;
        }
        __weak typeof(cellService) weakSelf1 = cellService;
        cellService.endBlock = ^(UITextField *textField) {
            //            NSLog(@"????????????");
            self.strMoney = [NSString stringWithFormat:@"%@",textField.text];
            self.smallmoney = self.strMoney.doubleValue;
            
            
            
            [self.sendTableView reloadData];
            //            NSLog(@"%@",weakSelf1.moneyText.text);
            self.keyboardTag = 0;
            if (0 == self.cancelTag) {
                self.sendTableView.frame = CGRectMake(0, 84, Width, Height - 84);
            } else {
                self.sendTableView.frame = CGRectMake(0, 64, Width, Height - 64);
            }
            self.sendTableView.scrollEnabled = YES;
        };
        cellService.block = ^(UITextField *textField) {
            self.keyboardTag = 1;
            self.smallmoney = 0;
            if (0 == self.cancelTag) {
                self.sendTableView.frame = CGRectMake(0, 84- 216, Width, Height - 84);
            } else {
                self.sendTableView.frame = CGRectMake(0, 64  - 216, Width, Height - 64);
            }
            [self.view bringSubviewToFront:self.naviView];
            self.sendTableView.scrollEnabled = NO;
        };
        
        return cellService;
    } else if (6 == indexPath.section) {
        self.tagRepeat = 2;
        cellService.i = self.tagRepeat;
        
        if (0 == self.money1) {
            if (0 != self.smallmoney) {
                cellService.moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.smallmoney];
            } else {
                cellService.moneyLabel.text = @"0";
            }
        } else {
            self.money = self.money1 + self.smallmoney;
            cellService.moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.money];
        }
        cellService.labelTitle.text = @"订单总价";
        
        return cellService;
    } else {
        [self.sendTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tagRepeat = 3;
        cellService.i = self.tagRepeat;
        cellService.buttonBlock = ^(UIButton *button) {
            
            if ([self.receiveTime isEqualToString:@""] || self.receiveTime == NULL) {
                [self alertWithError:2];
            } else if ([self.receiveNumber isEqualToString:@""] || self.receiveNumber == NULL) {
                [self alertWithError:5];
            } else {
#pragma mark ---生成订单-未完成
            }
        };
        return cellService;
    }
    
}
#pragma mark - 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {

            return [ReceiveAndGetTableViewCell  heightForCell:[NSString stringWithFormat:@"%@%@",self.addressStr, self.addressDetail]] + Height * 0.02;
        
    } else if (2 == indexPath.section) {

            return Height * 0.2;

    } else {
        return self.sendTableView.rowHeight = Height * 0.07;
    }
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
