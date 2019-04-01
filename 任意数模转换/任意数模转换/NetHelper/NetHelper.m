//
//  NetHelper.m
//  任意数模转换
//
//  Created by frechai on 2019/4/1.
//  Copyright © 2019 frechai. All rights reserved.
//

#import "NetHelper.h"
#import <AFNetworking.h>
#import "ModelInterface.h"
@implementation NetHelper
+(void)netRequestPostParameters:(id)reqPar RespondParameters:(id)rspPar CallBack:(void(^)(BOOL netIsWork,NSString *errorStr))callBack
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //通过model拼接url
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",@"www.xxxxx", [[NSStringFromClass([reqPar class]) substringWithRange:NSMakeRange(6, NSStringFromClass([reqPar class]).length-10)] stringByReplacingOccurrencesOfString:@"_" withString:@"/"]];
    __block id rsp =rspPar;
    
    [manager POST:baseUrl parameters:[reqPar toDictionary] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //网络获取数据成功
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        rsp = [rsp initWithString : jsonStr error : nil];
    NSLog(@"当前的请求接口====%@,当前请求参数为===%@，当前接口的响应数据======%@",baseUrl,[reqPar toJSONString],jsonStr);
        Model_Rsp *rspBase = (Model_Rsp*)rsp;
        if (rspBase.responseCode==200) {
            if (callBack) {
                callBack(YES,rspBase.responseMessage);
            }
        }
        else
        {
            if (callBack) {
                callBack(NO,rspBase.responseMessage);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callBack) {
            callBack(NO,@"当前服务器开了点小岔");
        }
    }];
    
    
}

@end
