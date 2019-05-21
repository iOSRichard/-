//
//  TabBarControllerOne.h
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/20.
//  Copyright © 2019 Richard. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabBarControllerOne : UITabBarController

/** 添加视图控制器*/
- (void)addViewControllerWithParams:(NSDictionary *)params;

- (void)createTabBarOneType;

@end

NS_ASSUME_NONNULL_END