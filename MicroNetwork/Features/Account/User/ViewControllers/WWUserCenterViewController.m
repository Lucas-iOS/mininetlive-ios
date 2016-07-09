//
//  WWUserCenterViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/7.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWUserCenterViewController.h"
#import "WWUtils.h"
#import "WWUserInfoModel.h"
#import "UIImageView+AFNetworking.h"
#import "WWUserServices.h"
#import "NSUserDefaults+Signin.h"
#import "SVProgressHUD.h"


@interface WWUserCenterViewController () <UITableViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end

@implementation WWUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.borderWidth = 1;
    self.userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)initializeTheUserDataShow {
    [self.userImageView setImageWithURL:[NSURL URLWithString:[NSUserDefaults standardUserDefaults].avatar] placeholderImage:[UIImage imageNamed:@"ic_head"]];
    self.nickName.text = [NSUserDefaults standardUserDefaults].nickName;
    self.phone.text = [NSUserDefaults standardUserDefaults].phone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initializeTheUserDataShow];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd",indexPath.row);
    if (indexPath.section == 2) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否确定要注销登录"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:@"确定"
                                                        otherButtonTitles:nil, nil];
        [actionSheet showInView:self.view];
        
    }
}

#pragma mark Action Sheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        __weak __block typeof(self) weakSelf = self;
        [SVProgressHUD show];
        [WWUserServices requestLogOut:[NSUserDefaults standardUserDefaults].uid resultBlock:^(WWbaseModel *baseModel, NSError *error) {
            if (!error) {
                [SVProgressHUD dismiss];
                if (baseModel.ret == KERN_SUCCESS) {
                    [[NSUserDefaults standardUserDefaults] removeUserInfo];
                    [weakSelf initializeTheUserDataShow];
                } else {
                    [WWUtils showTipAlertWithMessage:baseModel.msg];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
            }
        }];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"-------%@",segue.destinationViewController);
}


@end
