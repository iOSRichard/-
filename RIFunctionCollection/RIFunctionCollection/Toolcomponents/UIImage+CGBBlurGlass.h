//
//  UIImage+CGBBlurGlass.h
//  CGBCredit
//
//  Created by 刘军军 on 2019/1/17.
//  Copyright © 2019 ynet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CGBBlurGlass)

- (UIImage *)imgWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;
- (UIImage *)imgWithBlur;

@end
