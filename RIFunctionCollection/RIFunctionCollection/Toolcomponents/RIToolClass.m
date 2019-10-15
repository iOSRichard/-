//
//  RIToolClass.m
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/22.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "RIToolClass.h"
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <sys/utsname.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@implementation RIToolClass

#pragma mark --是否iPhoneX系列
+ (BOOL)isIPhoneXSeries{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    // 第一种
    if ([UIApplication sharedApplication].statusBarFrame.size.height > 44) {
        iPhoneXSeries = YES;
    }
    // 第二种
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0 || mainWindow.safeAreaInsets.left > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}

#pragma mark --获取手机型号
+(NSString *)getIphoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    //NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone9,1"] || [platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"] || [platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"]|| [platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    
    return platform;
}


#pragma mark --定位是否允许
+ (BOOL)authPermission{
    
    if (![CLLocationManager locationServicesEnabled]){
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView * positioningAlertivew = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"打开“定位服务”来允许发现精彩确认您的位置" delegate:self cancelButtonTitle:@"设置" otherButtonTitles:@"取消",nil];
            [positioningAlertivew show];
        });
        
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView * positioningAlertivew = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"发现精彩需要使用您的位置权限，请在系统设置中授权" delegate:self cancelButtonTitle:@"设置" otherButtonTitles:@"取消",nil];
            [positioningAlertivew show];
        });
        
        
    }else{
        
        return YES;
        
    }
    
    return NO;
}

#pragma mark --获取到当前所在的视图
+ (UIViewController *)currentPresentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
//    if ([result isKindOfClass:[DFNavigationController class]]) {
//        NSArray *items = result.childViewControllers;
//        if (items && items.count > 0) {
//            result = (DFNavigationController *)result.childViewControllers[0];
//        }
//
//    }
//
//    if ([result isKindOfClass:[CGBTabBarController class]]) {
//        result = [(CGBTabBarController *)result selectedViewController];
//    }
//    if ([result isKindOfClass:[UINavigationController class]]) {
//        result = [(UINavigationController *)result topViewController];
//        if ([result isKindOfClass:[CGBTabBarController class]]) {
//            result = [(CGBTabBarController *)result selectedViewController];
//        }
//
//    }
  
    return result;
}






@end
