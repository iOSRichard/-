//
//  MainViewControllerOne.m
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/20.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "MainViewControllerOne.h"
#import "RIPreservableBaseModel.h"

@interface MainViewControllerOne ()

@end

@implementation MainViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dict = @{@"name":@"12",@"age":@(14),@"info":@[@{@"sex":@"男"},@{@"character":@"nice"}]};
    RIPreservableBaseModel *model = [[RIPreservableBaseModel alloc]initModelWithJsonDict:dict];
    
    //NSLog(@"模型描述:%@",model.description);
   
    [RIPreservableBaseModel setObject:model forKey:@"testModel"];
    
    id xxx = [RIPreservableBaseModel objectForKey:@"testModel"];
    
    NSLog(@"获取数据%@",xxx);
    
   
}



@end
