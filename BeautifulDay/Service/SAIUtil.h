//
//  SAIHelper.h
//  sai-iOS
//
//  Created by DaiFengyi on 15/9/22.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SAIUtil : NSObject
#pragma mark - HUD
// 显示提示信息
+ (void)showMsg:(NSString *)message;

// 显示加载中...
+ (void)showLoading;

+ (void)showLoading:(NSString *)message;

// 隐藏所有指示器
+ (void)hideHUD;

+ (void)showAlert:(NSString *)message title:(NSString *)title;

#pragma mark - Validation
//检测手机号码是否合法
+ (BOOL)validateMobile:(NSString *)mobileNum;
//检测邮箱格式
+ (BOOL)validateEmail:(NSString *)email;

#pragma mark - Date
+ (NSString *)stringWithDate:(NSDate *)date;
#pragma mark -
+ (UIImage *)compressImageMaxEdgeToMaxLen:(UIImage *)originalImg maxEdgeMaxLen:(int)maxEdgeMaxLen;
+ (UIImage *)cropImage:(UIImage *)originalImg WithFrame:(CGRect)frame;
/**
 *  get current device id, app uninstall and install again will not change
 *
 *  @return <#return value description#>
 */
+ (NSString *)getDeviceID;

/**
 *  test is current debug version and add debug tag if it is
 *
 *  @param orgInfo title of page
 *
 *  @return
 */
+ (NSString *)addDebugTitle:(NSString *)orgInfo;

/**
 *  find a view's controller
 *
 *  @param sourceView sourceView
 *
 *  @return
 */
+ (UIViewController *)findViewController:(UIView *)sourceView;
/**
 *    get the image url with imageMogr2 query string of Qiniu
 *
 *  @param orgURL
 *  @param targetW
 *
 *  @return
 */
+ (UINavigationController *)getRootNav;
@end
