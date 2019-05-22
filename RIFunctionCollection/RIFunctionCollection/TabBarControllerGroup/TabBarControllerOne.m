//
//  TabBarControllerOne.m
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/20.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "TabBarControllerOne.h"

@interface TabBarControllerOne ()

// 用于保存添加的视图控制器
@property (nonatomic, strong)NSMutableArray *vcArray;

@end

@implementation TabBarControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 重写init方法
- (instancetype)init{
    if (self = [super init]) {
        // 初始化数组
        _vcArray = [NSMutableArray array];
    }
    return self;
}

- (void)createTabBarOneType{
    
    [self addViewControllerWithParams:@{@"className":@"MainViewControllerOne",
                                        @"navigationTitle":@"MainOneVC",
                                        @"tabBarTitle":@"首页",
                                        @"image":@"home_icon",
                                        @"selectedImage":@"homeselet_icon"}];
    
    [self addViewControllerWithParams:@{@"className":@"MainViewControllerTwo",
                                        @"navigationTitle":@"MainTwoVC",
                                        @"tabBarTitle":@"收入",
                                        @"image":@"salaryh_icon",
                                        @"selectedImage":@"salaryselet_icon"}];
    
    [self addViewControllerWithParams:@{@"className":@"MainViewControllerThird",
                                        @"navigationTitle":@"MainThirdVC",
                                        @"tabBarTitle":@"金融",
                                        @"image":@"financing_icon",
                                        @"selectedImage":@"financingselet_icon"}];
    
    [self addViewControllerWithParams:@{@"className":@"MainViewControllerFourth",
                                        @"navigationTitle":@"MainFourthVC",
                                        @"tabBarTitle":@"生活",
                                        @"image":@"live_icon",
                                        @"selectedImage":@"liveselet_icon"}];
    
    [self addViewControllerWithParams:@{@"className":@"MainViewControllerFifth",
                                        @"navigationTitle":@"MainFifthVC",
                                        @"tabBarTitle":@"我的",
                                        @"image":@"mine_icon",
                                        @"selectedImage":@"mineselet_icon"}];
    
}

- (void)addViewControllerWithParams:(NSDictionary *)params{
    NSString *className = params[@"className"];
    id vc = [[NSClassFromString(className) alloc]init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        UIViewController *tempVC = vc;

        tempVC.navigationItem.title = params[@"navigationTitle"];
        tempVC.tabBarItem.title = params[@"tabBarTitle"];
        tempVC.tabBarItem.image = [UIImage imageNamed:params[@"image"]?:@""];
        tempVC.tabBarItem.selectedImage = [UIImage imageNamed:params[@"selectedImage"]?:@""];
       
        
        UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:tempVC];
        
        [_vcArray addObject:unc];
        
        //添加viewControles这个数组中
         self.viewControllers = _vcArray;
        
    }else{
        NSLog(@"NSClassFromStrings失败");
    }
}





@end
