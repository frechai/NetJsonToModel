//
//  ModelInterface.m
//  任意数模转换
//
//  Created by frechai on 2019/4/1.
//  Copyright © 2019 frechai. All rights reserved.
//

#import "ModelInterface.h"

@implementation ModelInterface
+ (NSString*)getName{
    return @"InterfaceBase";
}
@end
@implementation Model_Base

- (void)dump{
    NSLog(@"%@", self);
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSString *msg = [NSString stringWithFormat:@"接口数据Model类:%@ 未发现:%@字段，需要检查接口定义", [self class], key];
    NSLog(@"%@", msg);
}

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end

@implementation Model_Interface

@end

@implementation Model_Req
@end

@implementation Model_Rsp @end
/////////////////////////

@implementation Model_contacts_DropStudent_data
@end
//请求
@implementation Model_contacts_DropStudent_Req
@end
//应答
@implementation Model_contacts_DropStudent_Rsp 
@end
//////////////////////////////////
//请求
@implementation Model_contacts_batchDropStudent_Req
@end
//应答
@implementation Model_contacts_batchDropStudent_Rsp
@end
////////////////////////
#pragma mark /contacts/getClassDetailByCid 根据班级ID查询班级详情
@implementation Model_contacts_getClassDetailByCid_data_teacherVos
@end
@implementation Model_contacts_getClassDetailByCid_data
@end
//请求
@implementation Model_contacts_getClassDetailByCid_Req
@end
//应答
@implementation Model_contacts_getClassDetailByCid_Rsp
@end
////////////////////////////
