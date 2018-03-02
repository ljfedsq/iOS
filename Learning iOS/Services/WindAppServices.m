//
//  WindAppServices.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/11.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "WindAppServices.h"


@implementation WindAppServices

-(void)onLoginServicesWithUser:(NSString *)strusername
                        AndPsd:(NSString *)password
                 AndDomainCode:(NSString *)domainCode
               blockWithSucces:(void (^)(NSArray *dataArray))success
                       failure:(void (^)(NSString *errorStr))failure{
    ServiceBase * serviceBase = [[ServiceBase alloc]init];
    NSString *url = @"https://eos.envisioncn.com/hmi/rest/map/login?need_refresh_token=true";
    NSDictionary *parameters =@{@"username":strusername,@"password":password,@"domainCode":domainCode};
    [[serviceBase sharedManager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //返回请求进度
        NSLog(@"dowbloadProgress-->%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功 根据responseSerializer返回不同的数据格式
        NSLog(@"responseObject-->%@",responseObject);
        id flag = [responseObject valueForKey:@"code"];
        NSString *flagStr = [NSString stringWithFormat:@"%@",flag];
        if([flagStr isEqualToString:@"10000"]){
             success(nil);
        }else{
            NSString *str = [responseObject valueForKey:@"message"];
            failure(str);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"error-->%@",error);
        failure([error localizedDescription]);
    }];
}
@end
