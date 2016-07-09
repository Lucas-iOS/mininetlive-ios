//
//  WWRegisterStep3ViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/11.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWRegisterStep3ViewController.h"
#import "WWUtils.h"
#import "WWRegisterStepServices.h"
#import "GBHeadPortraitImageView.h"
#import "UIImageView+AFNetworking.h"
#import "NSUserDefaults+Signin.h"
#import "WWUserTokenModel.h"
#import "SVProgressHUD.h"



@interface WWRegisterStep3ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldNickName;
@property (strong, nonatomic) UIButton *currentBtn;
@property (nonatomic) NSInteger gender;
@end

@implementation WWRegisterStep3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //性别默认0为女
    self.gender = 0;
    [self addCurTextFields:[NSArray arrayWithObjects:self.textFieldNickName,nil]];
    
//    GBHeadPortraitImageView *headPortrait = [[GBHeadPortraitImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 30, 94, 60, 60) currentVC:self resultBlock:^(UIImage *newImage) {
//        
//    }];
//    [headPortrait setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"ic_head"]];
//    [self.view addSubview:headPortrait];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnSelectGender:(UIButton *)sender {
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    self.gender = sender.tag;
    
    if (sender != self.currentBtn) {
        self.currentBtn.selected = NO;
        self.currentBtn.userInteractionEnabled = YES;
        self.currentBtn = sender;
    }
}

- (IBAction)pushClick:(UIButton *)sender {
    if (![self checkNickNameSex]) {
        return;
    }
    
    __weak __block typeof(self) weakSelf = self;
    
    NSDictionary *dic = @{@"phone":self.phoneNumber,
                          @"password":self.textPassword,
                          @"nickname":self.textFieldNickName.text,
                          @"inviteCode":self.textInviteCode,
                          @"gender":@(self.gender)};
    [SVProgressHUD show];
    [WWRegisterStepServices requestRegisterParameters:dic resultBlock:^(WWbaseModel *baseModel, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
            if (baseModel.ret == KERN_SUCCESS) {
                WWUserTokenModel *userToken = [WWUserTokenModel modelWithDictionary:baseModel.data];
                [[NSUserDefaults standardUserDefaults] setUserToken:userToken.token];
                [[NSUserDefaults standardUserDefaults] setShowInvited:userToken.showInvited];
                [[NSUserDefaults standardUserDefaults] setUserInfo:userToken.user];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            } else {
                [WWUtils showTipAlertWithMessage:baseModel.msg];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
        }
    }];
}

- (BOOL)checkNickNameSex {
    if (self.currentBtn.selected == NO || [self.textFieldNickName.text isEqualToString:@""] || !self.textFieldNickName.text) {
        [WWUtils showTipAlertWithMessage:@"请输入昵称/性别"];
        return NO;
    }
    
    if (self.textFieldNickName.text.length > 16) {
        [WWUtils showTipAlertWithMessage:@"昵称不能超过16个字，太长啦"];
        return NO;
    }
    
    return YES;
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
