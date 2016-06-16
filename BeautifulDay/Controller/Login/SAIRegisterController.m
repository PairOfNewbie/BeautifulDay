//
//  SAIRegisterController.m
//  sai-iOS
//
//  Created by DaiFengyi on 15/11/5.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import "SAIRegisterController.h"
#import "SAIUtil.h"
#define kCountTime 60
@interface SAIRegisterController ()
@property (copy, nonatomic) NSString *phone;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *validateCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *resendValidationCodeButton;
@end

@implementation SAIRegisterController {
    NSInteger _count;
    NSTimer *_countTimer;
}
- (instancetype)initWithPhone:(NSString *)phone {
    self = [super init];
    if (self) {
        self.phone = phone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    self.phoneLabel.text = [NSString stringWithFormat:@"手机号：%@", self.phone];
    [self startCount];
}

- (IBAction)resendValidationCode:(UIButton *)sender {
    //按钮置灰
    [self startCount];
    [SAIUtil showLoading];
//    [SAIAuthentication sendValidateCodeByMobile:self.phone
//        success:^{
//            [SAIUtil hideHUD];
//            [SAIUtil showMsg:@"验证码已发送"];
//        }
//        failure:^(NSError *error) {
//            [SAIUtil hideHUD];
//            [SAIUtil showMsg:error.localizedDescription];
//            [_countTimer invalidate];
//            self.resendValidationCodeButton.enabled = YES;
//            [self.resendValidationCodeButton setTitle:@"发送验证码" forState:UIControlStateDisabled];
//        }];
}

- (IBAction)registerButtonClick:(UIButton *)sender {
    if (self.validateCodeTextField.text.length < 6) {
        [SAIUtil showMsg:@"验证码不足6位"];
        return;
    }

    if (self.passwordTextField.text.length < 6) {
        [SAIUtil showMsg:@"密码不足6位"];
        return;
    }
    [SAIUtil showLoading];
//    [SAIAuthentication signupByMobile:self.phone
//                             password:self.passwordTextField.text
//                           verifyCode:self.validateCodeTextField.text
//                       onStateChanged:^(SAIUserInfo *user, NSError *error) {
//                           [SAIUtil hideHUD];
//                           if (error) {
//                               dispatch_async(dispatch_get_main_queue(), ^{
//                                   UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"注册失败"
//                                                                                message:error.localizedDescription
//                                                                               delegate:nil
//                                                                      cancelButtonTitle:@"确定"
//                                                                      otherButtonTitles:nil];
//                                   [av show];
//                               });
//                               return;
//                           }
//                           dispatch_async(dispatch_get_main_queue(), ^{
//                               [SAIUtil showMsg:@"注册成功"];
//                               [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                           });
//                       }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Timer Action
- (void)refreshCount:(id)sender {
    [self.resendValidationCodeButton setTitle:[NSString stringWithFormat:@"(%ldS)", (long)_count] forState:UIControlStateDisabled];
    if (_count-- == 0) {
        [_countTimer invalidate];
        self.resendValidationCodeButton.enabled = YES;
        [self.resendValidationCodeButton setTitle:@"发送验证码" forState:UIControlStateDisabled];
    }
}

- (void)startCount {
    self.resendValidationCodeButton.enabled = NO;
    _count = kCountTime;
    _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(refreshCount:) userInfo:nil repeats:YES];
}
// 该设计没有注册须知
//- (IBAction)registrationTermButtonClick:(UIButton *)sender {
//    UIViewController *vc = [[UIViewController alloc] init];
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [vc.view addSubview:webView];
//    [webView loadRequest:[SAIAPI CreateRequestWithHeadersByStr:[SAIAPI getPrivacyTermsLink]]];
//    [self.navigationController pushViewController:vc animated:YES];
//}

@end
