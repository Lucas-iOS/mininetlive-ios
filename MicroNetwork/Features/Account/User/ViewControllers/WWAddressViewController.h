//
//  WWAddressViewController.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/10.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


#define kDisplayProvince 0
#define kDisplayCity 1
#define kDisplayArea 2

@interface WWAddressViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) int displayType;
@property (nonatomic,strong) NSArray *provinces;
@property (nonatomic,strong) NSArray *citys;
@property (nonatomic,strong) NSArray *areas;
@property (nonatomic,strong) NSString *selectedProvince;//选中的省
@property (nonatomic,strong) NSString *selectedCity;//选中的市
@property (nonatomic,strong) NSString *selectedArea;//选中的区


@end
