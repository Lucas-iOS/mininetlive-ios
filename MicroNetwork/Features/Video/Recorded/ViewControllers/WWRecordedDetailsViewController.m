//
//  WWRecordedDetailsViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWRecordedDetailsViewController.h"
#import "WWRecordedIntroducedTableViewCell.h"
#import "WWTabBarView.h"
#import "WWPayView.h"
#import "WWUtils.h"
#import "KRVideoPlayerController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "Pingpp.h"
#import "WWRecordedDetailsServices.h"
#import "SVProgressHUD.h"
#import "EMSDK.h"
#import "NSUserDefaults+Signin.h"
#import "WWLiveMenberTableViewCell.h"
#import "WWLiveDetailsFootView.h"
#import "WWRecordedVideoImageView.h"
#import "WWPlayerView.h"



#define COLOR_GREEN     UIColorFromRGB(0x0AC653);

typedef enum : NSUInteger {
    kVideoTypeFree = 0,
    kVideoTypeFee,
} kVideoType;

typedef enum : NSUInteger {
    kPlayTypesLive = 0,
    kPlayTypesRecorded,
} kPlayTypes;

//static const NSInteger kPayStatusDidnBuy = 0;


@interface WWRecordedDetailsViewController () <UITableViewDelegate, UITableViewDataSource, PayViewDelegate, KRVideoPlayerDelegate, WWPlayerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelVideoType;
@property (weak, nonatomic) IBOutlet UILabel *labelPlayCount;
@property (strong, nonatomic) UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic) CGSize size;
@property (nonatomic, strong) KRVideoPlayerController *videoController;
@property (nonatomic, strong) WWTabBarView *tabBarView;

@property (strong, nonatomic) EMGroup *group;
@property (strong, nonatomic) WWLiveDetailsFootView *footView;
@property (strong, nonatomic) WWPlayerView *playerView;

@end

@implementation WWRecordedDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    [self addTabBarView];
    [self initTipsView];
    
    [self.view addSubview:self.videoController.view];
    
    if (self.video.streamType == kPlayTypesLive) {
        [self joinGroup];
    }
    
    //最后加上避免挡住
    [self addButtonBack];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (self.video.streamType == kPlayTypesLive) {
        [self leaveGroup];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - KRVideoPlayer Delegate

- (void)videoFullScreenButtonClick {
    self.btnBack.hidden = YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)videoShrinkScreenButtonClick {
    self.btnBack.hidden = NO;
}

- (void)liveVideoFullScreenButtonClick {
    self.btnBack.hidden = YES;
}

- (void)liveVideoShrinkScreenButtonClick {
    self.btnBack.hidden = NO;
}

#pragma mark - PayView Delegate
//支付方式和金额
- (void)choicePaymentClick:(kPayment)payment andMoney:(NSString *)money {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(self.video.activityType) forKey:@"amount"];
    [dic setObject:money forKey:@"payType"];

    if (payment == kPaymentAliPay) {
        [dic setObject:@"alipay" forKey:@"channel"];
    } else {
        [dic setObject:@"wx" forKey:@"channel"];
    }
    
    [WWRecordedDetailsServices requestPay:dic resultBlock:^(WWbaseModel *baseModel, NSError *error) {
        [Pingpp createPayment:baseModel.data
               viewController:self
                 appURLScheme:@"test"
               withCompletion:^(NSString *result, PingppError *error) {
                   if ([result isEqualToString:@"success"]) {
                       // 支付成功
                   } else {
                       // 支付失败或取消
                       NSLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
                   }
               }];
    }];
}

#pragma mark - Private Method
- (void)initialize {
    
    self.tableView.contentInset = UIEdgeInsetsMake(SCREEN_WIDTH*(9.0/16.0), 0, 49, 0);
    self.labelTitle.text = self.video.title;
    self.labelTime.text = [NSString stringWithFormat:@"时间：%@",self.video.date];
    self.labelPlayCount.text = [NSString stringWithFormat:@"播放：%zd次",self.video.playCount];
    self.tableView.estimatedRowHeight = 137;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)showmenberList:(NSArray *)menberList menberCount:(NSNumber *)menberCount {
    if (menberList.count < 5) {
        self.footView = [[WWLiveDetailsFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115) names:menberList menberCount:menberCount];
    } else {
        self.footView = [[WWLiveDetailsFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 215) names:menberList menberCount:menberCount];
    }
    [self.tableView setTableFooterView:self.footView];
}

- (void)joinGroup {
    __weak __block typeof(self) weakSelf = self;
    [WWRecordedDetailsServices requestGroupJoin:self.video.groupId resultBlock:^(WWbaseModel *baseModel, NSError *error) {
        if (self.video.streamType == kPlayTypesLive) {
            EMError *err = nil;
            weakSelf.group = [[EMClient sharedClient].groupManager fetchGroupInfo:self.video.groupId includeMembersList:YES error:&err];
            if (!error) {
                //获取群成员资料
                [WWRecordedDetailsServices requestGroupMemberList:weakSelf.video.groupId resultBlock:^(NSArray *menberList, NSError *error) {
                    //获取群人数
                    [WWRecordedDetailsServices requestGroupMemberCount:self.video.groupId resultBlock:^(WWbaseModel *baseModel, NSError *error) {
                        if (!error) {
                            NSNumber *count = baseModel.data[@"count"];
                            [weakSelf showmenberList:menberList menberCount:count];
                        }
                    }];
                    
                }];
            }
        }
    }];
}

- (void)leaveGroup {
    __weak __block typeof(self) weakSelf = self;
    [WWRecordedDetailsServices requestGroupLeave:self.video.groupId resultBlock:^(WWbaseModel *baseModel, NSError *error) {
        EMError *err = nil;
        [[EMClient sharedClient].groupManager leaveGroup:weakSelf.group.groupId error:&err];
        if (!err) {
            NSLog(@"退群成功");
        }
    }];
}

//不同类型视频展示预约或购买人数
- (void)initTipsView {
    UILabel *tipsShow = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-220, 80, 200, 24)];
    tipsShow.textAlignment = NSTextAlignmentRight;
    
    if (self.video.streamType == kPlayTypesLive) {
        tipsShow.font = [UIFont systemFontOfSize:14];
        tipsShow.textColor = UIColorFromRGB(0xA0A0A0);
        NSString *string = [NSString stringWithFormat:@"%zd",self.video.playCount];
        NSString *str = [NSString stringWithFormat:@"已有 %@ 人预约",string];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
        [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(3,string.length)];
        [attriString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x4A90E2) range:NSMakeRange(3, string.length)];
        tipsShow.attributedText = attriString;
        
        self.playerView = [[WWPlayerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * (9.0/16.0)) VideoModel:self.video];
        self.playerView.delegate = self;
        [self.view addSubview:self.playerView];

    } else {
        tipsShow.textColor = UIColorFromRGB(0x0AC653);
        tipsShow.font = [UIFont systemFontOfSize:20];

        NSString *str = [NSString stringWithFormat:@"¥%zd", self.video.price];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
        [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 1)];
        tipsShow.attributedText = attriString;
        [self addRecordedVideoImageView];
    }
    [self.topView addSubview:tipsShow];
}

- (void)addRecordedVideoImageView {
    __weak __block typeof(self) weakSelf = self;
    WWRecordedVideoImageView *recordedVideoImageView = [[WWRecordedVideoImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * (9.0/16.0)) imageURL:self.video.fontCover clickBlock:^{
        if (weakSelf.video.activityType == kVideoTypeFee) {
            [WWUtils showTipAlertWithTitle:@"收费视频" message:@"请购买后观看"];
        } else {
            [weakSelf playVideoWithURL:[NSURL URLWithString:self.video.videoPath]];
        }
    }];

    [self.view addSubview:recordedVideoImageView];
}

+ (NSMutableAttributedString *)stringConversionAttributedString:(NSString *)string {
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
    [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(3,4)];
    [attriString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x878787) range:NSMakeRange(3, 4)];
    return attriString;
}

//根据不同类型视频底部展示预约或者购买
- (void)addTabBarView {
    CGRect frame = CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
    self.tabBarView = [WWTabBarView loadFromNib];
    self.tabBarView.frame = frame;
    [self.tabBarView.btnShare addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tabBarView];
    
    if (self.video.streamType == kPlayTypesLive) {
        
        if (self.video.activityType == kVideoTypeFree) {
            if (self.video.appoinState == 0) {
                [self.tabBarView setRightButtonTitle:@"立即预约" andBackgroundImageString:@"btn_reservation"];
                [self.tabBarView.rightButton addTarget:self action:@selector(appointmentClick) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [self.tabBarView setRightButtonTitle:@"已预约" andBackgroundImageString:@"btn_done"];
            }
        } else {
            [self checkPayment];
        }
        
    } else {
        if (self.video.activityType == kVideoTypeFree) {
            [self.tabBarView setRightButtonTitle:@"打赏红包" andBackgroundImageString:@"btn_reward"];
            [self.tabBarView.rightButton addTarget:self action:@selector(aTipClick) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [self checkPayment];
        }
    }
    
}

- (void)checkPayment {
    if (self.video.payState == 0) {
        [self.tabBarView setRightButtonTitle:@"购买观看" andBackgroundImageString:@"btn_buy"];
        [self.tabBarView.rightButton addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.tabBarView setRightButtonTitle:@"打赏红包" andBackgroundImageString:@"btn_reward"];
        [self.tabBarView.rightButton addTarget:self action:@selector(aTipClick) forControlEvents:UIControlEventTouchUpInside];    }
}

- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0)) video:self.video];
        self.videoController.delegate = self;
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
        [self.videoController.view addSubview:self.btnBack];
    }
    self.videoController.contentURL = url;
}

- (void)addButtonBack {
    self.btnBack = [[UIButton alloc] initWithFrame:CGRectMake(5, 13, 48, 48)];
    [self.btnBack setImage:[UIImage imageNamed:@"ic_back_detail"] forState:UIControlStateNormal];
    [self.btnBack addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnBack];
}

- (void)popVC {

    if (self.videoController) {
        [self.videoController dismiss];
        self.videoController = nil;
    } else if (self.playerView) {
        [self.playerView shutdown];
        [self.playerView removeAllSubviews];
        self.playerView = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (void)showPayViewMethod:(kMethod)method andPayAmount:(NSString *)payAmount {
    WWPayView *payView = [WWPayView loadFromNib];
    [payView selectMethodOfPayment:method andPayAmount:payAmount];
    payView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    payView.delegate = self;
    [self.view addSubview:payView];
}

- (void)shareClick {
    NSArray* imageArray = @[[UIImage imageNamed:@"微网直播"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}

}

- (void)appointmentClick {
    [SVProgressHUD show];

    __weak __block typeof(self) weakSelf = self;
    [WWRecordedDetailsServices requestAppointment:self.video.aid resultBlock:^(WWbaseModel *baseModel, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
            [WWUtils showTipAlertWithMessage:baseModel.msg];
            if (baseModel.ret == KERN_SUCCESS) {
                [weakSelf.tabBarView setRightButtonTitle:@"已预约" andBackgroundImageString:@"btn_done"];
                weakSelf.tabBarView.rightButton.userInteractionEnabled = NO;
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
        }
    }];
}

- (void)aTipClick {
    //打赏金额传nil
    [self showPayViewMethod:kMethodATip andPayAmount:nil];
}

- (void)buyClick {
    [self showPayViewMethod:kMethodBuy andPayAmount:[NSString stringWithFormat:@"%zd",self.video.price]];
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (indexPath.section == 0) {
        WWRecordedIntroducedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Details Introduced" forIndexPath:indexPath];
        [cell autoLayoutHeight:self.video.desc];
        return cell;
//    } else {
//        WWLiveMenberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Menber Cell" forIndexPath:indexPath];
//        [cell setMenber:self.menberList];
//        return cell;
//    }
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
