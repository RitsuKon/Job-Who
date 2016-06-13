//
//  BuyForMeViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/8.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "BuyForMeViewController.h"

@interface BuyForMeViewController ()<CNContactPickerDelegate>
@property (strong, nonatomic) CNContactPickerViewController *con;
@property(strong, nonatomic) CNContact *contact;//联系人
@property (strong, nonatomic) NSString *myStr;
//@property (strong, nonatomic) NSString *buyAddress;
//@property (strong, nonatomic) NSString *sendAddress;
//@property (strong, nonatomic) NSString *sendDate;
//@property (strong, nonatomic) NSString *goodType;
//@property (strong, nonatomic) NSString *goodInfo;
//@property (strong, nonatomic) NSString *tele;
//@property (assign, nonatomic) double serviceMoney;
//@property (assign, nonatomic) double instance;
//@property (assign, nonatomic) double smallMoney;
//@property (assign, nonatomic) double allMoney;
//@property (strong, nonatomic) UITableView *tableView;
//@property (assign, nonatomic) NSInteger cancelTag;//判断黄色label的X按钮是否关闭
//@property (assign, nonatomic) NSInteger keyboardTag;//判断键盘是否回收
@end

@implementation BuyForMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.cancelTag = 0;
//    self.keyboardTag = 0;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createNaviWithType:4 withViewController:self];
    self.naviView.titleLabel.text = @"帮我买";
    [self.naviView.buttonRight setTitle:@"收费标准" forState:UIControlStateNormal];
    [self.naviView.buttonRight setTintColor:Color_System];
    self.naviView.blockRight = ^(UIButton *button) {
        NSLog(@"dadad");
    };
    [self.sendTableView registerClass:[BuyTableViewCell class] forCellReuseIdentifier:@"buy"];
//    [self createTableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section || 2 == section) {
        return 2;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceTableViewCell *cellService = [tableView dequeueReusableCellWithIdentifier:@"service"];
    if (0 == indexPath.section) {
        BuyTableViewCell *cellBuy = [tableView dequeueReusableCellWithIdentifier:@"buy"];
        cellBuy.selectionStyle = 0;
        
        NSString *str = [NSString stringWithFormat:@"%@%@",self.addressStr,self.addressReceive];
        if (self.getLon == 0 || self.getLta == 0) {
            cellBuy.address = @"请选择购买地址";
        } else {
            
            cellBuy.address = [NSString stringWithFormat:@"%@", str];
            NSLog(@"为何没有值%@",cellBuy.address);
        }
        [cellBuy.selectTableView reloadData];
//        NSLog(@"能不能传回来%@,%f,%f",[NSString stringWithFormat:@"%@,%@",self.addressStr,self.addressReceive],self.getLta,self.getLon);
        if (0 == indexPath.row) {
            cellBuy.info = ^(UITableView *tableView) {
                AddressChooseViewController *addressChoose = [[AddressChooseViewController alloc] init];
                addressChoose.lta = self.lta;
                addressChoose.lon = self.lon;
                addressChoose.str = self.addressStr;
                self.tagAddress = 0;
                addressChoose.tagAddress = self.tagAddress;
                [self.navigationController pushViewController:addressChoose animated:YES];
//                [tableView reloadData];
            };
            cellBuy.noSelect = ^(NSString *str) {
                self.myStr = [NSString stringWithFormat:@"%@", str];
                [self.sendTableView reloadData];
            };
//            cellReceiveAndGet.addressLabel.text = @"购买地址";
//            cellReceiveAndGet.address.text = @"请填写取货地址";
//            
//            if (![self.addressReceive isEqualToString:@""]) {
//                cellReceiveAndGet.address.text = [NSString stringWithFormat:@"%@%@",self.addressStr, self.addressReceive];
//            }
//            self.receive = [NSString stringWithFormat:@"%@", cellReceiveAndGet.address.text];
//            cellReceiveAndGet.addressImage.image = [UIImage imageNamed:@"定位灰.png"];
            return cellBuy;
        } else {
            ReceiveAndGetTableViewCell *cellReceiveAndGet = [tableView dequeueReusableCellWithIdentifier:@"ReceiveAndGet"];
            NSString *str = @"送货地址*";
            cellReceiveAndGet.addressLabel.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            
            if (self.addressDetail == NULL) {
                self.addressDetail = @"";
            }
            
            cellReceiveAndGet.address.text = [NSString stringWithFormat:@"%@%@",self.addressStr, self.addressDetail];
            self.get = [NSString stringWithFormat:@"%@", cellReceiveAndGet.address.text];
            cellReceiveAndGet.addressImage.image = [UIImage imageNamed:@"定位绿.png"];
            return cellReceiveAndGet;
        }
        
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
        if (0 == indexPath.row) {
            cellGoods.i = 0;
            cellGoods.imageRight.image = [UIImage imageNamed:@"detail.png"];
            cellGoods.goodsImage.image = [UIImage imageNamed:@"类型.png"];
            NSString *str = @"物品类型*";
            cellGoods.goodsLabel.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            
            if ([self.strType isEqualToString:@""] || self.strType == NULL) {
                cellGoods.goodsType.text = @"点击选择类型";
            } else {
                cellGoods.goodsType.text = self.strType;
                self.goodType = [NSString stringWithFormat:@"%@", cellGoods.goodsType.text];
            }
        } else {
            cellGoods.i = 2;
            cellGoods.goodsImage.image = [UIImage imageNamed:@"信息.png"];
            cellGoods.goodsLabel.text = @"物品信息";
            cellGoods.goodsView.text = @"订单物品信息补充:如配送要求,配送方式";
            cellGoods.block = ^(UITextView *textView) {
                self.keyboardTag = 1;
                if (self.keyboardRect.size.height != 0) {
                    if (0 == self.cancelTag) {
                        self.sendTableView.frame = CGRectMake(0, (cellGoods.frame.origin.y +cellGoods.frame.size.height) - (Height - self.keyboardRect.size.height), Width, Height - 84);
                    } else {
                        self.sendTableView.frame = CGRectMake(0, (cellGoods.frame.origin.y +cellGoods.frame.size.height) - (Height - self.keyboardRect.size.height), Width, Height - 64);
                    }
                }
                
                
                
                [self.view bringSubviewToFront:self.naviView];
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
            };
            cellGoods.typeBlock = ^(NSInteger i) {
                if (1 == i) {
                    self.goodsOther1 = [NSString stringWithFormat:@"%@",@"带保温箱"];
                }
            };
            cellGoods.typeBlock2 = ^(NSInteger i) {
                if (1 == i) {
                    self.goodsOther2 = [NSString stringWithFormat:@"%@",@"汽车配送"];
                }
            };
        }
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
            cellService.lineLabel.text = [NSString stringWithFormat:@"总路程:未知"];
        } else {
            self.instance = [self distanceBetweenLtaBegin:self.lta withLonBegin:self.lon withLtaEnd:self.getLta withLonEnd:self.getLon];
#pragma mark - 根据距离算钱------未完成
            self.money1 = 10;
            cellService.moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.money1];
            cellService.lineLabel.text = [NSString stringWithFormat:@"总路程:%.2f km",self.instance / 1000];
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
            } else if ([self.goodPrice isEqualToString:@""] || self.goodPrice == NULL) {
                [self alertWithError:4];
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
        if (0 == indexPath.row) {
            if (self.getLta == 0 || self.getLon == 0 || [self.myStr isEqualToString:@"请选择购买地址"]) {
                return Height * 0.14;
            } else {
                NSString *str = [NSString stringWithFormat:@"%@%@",self.addressStr,self.addressReceive];
                CGRect rect = [str boundingRectWithSize:CGSizeMake((Width * 0.75 - 26) * 0.5, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
                return Height * 0.16 + rect.size.height;
            }

//            return [ReceiveAndGetTableViewCell  heightForCell:[NSString stringWithFormat:@"%@%@",self.addressStr, self.addressReceive]] + Height * 0.02;
        } else {
            return [ReceiveAndGetTableViewCell  heightForCell:[NSString stringWithFormat:@"%@%@",self.addressStr, self.addressDetail]] + Height * 0.02;
        }
        
    } else if (2 == indexPath.section) {
        if (1 == indexPath.row) {
            
            return Height * 0.2;
            
        } else {
            return Height * 0.07;
        }
        
    } else {
        return self.sendTableView.rowHeight = Height * 0.07;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        AddressChooseViewController *addressChoose = [[AddressChooseViewController alloc] init];
        addressChoose.lta = self.lta;
        addressChoose.lon = self.lon;
        addressChoose.str = self.addressStr;
        if (0 == indexPath.row) {
            self.tagAddress = 0;
            
        } else {
            self.tagAddress = 1;
            addressChoose.tagAddress = self.tagAddress;
            [self.navigationController pushViewController:addressChoose animated:YES];
        }
        
    } else if (1 == indexPath.section) {
        self.cellJudge = 0;
        self.timeTag = 1;
        [self.view addSubview:self.viewForDate];
        [self.pickerView reloadAllComponents];
        
    } else if (2 == indexPath.section) {
        self.cellJudge = 1;
        if (0 == indexPath.row) {
            [self.view addSubview:self.viewForDate];
            [self.pickerView reloadAllComponents];
        }
        
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
