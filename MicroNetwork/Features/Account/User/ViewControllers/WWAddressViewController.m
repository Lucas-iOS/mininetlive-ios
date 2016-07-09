//
//  WWAddressViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/10.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWAddressViewController.h"
#import "WWAddressTableViewCell.h"
#import "WWPositioningTableViewCell.h"
#import "WWUtils.h"


@interface WWAddressViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) WWAddressTableViewCell *addressCell;
@property (strong, nonatomic) WWPositioningTableViewCell *currentCell;

@end

@implementation WWAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeLocationService];
    [self configureData];
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeLocationService {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            self.addressCell.address.text = [NSString stringWithFormat:@"%@  %@",placemark.administrativeArea, placemark.locality];
        }
        else if (error == nil && [array count] == 0) {
            NSLog(@"No results were returned.");
            self.addressCell.address.text = @"未能获取位置";
        }
        else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
            self.addressCell.address.text = @"未能获取位置";
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];

}

-(void)configureData{
    if (self.displayType == kDisplayProvince) {
        //从文件读取地址字典
        NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
        self.provinces = [dict objectForKey:@"address"];
    }
}

-(void)configureViews{
    if (self.displayType == kDisplayCity) {//只在选择区域页面显示确定按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.displayType == kDisplayProvince) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && self.displayType == kDisplayProvince) {
        return 1;
    }
    if (self.displayType == kDisplayProvince) {
        return self.provinces.count;
    }
    return self.citys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"Address Cell";
    if (indexPath.section == 0 && self.displayType == kDisplayProvince) {
        self.addressCell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
        return self.addressCell;
    }

    static NSString *Identifier = @"Positioning Cell";
    WWPositioningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    if (self.displayType == kDisplayCity) {
        cell.accessoryImageView.hidden = YES;
    }else{
        cell.accessoryImageView.hidden = NO;
    }
    if (self.displayType == kDisplayProvince) {
        NSDictionary *province = self.provinces[indexPath.row];
        NSString *provinceName = [province objectForKey:@"name"];
        cell.positioning.text = provinceName;
    }else if (self.displayType == kDisplayCity){
        NSDictionary *city = self.citys[indexPath.row];
        NSString *cityName = [city objectForKey:@"name"];
        cell.positioning.text = cityName;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && self.displayType == kDisplayProvince) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:self.addressCell.address.text message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
    if (self.displayType == kDisplayProvince) {
        NSDictionary *province = self.provinces[indexPath.row];
        NSArray *citys = [province objectForKey:@"sub"];
        self.selectedProvince = [province objectForKey:@"name"];

        //构建下一级视图控制器
        WWAddressViewController *cityVC = (WWAddressViewController *)[WWUtils getVCWithStoryboard:@"User" viewControllerId:@"AddressVC"];
        cityVC.displayType = kDisplayCity;//显示模式为城市
        cityVC.citys = citys;
        cityVC.selectedProvince = self.selectedProvince;
        [self.navigationController pushViewController:cityVC animated:YES];
    } else {
        NSDictionary *city = self.citys[indexPath.row];
        self.selectedCity = [city objectForKey:@"name"];
        WWPositioningTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType  = UITableViewCellAccessoryCheckmark;
        if (self.currentCell != cell) {
            self.currentCell.accessoryType = UITableViewCellAccessoryNone;
            self.currentCell = cell;
        }
    }
}

-(void)submit{
    NSString *msg = [NSString stringWithFormat:@"%@-%@-%@",self.selectedProvince,self.selectedCity,self.selectedArea];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"选择地址" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
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
