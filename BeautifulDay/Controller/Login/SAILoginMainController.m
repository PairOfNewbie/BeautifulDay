//
//  SAILoginMainController.m
//  sai-iOS
//
//  Created by DaiFengyi on 15/11/5.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import "SAILoginMainController.h"
#import "SAIRegisterController.h"
#import "ShareSDK/ShareSDK.h"
#import "SAIUtil.h"
@interface SAILoginMainController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation SAILoginMainController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - btn delegate
- (void)dismissSelf {
    if (self.navigationController != nil) {
        [self.navigationController dismissViewControllerAnimated:YES
                                                      completion:^{
                                                          [self.delegate cancel];
                                                      }];
    }
}
- (IBAction)WeiboLogin:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WeiboLogin)]) {
        [self.delegate WeiboLogin];
    }
}

- (IBAction)QQLogin:(id)sender {
    if ([self.delegate respondsToSelector:@selector(QQLogin)]) {
        [self.delegate QQLogin];
    }
}

- (IBAction)WeichatLogin:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WeichatLogin)]) {
        [self.delegate WeichatLogin];
    }
    
}
- (IBAction)registerButtonClick:(UIButton *)sender {
    if (![SAIUtil validateMobile:self.phoneTextField.text]) {
        [SAIUtil showMsg:@"手机格式不正确"];
        return;
    }
    [SAIUtil showLoading];
    
    
//    [SAIAuthentication sendValidateCodeByMobile:self.phoneTextField.text
//        success:^{
//            SAIRegisterController *rc = [[SAIRegisterController alloc] initWithPhone:self.phoneTextField.text];
//            [self.navigationController pushViewController:rc animated:YES];
//            [SAIUtil showMsg:@"验证码已发送"];
//        }
//        failure:^(NSError *error) {
//            if (error.code == 10008) {
//                [self loginButtonClick:nil];
//            } else {
//                [SAIMonitor trackError:monitor_eventLabel_error_sendRegistValidateCode error:error];
//            }
//            [SAIUtil showMsg:error.localizedDescription];
//        }];
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
