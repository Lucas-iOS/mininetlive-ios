//
//  WWInviteCodeViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/21.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWInviteCodeViewController.h"
#import "WWLoginServices.h"
#import "WWUtils.h"
#import "SVProgressHUD.h"
#import "NSUserDefaults+Signin.h"


@interface WWInviteCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textInviteCode;
@property (weak, nonatomic) IBOutlet UIButton *btnComplete;

@end

@implementation WWInviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnComplete.layer.cornerRadius = 4;
    self.navigationItem.hidesBackButton = YES;
    self.title = @"邀请码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCompleteClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] setShowInvited:@0];
    if ([self.textInviteCode.text isEqualToString:@""] || !self.textInviteCode.text) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [SVProgressHUD show];
        [WWLoginServices sendInviteCode:self.textInviteCode.text uid:self.uib resultBlock:^(WWbaseModel *baseModel, NSError *error) {
            if (!error) {
                [SVProgressHUD dismiss];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
            }
        }];
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
