//
//  HomeViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/31.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, UITableViewDelegate, UITableViewDataSource, BMKGeoCodeSearchDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UIButton *buttonHelp;
@property (strong, nonatomic) UIButton *buttonHomeWork;
@property (strong, nonatomic) UIImageView *imageUnderlineLeft;
@property (strong, nonatomic) UIImageView *imageUnderMiddle;
@property (strong, nonatomic) UIImageView *imageUnderlineRight;
@property (assign, nonatomic) NSInteger switchButton;
@property (strong, nonatomic) UIView *viewForButton;
@property (strong, nonatomic) UIView *viewForFunction;
@property (strong, nonatomic) UIButton *buttonsHelp;
@property (strong, nonatomic) UIButton *buttonsHomeWork;
@property (strong, nonatomic) UIButton *buttonsCar;
@property (strong, nonatomic) UIButton *buttonCar;
@property (assign, nonatomic) NSInteger defaultHelp;
@property (assign, nonatomic) NSInteger defaultHomework;
@property (assign, nonatomic) NSInteger defaultCar;
@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) BMKLocationService *mapLocation;
@property (strong, nonatomic) UIImageView *imageLocation;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;
@property (strong, nonatomic) NSString *locationStr;
@property (assign, nonatomic) double lta;
@property (assign, nonatomic) double lon;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSString *currentCity;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.switchButton = 0;

    [self createNaviWithType:3 withViewController:self];
    
    self.naviView.titleLabel.textColor = [UIColor lightGrayColor];
    self.defaultHelp = 100;
    self.defaultHomework = 200;
    self.defaultCar = 300;
    [self createButton];
    [self createUnderLine];
    [self createFunction];
    [self createButtonsHelp];
    [self mapShow];
    [self createImageView];
    [self createTableView];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 地图
- (void)mapShow {
    self.mapView = [[BMKMapView alloc] init];
    self.mapLocation = [[BMKLocationService alloc] init];
    self.geocodesearch = [[BMKGeoCodeSearch alloc] init];
    [self.mapView setZoomLevel:15];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width, Height - 113 - Height * 0.16));
        make.left.mas_equalTo(self.viewForButton).with.offset(0);
        make.top.mas_equalTo(self.viewForButton).with.offset(Height * 0.16);
    }];
    [self.mapLocation startUserLocationService];
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = 0;
}
#pragma mark - 定位
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [self.mapView updateLocationData:userLocation];
//    NSLog(@"%f,%f,",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
    self.lta = userLocation.location.coordinate.latitude;
    self.lon = userLocation.location.coordinate.longitude;
    [self didStopLocatingUser];
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
}
#pragma mark - 反地理编码代理方法
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == 0) {
//        if (result.poiList.count != 0) {
//            self.locationStr = [NSString stringWithFormat:@"%@%@", result.address, [result.poiList[0] name]];
//        } else {
            self.locationStr = [NSString stringWithFormat:@"%@", result.address];
//        }
        self.currentCity = [NSString stringWithFormat:@"%@", [result.addressDetail district]];
        self.naviView.titleLabel.text = self.currentCity;
//        NSLog(@"区县%@",[result.addressDetail district]);

    } else {
        self.locationStr = [NSString stringWithFormat:@"暂无详细地址"];
    }
    [self.tableView reloadData];
}
#pragma mark - 停止定位
- (void)didStopLocatingUser {
    [self.mapLocation stopUserLocationService];
    
}
#pragma mark - 图片
- (void)createImageView {
    self.imageLocation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"探针.png"]];
    [self.mapView addSubview:self.imageLocation];
    [self.imageLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.1, Height * 0.08));
        make.left.mas_equalTo(self.mapView).with.offset(Width * 0.45);
        make.top.mas_equalTo(self.mapView).with.offset(self.mapView.frame.origin.y + (Height - 113 - Height * 0.16) / 2 - Height * 0.04);
    }];
}
#pragma mark - tableView
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(Width * 0.15 , self.mapView.frame.origin.y + (Height - 113 - Height * 0.16) / 2 - Height * 0.16, Width * 0.7, Height * 0.12) style:0];
    self.tableView.rowHeight = Height * 0.05;
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    self.tableView.layer.masksToBounds = YES;
    self.tableView.clipsToBounds = NO;
    self.tableView.layer.shadowOffset = CGSizeMake(1,1);
    self.tableView.layer.shadowOpacity = 0.5;
//    self.tableView.layer.shadowRadius = 0;
    self.tableView.layer.shadowColor = Color_System.CGColor;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.tableView.layer.cornerRadius = 5;
    [self.tableView registerClass:[AddressLocationTableViewCell class] forCellReuseIdentifier:@"location"];
    [self.tableView registerClass:[OrderButtonTableViewCell class] forCellReuseIdentifier:@"order"];
    [self.mapView addSubview:self.tableView];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressLocationTableViewCell *cellLocation = [tableView dequeueReusableCellWithIdentifier:@"location"];
    OrderButtonTableViewCell *cellOrder = [tableView dequeueReusableCellWithIdentifier:@"order"];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    if (0 == indexPath.row) {
        self.tableView.rowHeight = Height * 0.07;
        if (0 == self.switchButton) {
            cellLocation.addressImage.image = [UIImage imageNamed:@"收货.png"];
            cellLocation.labelType.text = @"收货地址";
        } else {
            cellLocation.addressImage.image = [UIImage imageNamed:@"服务.png"];
            cellLocation.labelType.text = @"服务地址";
        }
        cellLocation.addressLabel.text = self.locationStr;
        cellLocation.selectionStyle = 0;
        return cellLocation;
    } else {
        self.tableView.rowHeight = Height * 0.05;
        cellOrder.selectionStyle = 0;
        cellOrder.buttonBlock = ^(UIButton *button) {
            if (0 == self.switchButton) {
                if (self.defaultHelp == 100) {
                    SendForMeViewController *sendForMe = [[SendForMeViewController alloc] init];
                    sendForMe.addressStr = self.locationStr;
                    sendForMe.lta = self.lta;
                    sendForMe.lon = self.lon;
                    sendForMe.addressDetail = [NSString stringWithFormat:@"%@",@""];
                    sendForMe.addressReceive = [NSString stringWithFormat:@"%@",@""];
                    [self.navigationController pushViewController:sendForMe animated:NO];
                } else if (self.defaultHelp == 101) {
                    BuyForMeViewController *buyForMe = [[BuyForMeViewController alloc] init];
                    buyForMe.addressStr = self.locationStr;
                    buyForMe.lta = self.lta;
                    buyForMe.lon = self.lon;
                    buyForMe.addressDetail = [NSString stringWithFormat:@"%@",@""];
                    buyForMe.addressReceive = [NSString stringWithFormat:@"%@",@""];
                    [self.navigationController pushViewController:buyForMe animated:NO];
                } else if (self.defaultHelp == 102){
                    DoForMeViewController *doForMe = [[DoForMeViewController alloc] init];
                    doForMe.addressStr = self.locationStr;
                    doForMe.lta = self.lta;
                    doForMe.lon = self.lon;
                    doForMe.addressDetail = [NSString stringWithFormat:@"%@",@""];
                    doForMe.addressReceive = [NSString stringWithFormat:@"%@",@""];
                    [self.navigationController pushViewController:doForMe animated:NO];
                }
            }
        };
        return cellOrder;
    }

    
}
#pragma mark - button
- (void)createButton {
    self.viewForButton = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Width, Height *0.08)];
    self.viewForButton.layer.masksToBounds = YES;
    self.viewForButton.layer.borderWidth = 0.5;
    self.viewForButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.viewForButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewForButton];
    self.buttonHelp = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonHelp setTintColor:Color_System];
    [self.buttonHelp setTitle:@"帮忙" forState:UIControlStateNormal];
    [self.viewForButton addSubview:self.buttonHelp];
    [self.buttonHelp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width / 3, Height * 0.08));
        make.left.mas_equalTo(self.viewForButton).with.offset(0);
        make.top.mas_equalTo(self.viewForButton).with.offset(0);
    }];
    [self.buttonHelp addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonHomeWork = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonHomeWork setTintColor:[UIColor lightGrayColor]];
    [self.buttonHomeWork setTitle:@"家政" forState:UIControlStateNormal];
    [self.viewForButton addSubview:self.buttonHomeWork];
    [self.buttonHomeWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width / 3, Height * 0.08));
        make.left.mas_equalTo(self.viewForButton).with.offset(Width / 3);
        make.top.mas_equalTo(self.viewForButton).with.offset(0);
        
    }];
    [self.buttonHomeWork addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonCar = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonCar setTintColor:[UIColor lightGrayColor]];
    [self.buttonCar setTitle:@"顺风车" forState:UIControlStateNormal];
    [self.viewForButton addSubview:self.buttonCar];
    [self.buttonCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width / 3, Height * 0.08));
        make.left.mas_equalTo(self.viewForButton).with.offset(Width * 2 / 3);
        make.top.mas_equalTo(self.viewForButton).with.offset(0);
        
    }];
    [self.buttonCar addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 点击按钮
- (void)button:(UIButton *)button {
    if (button == self.buttonHelp) {
        if (0 != self.switchButton) {
            [self.buttonHelp setTintColor:Color_System];
            [self.buttonHomeWork setTintColor:[UIColor lightGrayColor]];
            [self.buttonCar setTintColor:[UIColor lightGrayColor]];
            [self createUnderLine];
            [self.imageUnderlineRight removeFromSuperview];
            [self.imageUnderMiddle removeFromSuperview];
            for (int i = 200; i < 203; i ++) {
                UIButton *button = [self.viewForFunction viewWithTag:i];
                [button removeFromSuperview];
            }
            for (int i = 300; i < 303; i ++) {
                UIButton *button = [self.viewForFunction viewWithTag:i];
                [button removeFromSuperview];
            }
            [self createButtonsHelp];
            self.switchButton = 0;
            
        }
    } else if (button == self.buttonHomeWork) {
        if (1 != self.switchButton) {
            [self.buttonHelp setTintColor:[UIColor lightGrayColor]];
            [self.buttonCar setTintColor:[UIColor lightGrayColor]];
            [self.buttonHomeWork setTintColor:Color_System];
            [self.imageUnderlineLeft removeFromSuperview];
            [self.imageUnderlineRight removeFromSuperview];
            [self createUnderLineMiddle];
            for (int i = 100; i < 103; i ++) {
                UIButton *button = [self.viewForFunction viewWithTag:i];
                [button removeFromSuperview];
            }
            for (int i = 300; i < 303; i ++) {
                UIButton *button = [self.viewForFunction viewWithTag:i];
                [button removeFromSuperview];
            }
            [self createButtonsHomeWork];
            self.switchButton = 1;
        }
    } else {
        if (2 != self.switchButton) {
            [self.buttonHelp setTintColor:[UIColor lightGrayColor]];
            [self.buttonHomeWork setTintColor:[UIColor lightGrayColor]];
            [self.buttonCar setTintColor:Color_System];
            [self.imageUnderlineLeft removeFromSuperview];
            [self.imageUnderMiddle removeFromSuperview];
            [self createUnderLineRight];
            for (int i = 100; i < 103; i ++) {
                UIButton *button = [self.viewForFunction viewWithTag:i];
                [button removeFromSuperview];
            }
            for (int i = 200; i < 203; i ++) {
                UIButton *button = [self.viewForFunction viewWithTag:i];
                [button removeFromSuperview];
            }
            [self createButtonsCar];
            self.switchButton = 2;
        }
    }
    [self.tableView reloadData];
}
#pragma mark - 下划线图片
- (void)createUnderLine {
    self.imageUnderlineLeft = [[UIImageView alloc] init];
    self.imageUnderlineLeft.backgroundColor = Color_System;
    [self.viewForButton addSubview:self.imageUnderlineLeft];
    [self.imageUnderlineLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width / 3, Height * 0.005));
        make.left.mas_equalTo(self.viewForButton).with.offset(0);
        make.bottom.mas_equalTo(self.viewForButton).with.offset(0);
        
    }];
    
}
- (void)createUnderLineMiddle {
    self.imageUnderMiddle = [[UIImageView alloc] init];
    self.imageUnderMiddle.backgroundColor = Color_System;
    [self.viewForButton addSubview:self.imageUnderMiddle];
    [self.imageUnderMiddle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width / 3, Height * 0.005));
        make.left.mas_equalTo(self.viewForButton).with.offset(Width / 3);
        make.bottom.mas_equalTo(self.viewForButton).with.offset(0);
        
    }];
    
}
- (void)createUnderLineRight {
    self.imageUnderlineRight = [[UIImageView alloc] init];
    self.imageUnderlineRight.backgroundColor = Color_System;
    [self.viewForButton addSubview:self.imageUnderlineRight];
    [self.imageUnderlineRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width / 3, Height * 0.005));
        make.right.mas_equalTo(self.viewForButton).with.offset(0);
        make.bottom.mas_equalTo(self.viewForButton).with.offset(0);
        
    }];
    
}
#pragma mark - viewFunction
- (void)createFunction {
    self.viewForFunction = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + Height * 0.08, Width, Height * 0.08)];
    self.viewForFunction.layer.masksToBounds = YES;
    self.viewForFunction.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.viewForFunction.layer.borderWidth = 0.3;
    self.viewForFunction.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewForFunction];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.frame = CGRectMake(0, 0, Width, Height * 0.08);
    self.scrollView.contentSize = CGSizeMake(Width, 0);
    [self.viewForFunction addSubview:self.scrollView];
 
}

#pragma mark - buttons
- (void)createButtonsHelp {
    NSMutableArray *arrayHelp = [NSMutableArray arrayWithObjects:@"帮我送", @"帮我买", @"帮我办", nil];
    for (int i = 0; i < arrayHelp.count; i ++) {
        self.buttonsHelp = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonsHelp.layer.masksToBounds = YES;
        self.buttonsHelp.layer.cornerRadius = 5;
        self.buttonsHelp.tag = i + 100;
        self.buttonsHelp.frame = CGRectMake(Width * 0.1 * (i + 1) + i * Width * 0.6 / 3, Height * 0.015, Width * 0.6 / 3, Height * 0.05);
        
       
        [self.buttonsHelp setTitle:arrayHelp[i] forState:UIControlStateNormal];
        [self.buttonsHelp addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:self.buttonsHelp];
        if (self.defaultHelp == i + 100) {
            self.buttonsHelp.backgroundColor = Color_System;
             [self.buttonsHelp setTintColor:[UIColor whiteColor]];
        } else {
//            self.buttonsHelp.backgroundColor = Color_System;
            [self.buttonsHelp setTintColor:[UIColor lightGrayColor]];
        }
    }
}
- (void)createButtonsHomeWork {
    NSMutableArray *arrayHomeWork = [NSMutableArray arrayWithObjects:@"保洁", @"维修", @"搬家", nil];
    for (int i = 0; i < arrayHomeWork.count; i ++) {
        self.buttonsHomeWork = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonsHomeWork.layer.masksToBounds = YES;
        self.buttonsHomeWork.layer.cornerRadius = 5;
        self.buttonsHomeWork.tag = i + 200;
        self.buttonsHomeWork.frame = CGRectMake(Width * 0.1 * (i + 1) + i * Width * 0.6 / 3, Height * 0.015, Width * 0.6 / 3, Height * 0.05);
        [self.buttonsHomeWork setTitle:arrayHomeWork[i] forState:UIControlStateNormal];
        [self.buttonsHomeWork addTarget:self action:@selector(buttonTouch2:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.buttonsHomeWork];
        if (self.defaultHomework == i + 200) {
            self.buttonsHomeWork.backgroundColor = Color_System;
            [self.buttonsHomeWork setTintColor:[UIColor whiteColor]];
        } else {
            //            self.buttonsHelp.backgroundColor = Color_System;
            [self.buttonsHomeWork setTintColor:[UIColor lightGrayColor]];
        }
    }
}
- (void)createButtonsCar {
    NSMutableArray *arrayCar = [NSMutableArray arrayWithObjects:@"跨城捎带", @"同城捎带", @"其他", nil];
    for (int i = 0; i < arrayCar.count; i ++) {
        self.buttonsCar = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buttonsCar.layer.masksToBounds = YES;
        self.buttonsCar.layer.cornerRadius = 5;
        self.buttonsCar.tag = i + 300;
        self.buttonsCar.frame = CGRectMake(Width * 0.1 * (i + 1) + i * Width * 0.6 / 3, Height * 0.015, Width * 0.6 / 3, Height * 0.05);
        [self.buttonsCar setTitle:arrayCar[i] forState:UIControlStateNormal];
        [self.buttonsCar addTarget:self action:@selector(buttonTouch3:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.buttonsCar];
        if (self.defaultCar == i + 300) {
            self.buttonsCar.backgroundColor = Color_System;
            [self.buttonsCar setTintColor:[UIColor whiteColor]];
        } else {
            //            self.buttonsHelp.backgroundColor = Color_System;
            [self.buttonsCar setTintColor:[UIColor lightGrayColor]];
        }
    }
}
- (void)buttonTouch:(UIButton *)button {
    self.defaultHelp = button.tag;
    for (NSInteger i = 100; i < 103; i ++) {
        UIButton *buttons = [self.scrollView viewWithTag:i];
        [buttons setTintColor:[UIColor lightGrayColor]];
        buttons.backgroundColor = [UIColor whiteColor];
    }
    [button setTintColor:[UIColor whiteColor]];
    button.backgroundColor = Color_System;
}
- (void)buttonTouch2:(UIButton *)button {
    self.defaultHomework = button.tag;
    for (NSInteger i = 200; i < 203; i ++) {
        UIButton *buttons = [self.scrollView viewWithTag:i];
        [buttons setTintColor:[UIColor lightGrayColor]];
        buttons.backgroundColor = [UIColor whiteColor];
    }
    [button setTintColor:[UIColor whiteColor]];
    button.backgroundColor = Color_System;
}
- (void)buttonTouch3:(UIButton *)button {
    self.defaultCar = button.tag;
    for (NSInteger i = 300; i < 303; i ++) {
        UIButton *buttons = [self.scrollView viewWithTag:i];
        [buttons setTintColor:[UIColor lightGrayColor]];
        buttons.backgroundColor = [UIColor whiteColor];
    }
    [button setTintColor:[UIColor whiteColor]];
    button.backgroundColor = Color_System;
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    BMKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = self.mapView.centerCoordinate;
    region.center= centerCoordinate;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = region.center;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
}
- (void)viewWillAppear:(BOOL)animated {
    self.mapView.delegate = self;
    self.mapLocation.delegate = self;
    self.geocodesearch.delegate = self;
    [self.tabBarController.tabBar setHidden:NO];

}
- (void)viewWillDisappear:(BOOL)animated {
    self.mapView.delegate = nil;
    self.mapLocation.delegate = nil;
    self.geocodesearch.delegate = nil;

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
