//
//  SAIHelper.m
//  sai-iOS
//
//  Created by DaiFengyi on 15/9/22.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import "MBProgressHUD.h"
#import "SAIUtil.h"

#define APP [UIApplication sharedApplication]

@implementation SAIUtil
#pragma mark - HUD
+ (MBProgressHUD *)Hud
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:APP.keyWindow];
    if (hud){
        [hud removeFromSuperview];
    }else{
        hud = [[MBProgressHUD alloc] initWithWindow:APP.keyWindow];
        hud.removeFromSuperViewOnHide = YES;
    }
    [APP.keyWindow addSubview:hud];
    return hud;
}

+ (void)showMsg:(NSString *)message
{
    MBProgressHUD *hud = [self Hud];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.labelFont = [UIFont systemFontOfSize:13];
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
}

+ (void)showLoading
{
    [self showLoading:@"请稍候..."];
}

+ (void)showLoading:(NSString *)message
{
    MBProgressHUD *hud = [self Hud];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelFont = [UIFont systemFontOfSize:13];
    [hud show:YES];
}

+ (void)hideHUD
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:APP.keyWindow];
    [hud hide:YES];
}


+ (void)showAlert:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark - Validation
//检测手机号码是否合法
+ (BOOL)validateMobile:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    /**
     * 虚拟运营商 170
     */
    NSString *VO = @"^1(7[0-9])\\d{8}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestvo = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VO];

    if (([regextestmobile evaluateWithObject:mobileNum] == YES) || ([regextestcm evaluateWithObject:mobileNum] == YES) ||
        ([regextestct evaluateWithObject:mobileNum] == YES) || ([regextestcu evaluateWithObject:mobileNum] == YES) ||
        ([regextestvo evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}
//检测邮箱格式
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - Date
+ (NSString *)stringWithDate:(NSDate *)date {
    if (date == nil) {
        return nil;
    }
    NSDate *now = [NSDate date];
    // the seconds of interval
    NSTimeInterval interval = [now timeIntervalSinceDate:date];
    double year = 0;
    double month = 0;
    double week = 0;
    double day = 0;
    double hour = 0;
    double minute = 0;

    minute = interval / 60;
    hour = minute / 60;
    day = hour / 24;
    week = day / 7;
    month = day / 30;
    year = month / 12;

    if (year >= 1) {
        return [NSString stringWithFormat:@"%ld年前", (long) year];
    } else if (month >= 1) {
        return [NSString stringWithFormat:@"%ld月前", (long) month];
    } else if (week >= 1) {
        return [NSString stringWithFormat:@"%ld周前", (long) week];
    } else if (day >= 1) {
        return [NSString stringWithFormat:@"%ld天前", (long) day];
    } else if (hour >= 1) {
        return [NSString stringWithFormat:@"%ld小时前", (long) hour];
    } else if (minute >= 1) {
        return [NSString stringWithFormat:@"%ld分钟前", (long) minute];
    } else {
        return @"刚刚";
    }
}
#pragma mark - image
+ (UIImage *)compressImageMaxEdgeToMaxLen:(UIImage *)originalImg maxEdgeMaxLen:(int)maxEdgeMaxLen {
    CGSize originalSize = originalImg.size;
    CGFloat maxEdgeLen = fmaxf(originalSize.height, originalSize.width);
    if (maxEdgeLen <= maxEdgeMaxLen) {
        return originalImg;
    }

    // resize
    CGSize newSize;
    if (originalSize.height < originalSize.width) {
        float y = (maxEdgeMaxLen * originalSize.height) / originalSize.width;
        newSize = CGSizeMake(maxEdgeMaxLen, roundf(y));
    } else {
        float x = (maxEdgeMaxLen * originalSize.width) / originalSize.height;
        newSize = CGSizeMake(roundf(x), maxEdgeMaxLen);
    }
    UIImage *resizedImg;
    UIGraphicsBeginImageContext(newSize);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClearRect(context, CGRectMake(0, 0, newSize.width, newSize.height));
        CGContextSetInterpolationQuality(context, kCGInterpolationNone);
        [originalImg drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        resizedImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    return resizedImg;
}

+ (UIImage *)cropImage:(UIImage *)originalImg WithFrame:(CGRect)frame {
    UIImage *croppedImage = nil;
    CGPoint drawPoint = CGPointZero;
    UIGraphicsBeginImageContext(frame.size);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, kCGInterpolationNone);
        CGContextTranslateCTM(context, -frame.origin.x, -frame.origin.y);
        [originalImg drawAtPoint:drawPoint];
        croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return croppedImage;
}

+ (NSString *)getDeviceID {
    static NSString *deviceID;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        deviceID = [TalkingData getDeviceID];
    });
    return deviceID;
}

+ (NSString *)addDebugTitle:(NSString *)orgInfo {
#ifdef DEBUG
    return [NSString stringWithFormat:@"%@ [DEBUG]", orgInfo];
#else
    return orgInfo;
#endif
}

+ (UIViewController *)findViewController:(UIView *)sourceView {
    id target = sourceView;
    while (target) {
        target = ((UIResponder *) target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

+ (UINavigationController *)getRootNav {
    id root = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([root isKindOfClass:[UINavigationController class]]) {
        return root;
    } else {
        return nil;
    }
}
@end
