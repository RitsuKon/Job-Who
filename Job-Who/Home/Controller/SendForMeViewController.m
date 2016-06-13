//
//  SendForMeViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/1.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "SendForMeViewController.h"

@interface SendForMeViewController ()<CNContactPickerDelegate>
@property (strong, nonatomic) CNContactPickerViewController *con;
@property(strong, nonatomic) CNContact *contact;//联系人
@end

@implementation SendForMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.strMoney = [NSString string];
    self.money = 0;
    self.instance = 0;
    self.keyboardTag = 0;
    self.cancelTag = 0;
    self.selectDay = 0;
    self.tagAddress = 0;
    self.selectHour = 0;
    self.selectMinute = 0;
    self.timeTag = 0;
    self.goodTag = 0;
    self.cellJudge = 0;
    self.numberTag = 0;
    self.tagRepeat = 0;
    self.strTime = [NSString stringWithFormat:@"%@", [self getDateFromSystem]];
    self.strType = [NSString string];
    [self createNaviWithType:4 withViewController:self];
    self.view.backgroundColor = [UIColor whiteColor];
    self.naviView.titleLabel.text = @"帮我送";
    [self.naviView.buttonRight setTitle:@"收费标准" forState:UIControlStateNormal];
    [self.naviView.buttonRight setTintColor:Color_System];
    self.naviView.blockRight = ^(UIButton *button) {
        NSLog(@"dadad");
    };
    [self createTableView];
    [self createView];
    [self createPickerView];
    [self createButton];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.sendTableView addGestureRecognizer:tapGestureRecognizer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    // Do any additional setup after loading the view.
}
#pragma mark - 隐藏键盘
-(void)hideKeyBoard
{
    [self.sendTableView endEditing:YES];
    self.keyboardTag = 0;
    if (0 == self.cancelTag) {
        self.sendTableView.frame = CGRectMake(0, 84, Width, Height - 84);
    } else {
        self.sendTableView.frame = CGRectMake(0, 64, Width, Height - 64);
    }
    self.sendTableView.scrollEnabled = YES;
}
#pragma mark - 创建datepicker
- (void)createPickerView {

    self.viewForDate = [[UIView alloc] initWithFrame:CGRectMake(0, Height * 0.5, Width, Height * 0.5)];
//    self.viewForDate.backgroundColor = [UIColor redColor];
    self.viewForDate.backgroundColor = [UIColor whiteColor];
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, Height * 0.5 - 216, Width, 216)];
//    self.pickerView.backgroundColor = [UIColor yellowColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    [self.viewForDate addSubview:self.pickerView];
    self.arrayForType = [NSMutableArray arrayWithObjects:@"小件", @"餐饮", @"大件", @"其他", nil];
    self.arrayDay = [NSMutableArray arrayWithObjects:@"今天", @"明天", nil];
    self.arrayHourToday = [NSMutableArray arrayWithCapacity:0];
    self.arrayHourTomorrow = [NSMutableArray arrayWithCapacity:0];
    self.arrayMinuteBefore = [NSMutableArray arrayWithCapacity:0];
    self.arrayMinuteAfter = [NSMutableArray arrayWithCapacity:0];
    self.arrayMinute = [NSMutableArray arrayWithCapacity:0];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [dateComponent hour];
//    self.selectHour = hour;
    NSInteger minute = [dateComponent minute];
    for (int i = 0; i < 24; i ++) {
        if (hour + i >= 24) {
            [self.arrayHourTomorrow addObject:[NSString stringWithFormat:@"%ld时",hour + i - 24]];
        } else {
            [self.arrayHourToday addObject:[NSString stringWithFormat:@"%ld时",hour + i]];

        }
    }
    for (int j = 0; j < 12; j ++) {
        if (minute <= (11 - j) * 5) {
            [self.arrayMinuteAfter addObject:[NSString stringWithFormat:@"%d分",(11 - j) * 5]];
        } else {
            if (self.arrayMinuteAfter.count == 0) {
                self.selectHour = 2;
//                for (int k = 0 ; k < 12; k ++) {
//                    [self.arrayMinuteAfter addObject:[NSString stringWithFormat:@"%d分", k * 5]];
//                }
            }
            
        }
        [self.arrayMinute addObject:[NSString stringWithFormat:@"%d分", j * 5]];
    }

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (0 == self.cellJudge) {
        return 3;
    } else {
       return 1;
    }
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (0 == self.cellJudge) {
        if (0 == component) {
            return 2;
        } else if (1 == component) {
            if (0 == self.selectDay) {
                if (2 == self.selectHour) {
                    return self.arrayHourToday.count - 1;
                } else {
                    return self.arrayHourToday.count;
                }
                
            } else {
                return self.arrayHourTomorrow.count;
            }
            
        } else {
            if (self.selectDay == 0) {
                if (self.selectHour == 0) {
                    return self.arrayMinuteAfter.count;
                } else {
                    return self.arrayMinute.count;
                }
            } else {
                return self.arrayMinute.count;
            }
            
            
        }

    } else{
        return self.arrayForType.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == self.cellJudge) {
        if (0 == component) {
            return self.arrayDay[row];
        } else if (1 == component) {
            if (0 == self.selectDay) {
                if (2 == self.selectHour) {
                    return self.arrayHourToday[row + 1];
                } else {
                    return self.arrayHourToday[row];
                }
                
            } else {
                return self.arrayHourTomorrow[row];
            }
        } else {
            if (self.selectDay == 0) {
                if (self.selectHour == 0) {
                    
                    return self.arrayMinuteAfter[self.arrayMinuteAfter.count - 1- row];
                } else {
                    return self.arrayMinute[row];
                }
            } else {
                return self.arrayMinute[row];
            }
            
            
            //        return @"da";
        }

    } else {
        return self.arrayForType[row];
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (0 == self.cellJudge) {
        self.timeTag = 1;
        if (0 == component) {
            if (row == 0) {
                self.selectDay = 0;
                self.selectHour = 0;
            } else {
                self.selectDay = 1;
                self.selectHour = 1;
                
            }
            
            [self.pickerView reloadComponent:1];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        } else if (1 == component) {
            if (row == 0) {
                self.selectHour = 0;
                
            } else {
                self.selectHour = 1;
                
            }
            
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        } else {
            
        }
        [self getTime];

    } else {
        self.goodTag = 1;
        self.strType = self.arrayForType[row];
        NSLog(@"几个%@",self.arrayForType[row]);
    }
}
#pragma mark - button
- (void)createButton {
    self.buttonSure = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonSure.backgroundColor = Color_System;
    [self.buttonSure setTintColor:[UIColor whiteColor]];
    self.buttonSure.layer.masksToBounds = YES;
    self.buttonSure.layer.cornerRadius = 5;
    [self.buttonSure setTitle:@"确定" forState:UIControlStateNormal];
    [self.buttonSure addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonSure.frame = CGRectMake(Width * 0.2, (Height * 0.5 - 216) / 4 , Width * 0.2, (Height * 0.5 - 216) / 2);
    [self.viewForDate addSubview:self.buttonSure];
    
    self.buttonCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonCancel.backgroundColor = Color_System;
    [self.buttonCancel setTintColor:[UIColor whiteColor]];
    self.buttonCancel.layer.masksToBounds = YES;
    self.buttonCancel.layer.cornerRadius = 5;
    [self.buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.buttonCancel addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonCancel.frame = CGRectMake(Width * 0.6, (Height * 0.5 - 216) / 4 , Width * 0.2, (Height * 0.5 - 216) / 2);
    [self.viewForDate addSubview:self.buttonCancel];
}
#pragma mark - 选择日期和取消日期按钮事件

- (void)button:(UIButton *)button {
    
    if (button == self.buttonSure) {
        if (0 == self.cellJudge) {
            [self getTime];
        } else {
            if (0 == self.goodTag) {
                self.strType = self.arrayForType[0];
            }
        }

        [self.sendTableView reloadData];

    }
    

    [self.viewForDate removeFromSuperview];
}
#pragma mark - tableview
- (void)createTableView {
    self.sendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, Width, Height - 84) style:1];
    self.sendTableView.backgroundColor = [UIColor lightGrayColor];
    self.sendTableView.delegate = self;
    self.sendTableView.dataSource = self;
    [self.sendTableView registerClass:[ReceiveAndGetTableViewCell class] forCellReuseIdentifier:@"ReceiveAndGet"];
    [self.sendTableView registerClass:[DateTableViewCell class] forCellReuseIdentifier:@"date"];
    [self.sendTableView registerClass:[GoodsTableViewCell class] forCellReuseIdentifier:@"goods"];
    [self.sendTableView registerClass:[TelephoneTableViewCell class] forCellReuseIdentifier:@"tele"];
    [self.sendTableView registerClass:[ServiceTableViewCell class] forCellReuseIdentifier:@"service"];
    [self.view addSubview:self.sendTableView];

}
- (void)createView {
    OrderCancelView *cancelView = [[OrderCancelView alloc] initWithFrame:CGRectMake(0, 64, Width, 20)];
    [self.view addSubview:cancelView];
//     __weak typeof (self) weakSelf = self;
    cancelView.block = ^(UIButton *button) {
        self.cancelTag = 1;
        if (0 == self.keyboardTag) {
            self.sendTableView.frame = CGRectMake(0, 64, Width, Height - 64);
        }

    };
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 2;
    } else if (1 == section) {
        return 1;
    } else if (2 == section) {
        return 3;
    } else if (3 == section) {
        return 2;
    } else {
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceTableViewCell *cellService = [tableView dequeueReusableCellWithIdentifier:@"service"];
    if (0 == indexPath.section) {
        ReceiveAndGetTableViewCell *cellReceiveAndGet = [tableView dequeueReusableCellWithIdentifier:@"ReceiveAndGet"];
        
        if (0 == indexPath.row) {
            NSString *str = @"取货地址*";
            cellReceiveAndGet.addressLabel.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            cellReceiveAndGet.address.text = @"请填写取货地址";
            
            if (![self.addressReceive isEqualToString:@""]) {
                cellReceiveAndGet.address.text = [NSString stringWithFormat:@"%@%@",self.addressStr, self.addressReceive];
            }
            self.receive = [NSString stringWithFormat:@"%@", cellReceiveAndGet.address.text];
            cellReceiveAndGet.addressImage.image = [UIImage imageNamed:@"定位灰.png"];
        } else {
            NSString *str = @"收货地址*";
            cellReceiveAndGet.addressLabel.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            
            if (self.addressDetail == NULL) {
                self.addressDetail = @"";
            }
            
            cellReceiveAndGet.address.text = [NSString stringWithFormat:@"%@%@",self.addressStr, self.addressDetail];
            self.get = [NSString stringWithFormat:@"%@", cellReceiveAndGet.address.text];
            cellReceiveAndGet.addressImage.image = [UIImage imageNamed:@"定位绿.png"];
        }
        return cellReceiveAndGet;
    } else if (1 == indexPath.section) {
        DateTableViewCell *cellDate = [tableView dequeueReusableCellWithIdentifier:@"date"];
        NSString *str = @"取货时间*";
        cellDate.time.text = @"请选择取货时间";
        [cellDate.buttonReceive setTitle:@"立即取货" forState:UIControlStateNormal];
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
        } else if (1 == indexPath.row) {
            cellGoods.i = 1;
            cellGoods.imageRight.image = [UIImage imageNamed:@"元.png"];
            cellGoods.goodsImage.image = [UIImage imageNamed:@"充值.png"];
            NSString *str = @"物品价值*";
            cellGoods.goodsLabel.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            __weak typeof (cellGoods) weakSelf = cellGoods;
            cellGoods.priceBlock = ^(UITextField *textField) {
                self.goodPrice = [NSString stringWithFormat:@"%@", weakSelf.goodsPrice.text];
            };
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
            if (0 == indexPath.row) {
                    cellTele.endBlock = ^(UITextField *textField) {
                        self.sendNumber = [NSString stringWithFormat:@"%@",textField.text];
                    };
            cellTele.teleImage.image = [UIImage imageNamed:@"电话.png"];
                NSString *str = @"发货人电话*";
                cellTele.teleLabel.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            [cellTele.buttonRight setImage:[[UIImage imageNamed:@"通讯录.png"]imageWithRenderingMode:1] forState:UIControlStateNormal];
            cellTele.block = ^(UIButton *button) {
                self.numberTag = 0;
                self.con = [[CNContactPickerViewController alloc] init];
                self.con.delegate = self;
                [self presentViewController:self.con animated:YES completion:^{
                    
                }];
            };
            cellTele.telephone.text = self.sendNumber;
            
        } else {
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
        }
        
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
            
            if ([self.receive isEqualToString:@""] || self.receive == NULL) {
                [self alertWithError:1];
            } else if ([self.receiveTime isEqualToString:@""] || self.receiveTime == NULL) {
                [self alertWithError:2];
            } else if ([self.goodType isEqualToString:@""] || self.goodType == NULL) {
                [self alertWithError:3];
            } else if ([self.goodPrice isEqualToString:@""] || self.goodPrice == NULL) {
                [self alertWithError:4];
            } else if ([self.receiveNumber isEqualToString:@""] || self.receiveNumber == NULL) {
                [self alertWithError:5];
            } else if ([self.sendNumber isEqualToString:@""] || self.sendNumber == NULL) {
                [self alertWithError:6];
            } else {
#pragma mark ---生成订单-未完成
            }
        };
        return cellService;
    }

}
#pragma mark - section头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (6 == section) {
        return self.rect.size.height + 5;
    } else {
        return CGFLOAT_MIN;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (5 == section) {
        return CGFLOAT_MIN;
    } else {
        return 10;
    }
    
}
#pragma mark - 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            return [ReceiveAndGetTableViewCell  heightForCell:[NSString stringWithFormat:@"%@%@",self.addressStr, self.addressReceive]] + Height * 0.02;
        } else {
            return [ReceiveAndGetTableViewCell  heightForCell:[NSString stringWithFormat:@"%@%@",self.addressStr, self.addressDetail]] + Height * 0.02;
        }

    } else if (2 == indexPath.section) {
        if (2 == indexPath.row) {
            
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
        }
        addressChoose.tagAddress = self.tagAddress;
        [self.navigationController pushViewController:addressChoose animated:YES];
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

#pragma mark - 时间取值
- (void)getTime {
    
    NSMutableString *strDay = [NSMutableString string];
    NSMutableString *strHour = [NSMutableString string];
    NSMutableString *strMinute = [NSMutableString string];
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];
    NSInteger row2 = [self.pickerView selectedRowInComponent:1];
    NSInteger row3 = [self.pickerView selectedRowInComponent:2];
    strDay = self.arrayDay[row1];
    
    if ([strDay isEqualToString:@"今天"]) {
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        strDay = (NSMutableString *)dateString;
    } else {
        NSDate *aDate = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:aDate];
        [components setDay:([components day]+1)];
        
        NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
        NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
        [dateday setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateday stringFromDate:beginningOfWeek];
        strDay = (NSMutableString *)dateString;
    }
    if (self.selectDay == 0) {
        strHour = self.arrayHourToday[row2];
    } else {
        strHour = self.arrayHourTomorrow[row2];
    }
    strHour = [strHour substringToIndex:strHour.length - 1];
    if ([strHour isEqualToString:@"0"]) {
        strHour = (NSMutableString *)@"00";
    }
    if (self.selectHour == 0) {
        strMinute = self.arrayMinuteAfter[self.arrayMinuteAfter.count - row3 - 1];
    } else {
        strMinute = self.arrayMinute[row3];
    }
    strMinute = [strMinute substringToIndex:strMinute.length - 1];
    if ([strMinute isEqualToString:@"0"]) {
        strMinute = (NSMutableString *)@"00";
    }
    
    self.strTime = [NSString stringWithFormat:@"%@ %@:%@",strDay,strHour,strMinute];
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    self.contact = [[CNContact alloc] init];
    self.contact = contact;
    if (contact.phoneNumbers.count <= 1) {
        CNLabeledValue *value = contact.phoneNumbers[0];
        CNPhoneNumber *phoneNumber = value.value;
        if (0 == self.numberTag) {
            self.sendNumber = phoneNumber.stringValue;
        } else {
            self.receiveNumber = phoneNumber.stringValue;
        }
        [self.sendTableView reloadData];
    } else {
        [self performSelector:@selector(delayToDo) withObject:self afterDelay:1];
    }

    
    
}
#pragma mark - 手机多选提示框
- (void)alertWithCount:(NSInteger)i {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择电话号码" preferredStyle:1];
    for (NSInteger j = 0; j < i + 1; j ++) {

        if (j == i) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
        } else {
            UIAlertAction *action = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@",[[self.contact.phoneNumbers[j] value] stringValue]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (0 == self.numberTag) {
                    self.sendNumber = [[self.contact.phoneNumbers[j] value] stringValue];
                } else {
                    self.receiveNumber = [[self.contact.phoneNumbers[j] value] stringValue];
                }
                [self.sendTableView reloadData];
            }];
            [alert addAction:action];
        }
        
    }

    [self presentViewController:alert animated:YES completion:nil];

}
- (void)delayToDo {
    [self alertWithCount:self.contact.phoneNumbers.count];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.sendTableView reloadData];

    [self.tabBarController.tabBar setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击空白");
}
#pragma mark - 获取键盘高度
- (void)keyboardShow:(NSNotification *)notification {
    NSDictionary *userinfo = [notification userInfo];
    NSValue *value = [userinfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardRect = [value CGRectValue];
//    [self.sendTableView reloadData];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (6 == section) {
        UIView *view = [[UIView alloc] init];
        
        
        UILabel *label = [[UILabel alloc] init];
        [view addSubview:label];
        label.text = @"酷夏来临,骄阳似火,老板加点小费,骑士更有动力哦!";
        self.rect = [label.text boundingRectWithSize:CGSizeMake(Width, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        view.backgroundColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:12];
        view.frame = CGRectMake(0, 0, Width, self.rect.size.height + 5);
        label.frame = CGRectMake(0, 0, Width, self.rect.size.height);
        return view;
    } else {
        return nil;
    }
   
}
- (void)alertWithError:(NSInteger )i {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未填写取货地址" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertController *alertTime = [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未填写取货时间" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertController *alertGood = [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未填写物品类型" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertController *alertGoodPrice = [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未填写物品价值" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertController *alertSendNumber = [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未填写发货人电话" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertController *alertGetNumber= [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未填写收货人电话" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];


    switch (i) {
        case 1:
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        case 2:
            [alertTime addAction:action];
            [self presentViewController:alertTime animated:YES completion:nil];
        case 3:
            [alertGood addAction:action];
            [self presentViewController:alertGood animated:YES completion:nil];
            break;
        case 4:
            [alertGoodPrice addAction:action];
            [self presentViewController:alertGoodPrice animated:YES completion:nil];
            break;
        case 5:
            [alertSendNumber addAction:action];
            [self presentViewController:alertSendNumber animated:YES completion:nil];
            break;
        case 6:
            [alertGetNumber addAction:action];
            [self presentViewController:alertGetNumber animated:YES completion:nil];
            break;
            
        default:
            break;
    }
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
