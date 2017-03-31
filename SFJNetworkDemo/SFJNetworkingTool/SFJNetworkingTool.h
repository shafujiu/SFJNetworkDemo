//
//  SFJNetworkingManager.h
//  SFJNetworkDemo
//
//  Created by 沙缚柩 on 2017/3/30.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//  https://github.com/shafujiu/SFJNetworkDemo.git

#import <AFNetworking/AFNetworking.h>

@interface SFJNetworkingTool : AFHTTPSessionManager

+ (instancetype)shareTool;

/** 取消所有网络请求 */
+ (void)cancelAllOperations;

/**
 *  检测网络状态
 */
+ (void)checkingNetworkResult:(void (^)(AFNetworkReachabilityStatus))result;

/**
 *  POST
 *
 *  @param URLString    url
 *  @param parameters   请求参数
 *  @param success      成功回调
 *  @param failure      失败回调
 */
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id data))success
     failure:(void (^)(NSError *error))failure;

/**
 *  GET
 *
 *  @param URLString    url
 *  @param parameters   请求参数
 *  @param success      成功的回调
 *  @param failure      失败的回调
 */
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id data))success
    failure:(void (^)(NSError * error))failure;


/**
 *  向服务器上传文件
 *
 *  @param url       要上传的文件接口
 *  @param parameter 上传的参数
 *  @param fileData  上传的文件\数据
 *  @param fieldName 服务对应的字段
 *  @param fileName  上传到时服务器的文件名
 *  @param mimeType  上传的文件类型
 *  @param success   成功执行，block的参数为服务器返回的内容
 *  @param failure   执行失败，block的参数为错误信息
 */
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
        Data:(NSData *)fileData
   FieldName:(NSString *)fieldName
    FileName:(NSString *)fileName
    MimeType:(NSString *)mimeType
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure;

/**
 *  下载文件  注意使用的是完整的url 
 *
 *  @param url       下载地址 完整的url
 *  @param patameter 下载参数
 *  @param savedPath 保存路径
 *  @param complete  下载成功返回文件：NSData
 *  @param progress  设置进度条的百分比：progressValue
 */
+ (void)downloadFileWithUrl:(NSString *)url
                         Parameter:(NSDictionary *)patameter
                         SavedPath:(NSString *)savedPath
                          Complete:(void (^)(NSData *data, NSError *error))complete
                          Progress:(void (^)(id downloadProgress, double currentValue))progress;



@end
