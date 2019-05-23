//
//  UserInfoModel.h
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/23.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "RIPreservableBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : RIPreservableBaseModel

@property (nonatomic, strong)NSString *name;
@property (nonatomic, assign)NSInteger age;
@property (nonatomic, strong)NSArray *info;

@end

NS_ASSUME_NONNULL_END
