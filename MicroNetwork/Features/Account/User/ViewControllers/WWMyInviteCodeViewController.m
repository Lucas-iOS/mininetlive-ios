//
//  WWMyInviteCodeViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/26.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWMyInviteCodeViewController.h"
#import "NSUserDefaults+Signin.h"

@interface UICopyLabel : UILabel

@end

@implementation UICopyLabel

//- (id)initWithFrame:(CGRect)frame {
//
//    if (self = [super initWithFrame:frame]) {
//
//        [self attachTapHandler];
//    }
//    return self;
//
//}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self attachTapHandler];
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    return (action == @selector(copy:));
}

- (void)copy:(id)sender {
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

-(void)attachTapHandler {
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    touch.numberOfTapsRequired = 1;
    [self addGestureRecognizer:touch];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
    
    [self becomeFirstResponder];
    
    UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                      action:@selector(copy:)];
    
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
    
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
    
}

@end

@interface WWMyInviteCodeViewController ()
@property (weak, nonatomic) IBOutlet UICopyLabel *labelInviteCode;

@end

@implementation WWMyInviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelInviteCode.text = [NSUserDefaults standardUserDefaults].inviteCode;
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
