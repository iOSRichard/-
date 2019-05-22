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

#pragma mark -- 模型保存在本地
+ (void)setObject:(nullable id)value forKey:(NSString *)key{
    @try {
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@:setObject方法:%@",NSStringFromClass([self class]),exception);
    } @finally {
    }
}

+ (nullable id)objectForKey:(NSString *)key{
    @try {
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        RIPreservableBaseModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return model;
    } @catch (NSException *exception) {
        NSString *exceptionStr = [NSString stringWithFormat:@"%@:setObject方法:%@",NSStringFromClass([self class]),exception];
        return exceptionStr;
        
    } @finally {
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
