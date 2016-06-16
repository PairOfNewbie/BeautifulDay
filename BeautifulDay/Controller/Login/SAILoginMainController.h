//
//  SAILoginMainController.h
//  sai-iOS
//
//  Created by DaiFengyi on 15/11/5.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SAILoginMainControllerDelegate <NSObject>
- (void)WeiboLogin;
- (void)QQLogin;
- (void)WeichatLogin;
- (void)EmailLogin:(NSString *)Email password:(NSString *)password;
- (void)cancel;
@end

@interface SAILoginMainController : UIViewController
- (IBAction)WeiboLogin:(id)sender;
- (IBAction)QQLogin:(id)sender;
- (IBAction)WeichatLogin:(id)sender;
@property (nonatomic, assign) id<SAILoginMainControllerDelegate> delegate;
@end
