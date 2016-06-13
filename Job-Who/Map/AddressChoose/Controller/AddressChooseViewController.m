//
//  AddressChooseViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/27.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "AddressChooseViewController.h"

@interface AddressChooseViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, UITableViewDelegate, UITableViewDataSource, BMKGeoCodeSearchDelegate, BMKPoiSearchDelegate, UISearchResultsUpdating, UISearchBarDelegate,UISearchControllerDelegate>
@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) BMKLocationService *mapLocation;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;
@property (strong, nonatomic) UIView *viewForButton;
@property (strong, nonatomic) UIButton *buttonNear;
@property (strong, nonatomic) UIButton *buttonAlways;
@property (strong, nonatomic) UIImageView *imageUnderline;
@property (strong, nonatomic) UIImageView *imageUnderlineRight;
@property (assign, nonatomic) BOOL switchButton;
@property (assign, nonatomic) NSInteger i;
@property (strong, nonatomic) UITableView *tableForAddress;
@property (strong, nonatomic) UITableView *tableForSearch;
@property (strong, nonatomic) BMKPoiInfo *info;
@property (strong, nonatomic) NSMutableArray *arrayForNear;
@property (strong, nonatomic) NSMutableArray *arrayForOften;
@property (strong, nonatomic) NSMutableArray *arrayForSearch;
@property (assign, nonatomic) NSInteger selectRow;
@property (strong, nonatomic) BMKPointAnnotation *itemSearch;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) BMKPoiSearch *poiSearch;
@end

@implementation AddressChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectRow = -1;
    [self createNaviWithType:0 withViewController:self];
    self.naviView.titleLabel.text = @"地址选址";
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self setExtendedLayoutIncludesOpaqueBars:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrayForSearch = [NSMutableArray arrayWithCapacity:0];
    self.arrayForNear = [NSMutableArray arrayWithCapacity:0];
    self.arrayForOften = [NSMutableArray arrayWithCapacity:0];
    self.switchButton = YES;
    [self mapShow];
    [self createButton];
    [self createUnderLine];
    [self createSearchBar];

    // Do any additional setup after loading the view.
}
#pragma mark - searchBar
- (void)createSearchBar {
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入地址";
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.layer.cornerRadius = 5;
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.7, Height * 0.05));
        make.top.mas_equalTo(self.view).with.offset(64 + Height * 0.01);
        make.left.mas_equalTo(self.view).with.offset(Width * 0.15);
        
    }];
    [[[self.searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0]removeFromSuperview];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.frame = CGRectMake(Width * 0.15, 64 + Height * 0.01, Width * 0.7, Height * 0.05);
//    self.searchController.searchBar.backgroundColor = [UIColor yellowColor];
//    self.searchController.searchBar.translucent = YES;
    self.searchController.delegate = self;
    self.searchController.navigationController.navigationBarHidden = NO;
    self.tableForAddress.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.searchController.searchBar];
    self.searchController.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        [self.searchController.view addSubview:self.searchController.searchBar];
    self.searchController.searchBar.placeholder = @"请输入地址";
//        [self presentViewController:self.searchController animated:YES completion:nil];
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//    [self.searchController.view addSubview:self.searchController.searchBar];
    [self presentViewController:self.searchController animated:YES completion:nil];

    
    return YES;
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (![self.searchController.searchBar.text isEqualToString:@""]) {
        [self.arrayForSearch removeAllObjects];
        BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc] init];
        citySearchOption.city = self.info.city;
        citySearchOption.keyword = self.searchController.searchBar.text;
        BOOL isSuccess = [self.poiSearch poiSearchInCity:citySearchOption];
        if (isSuccess) {
            NSLog(@"ok");
        } else {
            NSLog(@"fail");
        }
    } else {
        [self.arrayForSearch removeAllObjects];
        [self.tableForSearch reloadData];
    }

    
}
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error {
//    NSLog(@"%@, %@",[result.poiInfoList[0] address],result.cityList);
    for (int i = 0; i <result.poiInfoList.count; i ++) {
        [self.arrayForSearch addObject:result.poiInfoList[i]];
    }
    [self.tableForSearch reloadData];
    
}
#pragma mark - 百度地图显示+定位
- (void)mapShow {
    self.mapView = [[BMKMapView alloc] init];
    self.mapLocation = [[BMKLocationService alloc] init];
    self.poiSearch = [[BMKPoiSearch alloc] init];
    [self.mapView setZoomLevel:15];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width, Height * 0.5));
        make.top.mas_equalTo(self.view).with.offset(64);

    }];
//    [self.mapLocation startUserLocationService];
//    self.mapView.showsUserLocation = NO;
//    self.mapView.userTrackingMode = 0;
//    self.mapView.showsUserLocation = YES;
    self.geocodesearch = [[BMKGeoCodeSearch alloc] init];
    
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.lta, self.lon)];
    //        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(38.264, 121.53951)];
    BMKPointAnnotation *item = [[BMKPointAnnotation alloc]init];
    item.coordinate = CLLocationCoordinate2DMake(self.lta, self.lon);
    item.title = self.str;
    [self.mapView addAnnotation:item];
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = CLLocationCoordinate2DMake(self.lta, self.lon);
    NSLog(@"%f,%f",self.lta,self.lon);
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
}

#pragma mark - button
- (void)createButton {
    self.viewForButton = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + Height * 0.5, Width, Height *0.05)];
    self.viewForButton.layer.masksToBounds = YES;
    self.viewForButton.layer.borderWidth = 0.2;
    self.viewForButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.viewForButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewForButton];
    self.buttonNear = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonNear setTintColor:Color_System];
    [self.buttonNear setTitle:@"附近的点" forState:UIControlStateNormal];
    [self.viewForButton addSubview:self.buttonNear];
    [self.buttonNear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.5, Height * 0.05));
        make.left.mas_equalTo(self.viewForButton).with.offset(0);
        make.top.mas_equalTo(self.viewForButton).with.offset(0);
    }];
    [self.buttonNear addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonAlways = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonAlways setTintColor:[UIColor lightGrayColor]];
    [self.buttonAlways setTitle:@"常用地址" forState:UIControlStateNormal];
    [self.viewForButton addSubview:self.buttonAlways];
    [self.buttonAlways mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.5, Height * 0.05));
        make.left.mas_equalTo(self.viewForButton).with.offset(Width * 0.5);
        make.top.mas_equalTo(self.viewForButton).with.offset(0);
        
    }];
    [self.buttonAlways addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 下划线图片
- (void)createUnderLine {
    self.imageUnderline = [[UIImageView alloc] init];
    [self.viewForButton addSubview:self.imageUnderline];
    self.imageUnderline.backgroundColor = Color_System;
    [self.imageUnderline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.5, Height * 0.005));
        make.left.mas_equalTo(self.viewForButton).with.offset(0);
        make.bottom.mas_equalTo(self.viewForButton).with.offset(0);
        
    }];
    
}
- (void)createUnderLineRight {
    self.imageUnderlineRight = [[UIImageView alloc] init];
    self.imageUnderlineRight.backgroundColor = Color_System;
    [self.viewForButton addSubview:self.imageUnderlineRight];
    [self.imageUnderlineRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width * 0.5, Height * 0.005));
        make.right.mas_equalTo(self.viewForButton).with.offset(0);
        make.bottom.mas_equalTo(self.viewForButton).with.offset(0);
        
    }];
    
}

#pragma mark - 点击按钮
- (void)button:(UIButton *)button {
    if (button == self.buttonNear) {
        if (!self.switchButton) {
            [self.buttonNear setTintColor:Color_System];
            [self.buttonAlways setTintColor:[UIColor lightGrayColor]];
            [self createUnderLine];
            [self.imageUnderlineRight removeFromSuperview];
            self.switchButton = YES;
            [self.tableForAddress reloadData];
            if (self.arrayForNear.count != 0) {
                for (NSInteger i = 0; i < self.tableForAddress.visibleCells.count; i ++) {
                    
                    AddressTableViewCell *cell = self.tableForAddress.visibleCells[i];
                    NSIndexPath *path = [self.tableForAddress indexPathForCell:cell];
                    if (path.row != self.selectRow) {
                        cell.selectedImage.image = [UIImage imageNamed:@"定位灰.png"];
                        cell.address.textColor = [UIColor lightGrayColor];
                    } else {
                        cell.selectedImage.image = [UIImage imageNamed:@"定位绿.png"];
                        cell.address.textColor = Color_System;
                    }
                }
            }
        }
    } else {
        if (self.switchButton) {
            [self.buttonNear setTintColor:[UIColor lightGrayColor]];
            [self.buttonAlways setTintColor:Color_System];
            [self.imageUnderline removeFromSuperview];
            [self createUnderLineRight];
            self.switchButton = NO;
            [self.tableForAddress reloadData];
            if (self.arrayForOften.count != 0) {
                for (NSInteger i = 0; i < self.tableForAddress.visibleCells.count; i ++) {
                    
                    AddressTableViewCell *cell = self.tableForAddress.visibleCells[i];
                    NSIndexPath *path = [self.tableForAddress indexPathForCell:cell];
                    if (path.row != self.selectRow) {
                        cell.selectedImage.image = [UIImage imageNamed:@"定位灰.png"];
                        cell.address.textColor = [UIColor lightGrayColor];
                    } else {
                        cell.selectedImage.image = [UIImage imageNamed:@"定位绿.png"];
                        cell.address.textColor = Color_System;
                    }
                }
            }
        }
    }

}

#pragma mark - 定位
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [self.mapView updateLocationData:userLocation];
    NSLog(@"不走");
    NSLog(@"%f,%f,",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    
    [self didStopLocatingUser];
}

#pragma mark - 停止定位
- (void)didStopLocatingUser {
    [self.mapLocation stopUserLocationService];
    
}

#pragma mark - 反向地理编码代理
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    self.info = [[BMKPoiInfo alloc] init];
    
    for (int i = 0; i < result.poiList.count; i ++) {
        self.info= result.poiList[i];
        [self.arrayForNear addObject:self.info];
        NSLog(@"具体%@,地址%@,城市%@",self.info.name,self.info.address,self.info.city);
    }
        [self createTableView];
}
#pragma mark - tableView创建
- (void)createTableView {
    self.tableForAddress = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + Height * 0.55, Width, Height - 64 - Height * 0.55) style:0];
    self.tableForAddress.delegate = self;
    self.tableForAddress.dataSource = self;
    self.tableForAddress.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableForAddress];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableForAddress setTableFooterView:v];
    [self.tableForAddress registerClass:[AddressTableViewCell class] forCellReuseIdentifier:@"address"];
    [self.tableForAddress registerClass:[UITableViewCell class] forCellReuseIdentifier:@"noAddress"];
    self.tableForAddress.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableForAddress setSeparatorInset:UIEdgeInsetsZero];
    
    self.tableForSearch = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width, Height - 64) style:0];
    self.tableForSearch.delegate = self;
    self.tableForSearch.dataSource = self;
    [self.searchController.view addSubview:self.tableForSearch];
    [self.tableForSearch setTableFooterView:v];
    [self.tableForSearch registerClass:[UITableViewCell class] forCellReuseIdentifier:@"search"];

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"address"];
    UITableViewCell *cellNo = [tableView dequeueReusableCellWithIdentifier:@"noAddress"];
    UITableViewCell *cellSearch = [[UITableViewCell alloc] initWithStyle:3 reuseIdentifier:@"search"];;
    
    cellSearch.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cellNo.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == self.tableForAddress) {
        if (self.switchButton) {
            if (self.arrayForNear.count == 0) {
                self.tableForAddress.rowHeight = self.tableForAddress.frame.size.height;
                cellNo.textLabel.textAlignment = NSTextAlignmentCenter;
                cellNo.textLabel.text = @"暂无附近的点";
                cellNo.textLabel.font = [UIFont systemFontOfSize:13];
                cellNo.textLabel.textColor = [UIColor lightGrayColor];
                return cellNo;
            } else {
                self.tableForAddress.rowHeight = (Height - 64 - Height * 0.55) / 4;
                cell.address.text = [self.arrayForNear[indexPath.row] name];
                NSLog(@"%@",self.arrayForNear);
                cell.blockInfo = ^(BMKPoiInfo *poiInfo) {
                    AddressSelectViewController *addressSelect = [[AddressSelectViewController alloc] init];
                    [self changeNavigationBar];
                    poiInfo = self.arrayForNear[indexPath.row];
                    NSLog(@"这里%@,%f,%f",poiInfo.name,poiInfo.pt.latitude,poiInfo.pt.longitude);
                    addressSelect.poiInfo = poiInfo;
                    addressSelect.tagAddress = self.tagAddress;
                    [self.navigationController pushViewController:addressSelect animated:YES];
                };
                return cell;
            }
        } else {
            if (self.arrayForOften.count == 0) {
                self.tableForAddress.rowHeight = self.tableForAddress.frame.size.height;
                cellNo.textLabel.textAlignment = NSTextAlignmentCenter;
                cellNo.textLabel.text = @"暂无常用地址";
                cellNo.textLabel.font = [UIFont systemFontOfSize:13];
                cellNo.textLabel.textColor = [UIColor lightGrayColor];
                return cellNo;
            } else {
                self.tableForAddress.rowHeight = (Height - 64 - Height * 0.55) / 4;
                cell.address.text = self.arrayForOften[indexPath.row];
                return cellNo;
            }
        }
    } else {
        if (self.arrayForSearch.count != 0) {
            self.tableForSearch.rowHeight = 50;
            cellSearch.textLabel.text = [self.arrayForSearch[indexPath.row] name];
            BMKPoiInfo *info = self.arrayForSearch[indexPath.row];
            cellSearch.detailTextLabel.text = info.address;
        } else {
            cellSearch.textLabel.textAlignment = NSTextAlignmentCenter;
            cellSearch.textLabel.text = @"";

            self.tableForSearch.rowHeight = 100;
        }
        return cellSearch;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableForAddress) {
        if (self.switchButton) {
            if (self.arrayForNear.count == 0) {
                return 1;
            } else {
                return self.arrayForNear.count;
            }
        } else {
            if (self.arrayForOften.count == 0) {
                return 1;
            } else {
                return self.arrayForOften.count;
            }
        }
    } else {
        if (self.arrayForSearch.count != 0) {
            return self.arrayForSearch.count;
        } else {
            return 1;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableForAddress) {
        if (self.switchButton) {
            if (self.arrayForNear.count != 0) {
                for (NSInteger i = 0 ; i < self.arrayForNear.count; i ++) {
                    AddressTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                    cell.selectedImage.image = [UIImage imageNamed:@"定位灰.png"];
                    cell.address.textColor = [UIColor lightGrayColor];
                }
                
                
                AddressTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
                cell.selectedImage.image = [UIImage imageNamed:@"定位绿.png"];
                cell.address.textColor = Color_System;
                self.selectRow = indexPath.row;
                [self geoWithAddress:cell.address.text];
            }
            
        } else {
            if (self.arrayForOften.count != 0) {
                for (NSInteger i = 0 ; i < self.arrayForOften.count; i ++) {
                    AddressTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                    cell.selectedImage.image = [UIImage imageNamed:@"定位灰.png"];
                    cell.address.textColor = [UIColor lightGrayColor];
                }
                
                
                AddressTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
                cell.selectedImage.image = [UIImage imageNamed:@"定位绿.png"];
                cell.address.textColor = Color_System;
                self.selectRow = indexPath.row;
                [self geoWithAddress:cell.address.text];
            }
            
        }

    } else {
        AddressSelectViewController *addressSelect = [[AddressSelectViewController alloc] init];
        addressSelect.poiInfo = self.arrayForSearch[indexPath.row];
        addressSelect.tagAddress = self.tagAddress;
        [self.navigationController pushViewController:addressSelect animated:NO];
        self.searchController.active = NO;
        
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableForAddress) {
        for (NSInteger i = 0; i < self.tableForAddress.visibleCells.count; i ++) {
            AddressTableViewCell *cell = self.tableForAddress.visibleCells[i];
            NSIndexPath *path = [self.tableForAddress indexPathForCell:cell];
            
            if (path.row != self.selectRow) {
                cell.selectedImage.image = [UIImage imageNamed:@"定位灰.png"];
                cell.address.textColor = [UIColor lightGrayColor];
            } else {
                cell.selectedImage.image = [UIImage imageNamed:@"定位绿.png"];
                cell.address.textColor = Color_System;
            }
        }
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
#pragma mark - 正向地理编码
- (void)geoWithAddress:(NSString *)str {
    NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:array];
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.address = str;
    BOOL flag = [self.geocodesearch geoCode:geocodeSearchOption];
    if (flag) {
        NSLog(@"成功");
    } else {
        NSLog(@"失败");
    }
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc] init];
    if (error == 0) {
        
        self.itemSearch = [[BMKPointAnnotation alloc]init];
        self.itemSearch.coordinate = self.info.pt;
        self.itemSearch.title = self.info.name;
        [self.mapView addAnnotation:self.itemSearch];
        for ( NSInteger i = 0; i < self.arrayForNear.count; i ++) {
            if (self.selectRow == i) {
                self.itemSearch.coordinate = [self.arrayForNear[i] pt];
                self.itemSearch.title = [self.arrayForNear[i] name];
                [self.mapView addAnnotation:self.itemSearch];
                [self.mapView setCenterCoordinate:self.itemSearch.coordinate animated:YES];
                
            }
        }
//        citySearchOption.city = self.info.city;
//        citySearchOption.keyword = result.address;
//        NSLog(@"%f,%f",result.location.latitude,result.location.longitude);
//        BOOL isSuccess = [self.poiSearch poiSearchInCity:citySearchOption];
//        if (isSuccess) {
//            NSLog(@"检索成功");
//        } else {
//            NSLog(@"检索失败");
//        }
     
    } else {
//        citySearchOption.keyword = self.info.address;
//        BOOL isSuccess = [self.poiSearch poiSearchInCity:citySearchOption];
//                NSLog(@"%f,%f",result.location.latitude,result.location.longitude);
//        if (isSuccess) {
//            NSLog(@"检索成功");
//        } else {
//            NSLog(@"检索失败");
//        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    self.mapView.delegate = self;
    self.mapLocation.delegate = self;
    self.geocodesearch.delegate = self;
    self.poiSearch.delegate = self;

}

- (void)viewWillDisappear:(BOOL)animated {
    self.mapView.delegate = nil;
    self.mapLocation.delegate = nil;
    self.geocodesearch.delegate = nil;
    self.poiSearch.delegate = nil;

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
