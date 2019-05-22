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

@property (nonatomic, strong)NSString *name;
@property (nonatomic, assign)NSInteger age;
@property (nonatomic, strong)NSArray *info;

- (instancetype)initModelWithJsonDict:(NSDictionary *)dict;

+ (void)setObject:(nullable id)value forKey:(NSString *)key;

+ (nullable id)objectForKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
