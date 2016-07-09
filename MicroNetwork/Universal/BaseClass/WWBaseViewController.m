//
//  WWBaseViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWBaseViewController.h"

@interface WWBaseViewController () <UITextFieldDelegate>

@property (strong, nonatomic) NSArray *arrTextFields;
@property (assign, nonatomic) NSInteger nOffSetOfTextField;

@end

@implementation WWBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Do any additional setup after loading the view, typically from a nib.
    //    //self.view.backgroundColor = [UIColor underPageBackgroundColor];
    //    myTextField = [[UITextField alloc] init];//初始化UITextField
    //    myTextField.frame = CGRectMake(35, 230, 250, 35);
    //    myTextField.delegate = self;//设置代理
    //    myTextField.borderStyle = UITextBorderStyleRoundedRect;
    //    myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //    myTextField.placeholder = @"Please entry your content!";//内容为空时默认文字
    //    myTextField.returnKeyType = UIReturnKeyDone;//设置放回按钮的样式
    //    myTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//设置键盘样式为数字
    //    [self.view addSubview:myTextField];
    
    
    //注册键盘出现与隐藏时候的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    [self.view addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public method
- (void)addCurTextFields:(NSArray *)arrTextFields {
    for (UITextField *fieldText in arrTextFields) {
        if (fieldText) {
            fieldText.delegate = self;
        }
    }
    
    self.arrTextFields = arrTextFields;
}

#pragma mark - Private method
- (UITextField *)checkWhichTextFieldFirstResponder {
    for (UITextField *fieldText in self.arrTextFields) {
        if (!fieldText) {
            continue;
        }
        
        if ([fieldText isFirstResponder]) {
            return fieldText;
        }
    }
    
    return nil;
}

//键盘出现时候调用的事件
-(void)keyboardWillShow:(NSNotification *)notification{
    UITextField *textField = [self checkWhichTextFieldFirstResponder];
    
    if (!textField) {
        return;
    }
    
    // Get keyboardSize and keyboardHeight
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat keyboardHeight = 0;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        keyboardHeight = keyboardSize.height;
    } else {
        keyboardHeight = keyboardSize.width;
    }
    
    if (keyboardHeight == 0) {
        return;
    }
    
    CGFloat distance = (self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height));
    CGFloat gap = 10;
    
    self.nOffSetOfTextField = 0;//屏幕总高度-键盘高度-UITextField高度
    if (distance < keyboardHeight + gap) {
        self.nOffSetOfTextField = keyboardHeight + gap - distance;
    } else {
        return;
    }
    
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
    self.view.frame = CGRectMake(0, -self.nOffSetOfTextField, self.view.frame.size.width, self.view.frame.size.height);//UITextField位置的y坐标移动到offY
    [UIView commitAnimations];//开始动画效果
}
//键盘消失时候调用的事件
-(void)keyboardWillHide:(NSNotification *)notification{
    if (self.nOffSetOfTextField > 1) {
        [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
        [UIView setAnimationDuration:0.3];
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);//UITextField位置复原
        
        [UIView commitAnimations];
        
        self.nOffSetOfTextField = 0;
        
    } else {
        
        self.nOffSetOfTextField = 0;
    }
    
}
//隐藏键盘方法
-(void)hideKeyboard{
    
    UITextField *textField = [self checkWhichTextFieldFirstResponder];
    if (!textField) {
        return;
    }
    
    [textField resignFirstResponder];
}

#pragma mark UITextFieldDelegate
//开始编辑：
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

//点击return按钮所做的动作：
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];//取消第一响应
    return YES;
}

//编辑完成：
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}


@end
