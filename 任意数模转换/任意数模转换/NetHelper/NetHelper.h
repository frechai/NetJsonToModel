//
//  NetHelper.h
//  任意数模转换
//
//  Created by frechai on 2019/4/1.
//  Copyright © 2019 frechai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetHelper : NSObject
+(void)netRequestPostParameters:(id)reqPar RespondParameters:(id)rspPar CallBack:(void(^)(BOOL netIsWork,NSString *errorStr))callBack;

@end

NS_ASSUME_NONNULL_END
