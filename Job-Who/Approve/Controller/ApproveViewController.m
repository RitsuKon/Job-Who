//
//  ApproveViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/6.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "ApproveViewController.h"

@interface ApproveViewController ()<UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *trueName;//本人真实姓名
@property (strong, nonatomic) NSString *identityCard;//身份证
@property (strong, nonatomic) NSString *otherName;//紧急联系人姓名
@property (strong, nonatomic) NSString *strCity;//省市区名称
@property (strong, nonatomic) CNContactPickerViewController *con;
@property (strong, nonatomic) UIImagePickerController *pickerImage;
@property (assign, nonatomic) CGRect keyboardRect;//键盘高
@property (strong, nonatomic) NSString *otherPhoneNumber;//紧急联系人电话
@property (strong, nonatomic) NSString *request;//邀请码或邀请人手机号
@property (strong, nonatomic) UIView *viewForCity;//选择省市区的视图
@property (strong, nonatomic) UIPickerView *pick;//省市区选择器
@property (strong, nonatomic) UIButton *buttonSure;//确定按钮
@property (strong, nonatomic) UIButton *buttonCancel;//取消按钮
@property (strong, nonatomic) UIImage *selectImage;//选择的图片
@property (strong, nonatomic) UIImage *selectImage1;
@property (strong, nonatomic) UIImage *selectImage2;
@property (assign, nonatomic) NSInteger buttonTag;//上传图片按钮的tag
@property (strong, nonatomic) NSDictionary *dicForCity;//省市区大字典
@property (strong, nonatomic) NSMutableArray *arrayProvince;//省
@property (strong, nonatomic) NSMutableArray *arrayCity;//市
@property (strong, nonatomic) NSMutableArray *arrayRegion;//区
@property (assign, nonatomic) NSInteger proTag;
@property (assign, nonatomic) NSInteger cityTag;
@property (assign, nonatomic) NSInteger regTag;
@end

@implementation ApproveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.proTag = 0;
    self.cityTag = 0;
    self.regTag = 0;
    [self createNaviWithType:0 withViewController:self];
    self.naviView.titleLabel.text = @"提交资料";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createTableView];
    [self createView];
    [self createButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    OtherFunction *myFunction = [[OtherFunction alloc] init];
    self.dicForCity = [NSDictionary dictionary];
    self.dicForCity = [myFunction analysisPlistWithName:@"CityData" withType:@"plist"];
    [self plistAnalysisDetail];
    // Do any additional setup after loading the view.
}
#pragma mark - 创建视图
- (void)createView {
    self.viewForCity = [[UIView alloc] initWithFrame:CGRectMake(0, Height * 0.5, Width, Height * 0.5)];
    self.viewForCity.backgroundColor = [UIColor whiteColor];
    
    self.pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, Height * 0.5 - 216, Width, 216)];
    self.pick.delegate = self;
    self.pick.dataSource = self;
    self.pick.showsSelectionIndicator = YES;
    [self plistAnalysisDetail];
    [self.viewForCity addSubview:self.pick];
    
    
}
#pragma mark - 选择器的行数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
#pragma mark - 每行的内容数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (0 == component) {
        return self.arrayProvince.count;
    } else if (1 == component) {
        return self.arrayCity.count;
    } else {
        return self.arrayRegion.count;
    }
}
#pragma mark - 选择器的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == component) {
        return [self.arrayProvince[row] objectForKey:@"-name"];
    } else if (1 == component) {
        return [self.arrayCity[row] objectForKey:@"-name"];
    } else {
        return [self.arrayRegion[row] objectForKey:@"-name"];
    }
}
#pragma mark - 选择器点击
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (0 == component) {
        self.proTag = row;
        self.arrayCity = [[self.arrayProvince objectAtIndex:row] objectForKey:@"shi"];
        self.arrayRegion = [[self.arrayCity objectAtIndex:0] objectForKey:@"qu"];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    } else if (1 == component) {
        self.cityTag = row;
        self.arrayRegion = [[self.arrayCity objectAtIndex:row] objectForKey:@"qu"];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }  else {
        self.regTag = row;
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
    [self.viewForCity addSubview:self.buttonSure];
    
    self.buttonCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonCancel.backgroundColor = Color_System;
    [self.buttonCancel setTintColor:[UIColor whiteColor]];
    self.buttonCancel.layer.masksToBounds = YES;
    self.buttonCancel.layer.cornerRadius = 5;
    [self.buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.buttonCancel addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonCancel.frame = CGRectMake(Width * 0.6, (Height * 0.5 - 216) / 4 , Width * 0.2, (Height * 0.5 - 216) / 2);
    [self.viewForCity addSubview:self.buttonCancel];
}

#pragma mark - 选择和取消按钮事件
- (void)button:(UIButton *)button {
    
    if (button == self.buttonSure) {
        self.strCity = [NSString stringWithFormat:@"%@%@%@", [self.arrayProvince[self.proTag] objectForKey:@"-name"], [self.arrayCity[self.cityTag]objectForKey:@"-name"],[self.arrayRegion[self.regTag] objectForKey:@"-name"]];
        
        [self.tableView reloadData];
        
    }
    
    
    [self.viewForCity removeFromSuperview];
}

#pragma mark - tableView
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width, Height - 64) style:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.tableView registerClass:[ApproveInfoTableViewCell class] forCellReuseIdentifier:@"approve"];
    [self.tableView registerClass:[IdentityTableViewCell class] forCellReuseIdentifier:@"identity"];
    [self.view addSubview:self.tableView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
}
#pragma mark - 隐藏键盘
-(void)hideKeyBoard {
    [self.tableView endEditing:YES];
//    self.keyboardTag = 0;

    self.tableView.frame = CGRectMake(0, 64, Width, Height - 64);
    
    self.tableView.scrollEnabled = YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 3;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (1 == indexPath.section) {
        IdentityTableViewCell *cellIdentity = [tableView dequeueReusableCellWithIdentifier:@"identity"];
        cellIdentity.selectionStyle = 0;
        if (self.selectImage == NULL) {
            [cellIdentity.buttonPhoto1 setImage:[UIImage imageNamed:@"detail.png"] forState:UIControlStateNormal];
        } else {
            [cellIdentity.buttonPhoto1 setImage:[self.selectImage imageWithRenderingMode:1] forState:UIControlStateNormal];
        }
        if (self.selectImage1 == NULL) {
            [cellIdentity.buttonPhoto2 setImage:[UIImage imageNamed:@"detail.png"] forState:UIControlStateNormal];
        } else {
            [cellIdentity.buttonPhoto2 setImage:[self.selectImage1 imageWithRenderingMode:1] forState:UIControlStateNormal];
        }
        if (self.selectImage2 == NULL) {
            [cellIdentity.buttonPhoto3 setImage:[UIImage imageNamed:@"detail.png"] forState:UIControlStateNormal];
        } else {
            [cellIdentity.buttonPhoto3 setImage:[self.selectImage2 imageWithRenderingMode:1] forState:UIControlStateNormal];
        }
        
        __weak typeof(self) weakSelf = self;
        cellIdentity.block = ^(UIButton *button) {
            self.buttonTag = button.tag;
            self.pickerImage = [[UIImagePickerController alloc] init];
            self.pickerImage.delegate = self;
            self.pickerImage.allowsEditing = YES;
            self.pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.pickerImage animated:YES completion:nil];
            
        };
        return cellIdentity;
    } else {
        ApproveInfoTableViewCell *cellApprove = [tableView dequeueReusableCellWithIdentifier:@"approve"];
        cellApprove.selectionStyle = 0;

        cellApprove.back = ^(UITextField *textField) {
            [textField resignFirstResponder];
        };
        if (0 == indexPath.section) {
            if (0 == indexPath.row) {
                cellApprove.myTag = 0;
                NSString *str = @"所在城市*";
                cellApprove.title.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
                if ([self.strCity isEqualToString:@""] || self.strCity == NULL) {
                    cellApprove.showLabel.text = @"请选择服务城市(省/市/区)";
                } else {
                    cellApprove.showLabel.text = self.strCity;
                }
            } else if (1 == indexPath.row) {
                cellApprove.myTag = 1;
                NSString *str = @"真实姓名*";
                cellApprove.title.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
                cellApprove.textField.placeholder = @"本人的真实姓名";
                cellApprove.end = ^(UITextField *textField) {
                    self.trueName = [NSString stringWithFormat:@"%@", textField.text];
                };
                cellApprove.begin = ^(UITextField *textField) {
                    
                };
                
            } else {
                cellApprove.myTag = 1;
                NSString *str = @"身份证号*";
                cellApprove.title.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
                cellApprove.textField.placeholder = @"本人身份证号码";
                cellApprove.end = ^(UITextField *textField) {
                    self.identityCard = [NSString stringWithFormat:@"%@", textField.text];
                };
                cellApprove.begin = ^(UITextField *textField) {
                    
                };
            }
        } else if (2 == indexPath.section) {
            cellApprove.myTag = 2;
            NSString *str = @"紧急联系人*";
            cellApprove.title.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            if ([self.otherName isEqualToString:@""] || self.otherName == NULL) {
                cellApprove.textField.placeholder = @"请输入紧急联系人真实姓名";
            } else {
                cellApprove.textField.text = self.otherName;
            }
            
            cellApprove.right = ^(UIButton *button) {
                self.con = [[CNContactPickerViewController alloc] init];
                self.con.delegate = self;
                [self presentViewController:self.con animated:YES completion:nil];
            };
            cellApprove.end = ^(UITextField *textField) {
                self.otherName = [NSString stringWithFormat:@"%@", textField.text];
            };
            cellApprove.back = ^(UITextField *textField) {
                
                self.tableView.frame = CGRectMake(0, 64, Width, Height - 64);
                [textField resignFirstResponder];
                self.tableView.scrollEnabled = YES;
            };
            cellApprove.begin = ^(UITextField *textField) {
                self.tableView.frame = CGRectMake(0, 64 - 253, Width, Height - 64);
            [self.view bringSubviewToFront:self.naviView];
            self.tableView.scrollEnabled = NO;
            };
        } else if (3 == indexPath.section) {
            cellApprove.myTag = 1;
            NSString *str = @"联系人手机*";
            cellApprove.textField.keyboardType = 4;
            cellApprove.title.attributedText = [self attributeString:str withLocation:str.length - 1 withLength:1];
            cellApprove.textField.placeholder = @"请输入联系人手机号";
            cellApprove.end = ^(UITextField *textField) {
                self.otherPhoneNumber = [NSString stringWithFormat:@"%@", textField.text];
            };
            cellApprove.back = ^(UITextField *textField) {
                
                self.tableView.frame = CGRectMake(0, 64, Width, Height - 64);
                [textField resignFirstResponder];
                self.tableView.scrollEnabled = YES;
            };
            cellApprove.begin = ^(UITextField *textField) {
                self.tableView.frame = CGRectMake(0, 64 - 216, Width, Height - 64);
                [self.view bringSubviewToFront:self.naviView];
                self.tableView.scrollEnabled = NO;
            };
        } else if (4 == indexPath.section) {
            cellApprove.myTag = 1;
            cellApprove.title.text = @"邀请人";
            cellApprove.textField.placeholder = @"邀请码或邀请人手机号";
            cellApprove.end = ^(UITextField *textField) {
                self.request = [NSString stringWithFormat:@"%@", textField.text];
            };
            cellApprove.back = ^(UITextField *textField) {
                
                self.tableView.frame = CGRectMake(0, 64, Width, Height - 64);
                [textField resignFirstResponder];
                self.tableView.scrollEnabled = YES;
            };
            cellApprove.begin = ^(UITextField *textField) {
                self.tableView.frame = CGRectMake(0, 64 - 253, Width, Height - 64);
                [self.view bringSubviewToFront:self.naviView];
                self.tableView.scrollEnabled = NO;
            };
        } else {
            cellApprove.myTag = 3;
            cellApprove.backgroundColor = self.tableView.backgroundColor;
            [self.tableView setSeparatorStyle:0];
        }
        return cellApprove;
    }
}
#pragma mark - 选择相册的图片代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self.pickerImage dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    
    if (101 == self.buttonTag) {
        self.selectImage = [[UIImage alloc] init];
        self.selectImage = image;
    } else if (102 == self.buttonTag) {
        self.selectImage1 = [[UIImage alloc] init];
        self.selectImage1 = image;
    } else {
        self.selectImage2 =[[UIImage alloc] init];
        self.selectImage2 = image;
    }

    [self.tableView reloadData];
//    [self performSelector:@selector(selectPic:) withObject:image afterDelay:0.1];
}

#pragma mark - 取消选择图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (1 == indexPath.section) {
        return (Width * 0.85 / 2) * 3 + Width * 0.2;
    } else {
       return Height * 0.07; 
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (1 == section || 4 == section) {
        return 20;
    } else {
        return CGFLOAT_MIN;
    }
    
}
#pragma mark - 获取键盘高度
- (void)keyboardShow:(NSNotification *)notification {
    NSDictionary *userinfo = [notification userInfo];
    NSValue *value = [userinfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardRect = [value CGRectValue];

//        [self.tableView reloadData];
}
#pragma mark - 通讯录点击代理事件
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    self.otherName = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 点击Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            [self.view addSubview:self.viewForCity];
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, Width, 20);
    label.font = [UIFont systemFontOfSize:12];
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = 0.3;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [view addSubview:label];
    if (1 == section) {
        NSString *str = @"*请按照示例样式进行拍照,并保持照片清晰*";
        label.attributedText = [self attributeString:str withLocation:0 withLength:str.length];
        return view;
    } else if (4 == section) {
        NSString *str = @"以下内容为选填";
        label.attributedText = [self attributeString:str withLocation:0 withLength:str.length];
        return view;
    } else {
        return nil;
    }
    
}
#pragma mark - 省市区plist文件的具体解析
- (void)plistAnalysisDetail {
    self.arrayProvince = [NSMutableArray arrayWithCapacity:0];
    self.arrayCity = [NSMutableArray arrayWithCapacity:0];
    self.arrayRegion = [NSMutableArray arrayWithCapacity:0];
    self.arrayProvince = [[self.dicForCity objectForKey:@"root"] objectForKey:@"sheng"];
    self.arrayCity = [[self.arrayProvince objectAtIndex:0] objectForKey:@"shi"];
    self.arrayRegion = [[self.arrayCity objectAtIndex:0]objectForKey:@"qu"];

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
