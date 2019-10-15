//
//  RIToolClass.h
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/22.
//  Copyright © 2019 Richard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface RIToolClass : NSObject
//获取到当前所在的视图
+ (UIViewController *)currentPresentingVC;
//定位是否允许
+ (BOOL)authPermission;
//获取手机型号
+(NSString *)getIphoneType;
//是否iPhoneX系列
+ (BOOL)isIPhoneXSeries;





@end

NS_ASSUME_NONNULL_END
