//
//  ModelInterface.h
//  任意数模转换
//
//  Created by frechai on 2019/4/1.
//  Copyright © 2019 frechai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface ModelInterface : NSObject
+ (NSString*)getName;
@end

#pragma mark MODEL基类
@interface Model_Base : JSONModel
- (void)dump;//用于打印各个model
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
//////////////////////////////////////////////////////////////////////
#pragma mark 接口MODEL基类
@interface Model_Interface : Model_Base
@end

////////////////////////////////////////////
#pragma mark 请求消息基类,带参数account_id、timestamp、sign
@interface Model_Req : Model_Interface

@end
//////////////////////////////////////////////////////////////////////////////
#pragma mark 应答消息基类
@interface Model_Rsp : Model_Interface
@property int responseCode;//返回代码
@property(nonatomic, copy)NSString *responseMessage;//提示信息
@end
/////////////////////////////
/////////////////////////////



//举例说明1（无参数的）
#pragma mark /contacts/DropStudent/
@protocol Model_contacts_DropStudent_data
@end
@interface Model_contacts_DropStudent_data : Model_Interface
@property(nonatomic,strong)NSString *classname;
@property(nonatomic,strong)NSString *classid;
@end
//请求
@interface Model_contacts_DropStudent_Req : Model_Req
@end
//应答
@interface Model_contacts_DropStudent_Rsp : Model_Rsp
@property (nonatomic,strong)NSArray <Model_contacts_DropStudent_data> *data;//响应数据为数组
@end
//举例说明2 （有参数的）
#pragma mark /contacts/batchDropStudent/
//请求
@interface Model_contacts_batchDropStudent_Req : Model_Req
@property (nonatomic,assign)NSInteger state ;//状态: 0：正常 1：毕业 2：退学 3：删除'
@property (nonatomic,strong) NSMutableArray *csid ;// 学生ID集合 ,
@end
//应答
@interface Model_contacts_batchDropStudent_Rsp : Model_Rsp
//响应除了基类字段w没有别的
@end
////////////////////////////////////////
//举例说明3 （多层级数据响应格式）
#pragma mark /contacts/getClassDetailByCid 根据班级ID查询班级详情
@protocol Model_contacts_getClassDetailByCid_data_teacherVos @end
@interface Model_contacts_getClassDetailByCid_data_teacherVos : Model_Interface
@property (nonatomic,strong)NSString *tid ;// 教师ID ,
@property (nonatomic,strong)NSString *tname ;// 教师名称
@end
@interface Model_contacts_getClassDetailByCid_data : Model_Interface
@property (nonatomic,strong)NSString *cid ;// 班级ID ,
@property (nonatomic,strong)NSString *cname ;// 班级名称 ,
@property (nonatomic,strong)NSArray <Model_contacts_getClassDetailByCid_data_teacherVos>*teacherVos;//字典内包含的数组格式
@end
//请求
@interface Model_contacts_getClassDetailByCid_Req : Model_Req
@property (nonatomic,strong)NSString *cid ;//班级id ,
@end
//应答
@interface Model_contacts_getClassDetailByCid_Rsp : Model_Rsp
@property (nonatomic,strong)Model_contacts_getClassDetailByCid_data *data;//响应为一个字典格式（字典内数据个数包含数组）
@end

NS_ASSUME_NONNULL_END
