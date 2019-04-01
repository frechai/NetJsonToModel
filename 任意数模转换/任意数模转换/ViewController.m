//
//  ViewController.m
//  任意数模转换
//
//  Created by frechai on 2019/4/1.
//  Copyright © 2019 frechai. All rights reserved.
//

#import "ViewController.h"
#import "ModelInterface.h"
#import "NetHelper.h"
@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,strong)UITableView *tab;
@end

@implementation ViewController
-(NSMutableArray*)arr
{
    if (_arr ==nil) {
        _arr =[[NSMutableArray alloc]    init];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//不带参数的
-(void)network1
{
    Model_contacts_DropStudent_Req *model_contacts_DropStudent_Req =[[Model_contacts_DropStudent_Req alloc] init];
    Model_contacts_DropStudent_Rsp *model_contacts_DropStudent_Rsp =[[Model_contacts_DropStudent_Rsp alloc] init];
    [NetHelper netRequestPostParameters:model_contacts_DropStudent_Req RespondParameters:model_contacts_DropStudent_Rsp CallBack:^(BOOL netIsWork, NSString * _Nonnull errorStr) {
        //这里不用做任何数据转模型的处理// 直接使用定义的格式即可 数组，字典都可以
//        比如响应的数组
        [self.arr addObjectsFromArray:model_contacts_DropStudent_Rsp.data];
        [self.tab reloadData];
        
    }];
    

}
//带参数的
-(void)network2
{
    //请求
//    @interface Model_contacts_batchDropStudent_Req : Model_Req
//    @property (nonatomic,assign)NSInteger state ;//状态: 0：正常 1：毕业 2：退学 3：删除'
//    @property (nonatomic,strong) NSMutableArray *csid ;// 学生ID集合 ,
//    @end
//    //应答
//    @interface Model_contacts_batchDropStudent_Rsp : Model_Rsp
//    @end
    
    Model_contacts_batchDropStudent_Req *model_contacts_batchDropStudent_Req =[[Model_contacts_batchDropStudent_Req alloc] init];
    model_contacts_batchDropStudent_Req.state =1;
    model_contacts_batchDropStudent_Req.csid =[[NSMutableArray alloc] init];
    [model_contacts_batchDropStudent_Req.csid addObjectsFromArray:@[@"111",@"222",@"333"]];
    Model_contacts_batchDropStudent_Rsp *model_contacts_batchDropStudent_Rsp =[[Model_contacts_batchDropStudent_Rsp alloc] init];
    [NetHelper netRequestPostParameters:model_contacts_batchDropStudent_Req RespondParameters:model_contacts_batchDropStudent_Rsp CallBack:^(BOOL netIsWork, NSString * _Nonnull errorStr) {
        //network==200 那就是网络返回成功 error为服务器返回的错误或者没有网的提示错误
        if (netIsWork) {
            NSLog(@"网络返回成功200");
//        那就是   model_contacts_batchDropStudent_Rsp.responseCode=200;
           
        }
        else
        {
            NSLog(@"错误信息为%@",errorStr);
        }
        
    }];
    
    
}

-(void)network3
{
#pragma mark /contacts/getClassDetailByCid 
  /*  @protocol Model_contacts_getClassDetailByCid_data_teacherVos @end
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
   
   */
    
    Model_contacts_getClassDetailByCid_Req *model_contacts_getClassDetailByCid_Req =[[Model_contacts_getClassDetailByCid_Req alloc] init];
    model_contacts_getClassDetailByCid_Req.cid =@"2";
    Model_contacts_getClassDetailByCid_Rsp *model_contacts_getClassDetailByCid_Rsp =[[Model_contacts_getClassDetailByCid_Rsp alloc] init];
    [NetHelper netRequestPostParameters:model_contacts_getClassDetailByCid_Req RespondParameters:model_contacts_getClassDetailByCid_Rsp CallBack:^(BOOL netIsWork, NSString * _Nonnull errorStr) {
        
        if (netIsWork) {
           //这里直接使用响应model即可 比如
            Model_contacts_getClassDetailByCid_data *respondmodel= model_contacts_getClassDetailByCid_Rsp.data;
            NSLog(@"%@==%@ %@===%@",respondmodel.cid,model_contacts_getClassDetailByCid_Rsp.data.cid,respondmodel.cname,model_contacts_getClassDetailByCid_Rsp.data.cname);
            //或者取响应的数组
           [self.arr addObjectsFromArray:model_contacts_getClassDetailByCid_Rsp.data.teacherVos];
            [self.tab reloadData];
            
            
            
        }
        else
        {
            NSLog(@"errorstr==%@",errorStr);
        }
        
    }];
 
    
}


@end
