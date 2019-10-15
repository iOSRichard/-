//
//  CGBScreenBlurry.h
//  CGBCredit
//
//  Created by 刘军军 on 2019/1/17.
//  Copyright © 2019 ynet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGBScreenBlurry : NSObject

+ (void)addBlurryScreenImage;       //从后台进入前台添加模糊效果

+ (void)removeBlurryScreenImage;    //进入前台后去除模糊效果

@end
