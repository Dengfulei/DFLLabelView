//
//  DFLHttpManager.h
//  afn
//
//  Created by 杭州移领 on 16/4/12.
//  Copyright © 2016年 杭州移领. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void (^DFLDownloadProgress)(NSProgress *progress);
typedef DFLDownloadProgress DFLGetProgress;
typedef DFLDownloadProgress DFLPostProgress;
typedef void (^DFLUploadProgress)(NSProgress *progress);
typedef void (^DFLResponseSuccess)(NSURLSessionDataTask * task,id response);
typedef void (^DFLResponseFail)(NSURLSessionDataTask * task,NSError *error);
@interface DFLHttpManager : NSObject

+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
          progress:(DFLGetProgress)progress
           success:(DFLResponseSuccess)success

              failure:(DFLResponseFail)failure;
+ (void)postWithUrl:(NSString *)url
             params:(NSDictionary *)params
           progress:(DFLPostProgress)progress
            success:(DFLResponseSuccess)success
            failure:(DFLResponseFail)failure;

+ (void)uploadWithImage:(UIImage *)image
                    url:(NSString *)url
               filename:(NSString *)filename
                   name:(NSString *)name
               mimeType:(NSString *)mimeType
             parameters:(NSDictionary *)parameters
               progress:(DFLUploadProgress)progress
                success:(DFLResponseSuccess)success
                failure:(DFLResponseFail)failure;

+ (void)upLaodWithImageArray:(NSArray *)images
                         url:(NSString *)url
                    filename:(NSString *)filename
                        name:(NSString *)name
                    mimeType:(NSString *)mimeType
                  parameters:(NSDictionary *)parameters
                    progress:(DFLUploadProgress)progress
                     success:(DFLResponseSuccess)success
                     failure:(DFLResponseFail)failure;


@end
