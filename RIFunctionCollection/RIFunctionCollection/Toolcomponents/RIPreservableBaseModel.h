//
//  RIPreservableModel.h
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/22.
//  Copyright © 2019 Richard. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RIPreservableBaseModel : NSObject

//@property (nonatomic, strong)NSString *name;
//@property (nonatomic, assign)NSInteger age;
//@property (nonatomic, strong)NSArray *info;

- (instancetype)initModelWithJsonDict:(NSDictionary *)dict;

//模型保存
+ (void)setModel:(nullable id)value forKey:(NSString *)key;

//获取内存模型
+ (nullable id)modelForKey:(NSString *)key;

//模型数组保存
+ (void)setModelArray:(nullable id)value forKey:(NSString *)key;

//获取模型数组
+ (nullable id)modelArrayForKey:(NSString *)key;

//字典数组转模型数组保存
+ (void)setModelArrayWithArrayDict:(NSArray *)value forKey:(NSString *)key;

//更新模型数据
+ (void)replaceModelData:(NSUInteger)index withObject:(nullable id)value forModelArrayKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
