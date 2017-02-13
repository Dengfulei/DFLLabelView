//
//  DFLHttpManager.m
//  afn
//
//  Created by 杭州移领 on 16/4/12.
//  Copyright © 2016年 杭州移领. All rights reserved.
//

#import "DFLHttpManager.h"

@interface DFLHttpManager ()
@property (nonatomic , strong) NSURLSessionDataTask *task;

@end



@implementation DFLHttpManager

+ (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置接受类型参数
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/html",
                                                         @"text/json",
                                                         @"text/plain",
                                                         @"text/javascript",
                                                         @"text/xml",
                                                         @"image/*",
                                                         nil];
    return manager;
}

+ (void)getWithUrl:(NSString *)url  params:(NSDictionary *)params progress:(DFLGetProgress)progress success:(DFLResponseSuccess)success failure:(DFLResponseFail)failure {
    [self getCommonHttphandlerWithUrlString:url Params:params progressBlock:progress responeSuccess:success failure:failure];
   
}

+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params progress:(DFLPostProgress)progress success:(DFLResponseSuccess)success failure:(DFLResponseFail)failure {
    [self postCommonHttphandlerWithUrlString:url Params:params progressBlock:progress responeSuccess:success failure:failure];
}


+ (void)uploadWithImage:(UIImage *)image
                    url:(NSString *)url
               filename:(NSString *)filename
                   name:(NSString *)name
               mimeType:(NSString *)mimeType
             parameters:(NSDictionary *)parameters
               progress:(DFLUploadProgress)progress
                success:(DFLResponseSuccess)success
                   failure:(DFLResponseFail)failure {
    AFHTTPSessionManager *manager = [self manager];
     NSURLSessionTask *session =  [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSString *str = [ NSString stringWithFormat:@"%.0lf",(double)[[NSDate date] timeIntervalSince1970]*10000000];
            imageFileName = [NSString stringWithFormat:@"%@.jpg",str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successRespone:responseObject successBlock:success task:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [self failResult:error failBlock:failure task:task];
    }];
    [session resume];
}

+ (void)upLaodWithImageArray:(NSArray *)images
                         url:(NSString *)url
                    filename:(NSString *)filename
                        name:(NSString *)name
                    mimeType:(NSString *)mimeType
                  parameters:(NSDictionary *)parameters
                    progress:(DFLUploadProgress)progress
                     success:(DFLResponseSuccess)success
                     failure:(DFLResponseFail)failure {
    if (!images.count) return ;
    AFHTTPSessionManager *manager = [self manager];
    NSURLSessionTask *session =  [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < images.count; i++) {
            NSData *imageData = UIImageJPEGRepresentation(images[i], 0.5);
            NSString *imageFileName = filename;
            if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
               
                imageFileName = [NSString stringWithFormat:@"%ld.jpg",(long)i];
            }
            // 上传图片，以文件流的格式
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:imageFileName
                                    mimeType:mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successRespone:responseObject successBlock:success task:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failResult:error failBlock:failure task:task];
    }];
    [session resume];

}


+ (void)getCommonHttphandlerWithUrlString:(NSString *)urlString
                                   Params:(NSDictionary *)params
                            progressBlock:(DFLGetProgress)progress
                           responeSuccess:(DFLResponseSuccess)success
                              failure:(DFLResponseFail)failure {
    AFHTTPSessionManager *manager = [self manager];

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    [securityPolicy setValidatesDomainName:YES];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successRespone:responseObject successBlock:success task:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failResult:error failBlock:failure task:task];
    }];
    
}

+ (void)postCommonHttphandlerWithUrlString:(NSString *)urlString
                                    Params:(NSDictionary *)params
                             progressBlock:(DFLGetProgress)progress
                            responeSuccess:(DFLResponseSuccess)success
                               failure:(DFLResponseFail)failure {
    AFHTTPSessionManager *manager = [self manager];
    [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successRespone:responseObject successBlock:success task:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failResult:error failBlock:failure task:task];
    }];

}


+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        } else {
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization
                                      JSONObjectWithData:responseData
                                      options:NSJSONReadingMutableContainers
                                      error:&error];
            
            if (error != nil) {
                return responseData;
            } else {
                return response;
            }
        }
    } else {
        return responseData;
    }
}

+ (void)successRespone:(id)responeObject successBlock:(DFLResponseSuccess)success task:(NSURLSessionDataTask *)task {
    if (success) {
        success(task,[self tryToParseData:responeObject]);
    }
}

+ (void)failResult:(NSError *)error failBlock:(DFLResponseFail)fail task:(NSURLSessionDataTask *)task{
    if (fail) {
        fail(task,error);
    }
}

@end
