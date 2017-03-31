# SFJNetworkDemo
二次封装AFNetworking
 
 
 > 方便使用af 封装了post get 以及上传，下载文件的方法。
 ```Objective-c
 + (instancetype)shareTool;

/** 取消所有网络请求 */
+ (void)cancelAllOperations;

/**
 *  检测网络状态
 */
+ (void)checkingNetworkResult:(void (^)(AFNetworkReachabilityStatus))result;

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id data))success
     failure:(void (^)(NSError *error))failure;
     
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id data))success
    failure:(void (^)(NSError * error))failure;

- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
        Data:(NSData *)fileData
   FieldName:(NSString *)fieldName
    FileName:(NSString *)fileName
    MimeType:(NSString *)mimeType
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure;

// 其中该方法未类方法，url为整体包括ip 端口、、、
+ (void)downloadFileWithUrl:(NSString *)url
                         Parameter:(NSDictionary *)patameter
                         SavedPath:(NSString *)savedPath
                          Complete:(void (^)(NSData *data, NSError *error))complete
                          Progress:(void (^)(id downloadProgress, double currentValue))progress;
```

