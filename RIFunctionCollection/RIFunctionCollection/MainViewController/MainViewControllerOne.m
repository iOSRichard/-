//
//  MainViewControllerOne.m
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/20.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "MainViewControllerOne.h"
#import "RIPreservableBaseModel.h"
#import "UserInfoModel.h"

@interface MainViewControllerOne ()

@end

@implementation MainViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dict1 = @{@"name":@"12",@"age":@(14),@"info":@[@{@"sex":@"男"},@{@"character":@"nice"}]};
    NSDictionary *dict2 = @{@"name":@"13",@"age":@(15),@"info":@[@{@"sex":@"女"},@{@"character":@"good"}]};
    
    NSArray *array = @[dict1,dict2];
    
//    [RIPreservableBaseModel setModelArrayWithArrayDict:array forKey:@"UserArrayDict"];
//
//    NSArray *xxx = [RIPreservableBaseModel modelArrayForKey:@"UserArrayDict"];
//
//    NSLog(@"获取数据%@",xxx[1]);
    
    
    [UserInfoModel setModelArrayWithArrayDict:array forKey:@"UserArrayDict"];

   
     NSDictionary *dict3 = @{@"name":@"14",@"age":@(16),@"info":@[@{@"sex":@"男"},@{@"character":@"bad"}]};
    
    UserInfoModel *model = [[UserInfoModel alloc]initModelWithJsonDict:dict3];
    
    [UserInfoModel replaceModelData:-1 withObject:model forModelArrayKey:@"UserArrayDict"];
    
     NSArray *xxx = [UserInfoModel modelArrayForKey:@"UserArrayDict"];

     NSLog(@"获取数据%@",xxx[1]);

    
    
//    NSMutableArray *modelArray = [NSMutableArray array];
//
//    for (NSDictionary *dict in array) {
//        RIPreservableBaseModel *model = [[RIPreservableBaseModel alloc]initModelWithJsonDict:dict];
//        [modelArray addObject:model];
//    }
//
//    [RIPreservableBaseModel setModelArray:modelArray forKey:@"testModelArray"];
//
//     NSArray *xxx = [RIPreservableBaseModel modelArrayForKey:@"testModelArray"];
//
//    NSLog(@"获取数据%@",xxx[1]);
    
    
//    RIPreservableBaseModel *model = [[RIPreservableBaseModel alloc]initModelWithJsonDict:dict];
    
//    NSLog(@"模型描述:%@",model.description);
   
//    [RIPreservableBaseModel setObject:model forKey:@"testModel"];
//
//    id xxx = [RIPreservableBaseModel objectForKey:@"testModel"];
//
//    NSLog(@"获取数据%@",xxx);
    
    
    
   
}



@end
