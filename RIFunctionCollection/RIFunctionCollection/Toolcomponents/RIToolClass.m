//
//  RIToolClass.m
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/22.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "RIToolClass.h"

@implementation RIToolClass

#pragma mark --  获取到当前所在的视图
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
