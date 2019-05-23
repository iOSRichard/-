//
//  RIPreservableModel.m
//  RIFunctionCollection
//
//  Created by 刘军军 on 2019/5/22.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "RIPreservableBaseModel.h"
#import <objc/runtime.h>

@interface RIPreservableBaseModel()


@end

@implementation RIPreservableBaseModel

- (instancetype)initModelWithJsonDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        
        [self transformDict:dict];
    }
    return self;
}

#pragma mark -- json转model
- (void)transformDict:(NSDictionary *)dict {
    Class cla = self.class;
    // count:成员变量个数
    unsigned int outCount = 0;
    // 获取成员变量数组
    Ivar *ivars = class_copyIvarList(cla, &outCount);
    // 遍历所有成员变量
    for (int i = 0; i < outCount; i++) {
        // 获取成员变量
        Ivar ivar = ivars[i];
        // 获取成员变量名字
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 成员变量名转为属性名（去掉下划线 _ ）
        key = [key substringFromIndex:1];
        // 取出字典的值
        id value = dict[key];
        // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil而报错
        if (value == nil) continue;
        // 利用KVC将字典中的值设置到模型上
        [self setValue:value forKeyPath:key];
    }
    //需要释放指针，因为ARC不适用C函数
    free(ivars);
}

- (NSString *)description{
 
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
   
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList(c, &count);
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            key = [key substringFromIndex:1];
            
            id value = [self valueForKey:key];
            
            [dict setObject:value forKey:key];
        }
        c = [c superclass];
        // 释放内存
        free(ivars);
    }
    
    NSError *error = nil;
    //字典转成json
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted  error:&error];
    //如果报错了就按原先的格式输出
    if (error) {
        return [NSString stringWithFormat:@"%@",dict];
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

#pragma mark -- 解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super init]) {

        Class c = self.class;
        // 截取类和父类的成员变量
        while (c && c != [NSObject class]) {
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList(c, &count);
            for (int i = 0; i < count; i++) {

                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];

                id value = [aDecoder decodeObjectForKey:key];

                [self setValue:value forKey:key];
            }
            // 获得c的父类
            c = [c superclass];
            free(ivars);
        }
    }
    return self;
}

#pragma mark -- 归档
- (void)encodeWithCoder:(NSCoder *)aCoder{

    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;

        Ivar *ivars = class_copyIvarList(c, &count);

        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];

            id value = [self valueForKey:key];

            [aCoder encodeObject:value forKey:key];
        }
        c = [c superclass];
        // 释放内存
        free(ivars);
    }
}

#pragma mark -- 模型保存
+ (void)setModel:(nullable id)value forKey:(NSString *)key{
    @try {
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@:setObject方法:%@",NSStringFromClass([self class]),exception);
    } @finally {
    }
}

#pragma mark -- 获取内存模型
+ (nullable id)modelForKey:(NSString *)key{
    @try {
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        id model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return model;
    } @catch (NSException *exception) {
        NSString *exceptionStr = [NSString stringWithFormat:@"%@:setObject方法:%@",NSStringFromClass([self class]),exception];
        return exceptionStr;
        
    } @finally {
    }
    
}

#pragma mark -- 模型数组保存
+ (void)setModelArray:(NSArray *)value forKey:(NSString *)key{
    NSMutableArray *dataArr = [NSMutableArray array];
    for (id model in value) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [dataArr addObject:data];
    }
    NSUserDefaults *userdafault = [NSUserDefaults standardUserDefaults];
    [userdafault setObject:[NSArray arrayWithArray:dataArr] forKey:key];
    [userdafault synchronize];
}

#pragma mark -- 获取模型数组
+ (nullable id)modelArrayForKey:(NSString *)key{
    NSUserDefaults *userdafault = [NSUserDefaults standardUserDefaults];
    NSArray *dataArr = [userdafault objectForKey:key];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSData *data in dataArr) {
        id model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [arr addObject:model];
    }
    return arr;
}

#pragma mark -- 字典数组转模型数组保存
+ (void)setModelArrayWithArrayDict:(NSArray *)value forKey:(NSString *)key{
    
    NSMutableArray *modelArray = [NSMutableArray array];
    
    for (NSDictionary *dict in value) {
        @try {
            id model = [[self alloc]initModelWithJsonDict:dict];
            
            [modelArray addObject:model];
            
        } @catch (NSException *exception) {
            NSLog(@"%@:setModelArrayWithArrayDict方法:%@",NSStringFromClass([self class]),exception);
        } @finally {
            
            [self setModelArray:modelArray forKey:key];
        }
       
    }
    
    
}

#pragma mark -- 更新模型数据
+ (void)replaceModelData:(NSUInteger)index withObject:(nullable id)value forModelArrayKey:(NSString *)key{
    NSArray *dataArray = [self modelArrayForKey:key];
    NSMutableArray *array = dataArray.mutableCopy;
    NSNumber *num = [NSNumber numberWithUnsignedInteger:index];
    NSInteger integer = [num intValue]+1;
    
    if (integer <= 0) {
        NSLog(@"%@:modifyModelArrayData方法:模型数据为%@",NSStringFromClass([self class]),dataArray);
        return;
    }
    
    if (dataArray.count > 0 && integer <= dataArray.count) {
        [array replaceObjectAtIndex:index withObject:value];
        [self setModelArray:array.copy forKey:key];
    }else{
        NSLog(@"%@:modifyModelArrayData方法:模型数据为%@",NSStringFromClass([self class]),dataArray);
    }
}




//#pragma mark - json转model另外一种方式
//- (void)prepareModel:(NSDictionary *)dict
//{
//    // 储存属性名
//    NSMutableArray *keys = [[NSMutableArray alloc] init];
//
//    // 获取属性名并储存
//    u_int count = 0;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    for (int i = 0; i < count; i ++) {
//        objc_property_t property = properties[i];
//        if (property == NULL) {
//            continue;
//        }
//        const char *propertyCString = property_getName(property);
//        NSString *propertyName = [NSString stringWithCString:propertyCString encoding:NSUTF8StringEncoding];
//            [keys addObject:propertyName];
//    }
//
//    // 释放
//    free(properties);
//
//    // 设置属性值
//    for (NSString *key in keys) {
//        if (dict[key]) {
//            [self setValue:dict[key] forKey:key];
//        }
//    }
//}

//- (void)encodeWithCoder:(NSCoder*)coder {
//
//     [coder encodeObject:self.keyArray forKey:@"keyArray"];
//     [coder encodeObject:self.valueArray forKey:@"valueArray"];
//     [coder encodeObject:self.name forKey:@"name"];
//     [coder encodeInteger:self.age forKey:@"age"];
//     [coder encodeObject:self.info forKey:@"info"];
//
//}

//- (id)initWithCoder:(NSCoder*)decoder {
//    if (self = [super init]) {
//        if (decoder == nil) {
//            return self;
//        }
//
//         self.keyArray = [decoder decodeObjectForKey:@"keyArray"];
//         self.valueArray = [decoder decodeObjectForKey:@"valueArray"];
//         self.name = [decoder decodeObjectForKey:@"name"];
//         self.age = [decoder decodeIntegerForKey:@"age"];
//         self.info = [decoder decodeObjectForKey:@"nainfome"];
//
//    }
//    return self;
//}



@end
