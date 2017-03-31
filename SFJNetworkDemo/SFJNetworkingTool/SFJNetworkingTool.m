//
//  SFJNetworkingManager.m
//  SFJNetworkDemo
//
//  Created by 沙缚柩 on 2017/3/30.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "SFJNetworkingTool.h"

static NSString *const SFJBaseUrl = @"";

@implementation SFJNetworkingTool

+ (instancetype)shareTool{
    static SFJNetworkingTool *manager_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager_ = [[self alloc] initWithBaseURL:[NSURL URLWithString:SFJBaseUrl]];
        // 接受文件的类型
        manager_.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
        manager_.requestSerializer  = [AFJSONRequestSerializer serializer];
        manager_.responseSerializer = [AFJSONResponseSerializer serializer];
        
    });
    return manager_;
}

+ (void)cancelAllOperations{
    [[[self shareTool] operationQueue] cancelAllOperations];
}

/**
 *   监听网络状态的变化
 */
+ (void)checkingNetworkResult:(void (^)(AFNetworkReachabilityStatus))result {
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        !result ? : result(status);
    }];
}

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id data))success
     failure:(void (^)(NSError *error))failure{
    
    [self POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}


- (void)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(id data))success
                      failure:(void (^)(NSError * error))failure{
    [self GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}
// 上传
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
        Data:(NSData *)fileData
   FieldName:(NSString *)fieldName
    FileName:(NSString *)fileName
    MimeType:(NSString *)mimeType
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure{
    [self POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:fieldName fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

// 下载
+ (void)downloadFileWithUrl:(NSString *)url
                  Parameter:(NSDictionary *)patameter
                  SavedPath:(NSString *)savedPath
                   Complete:(void (^)(NSData *data, NSError *error))complete
                   Progress:(void (^)(id downloadProgress, double currentValue))progress{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //AFN3.0URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        double progressValue = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        if (progress) progress(downloadProgress, progressValue);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        
        return [NSURL fileURLWithPath:savedPath != nil ? savedPath : path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        // filePath就是下载文件的位置，可以直接拿来使用
        NSData *data;
        if (!error) {
            data = [NSData dataWithContentsOfURL:filePath];
            NSLog(@"下载地址:%@",filePath);
        }
        if (complete) complete(data, error);
    }];
    
    //默认下载操作是挂起的，须先手动恢复下载。
    [downloadTask resume];
}




@end
