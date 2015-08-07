//
//  RESTEngine.m
//

#import "RESTEngine.h"
#import "AFNetworking.h"

@implementation RESTEngine

+ (instancetype)sharedManager
{
    static id sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id) init
{
    self = [super init];
  
     NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.allowsCellularAccess = NO;
    sessionConfiguration.URLCache = [NSURLCache sharedURLCache]; // NEW LINE ON TOP OF OTHERWISE WORKING CODE
    sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;//NSURLRequestReturnCacheDataElseLoad;  // NEW LINE ON TOP OF OTHERWISE WORKING CODE
    
    sessionManager_ = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    sessionManager_.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    return self;
}

#pragma mark -
#pragma mark 网络请求

- (void) sendRequest:(NSString*)url
             setBody:(NSDictionary*)body
         finishBlock:(void (^)(NSString* request))completionHandler
           failBlock:(void (^)(NSString* request))faileHandler
              isPost:(Boolean)isPost
{

    static int count = 1;
    if (isPost) {
        [self sendRequest:url
                 postBody:body
              finishBlock:completionHandler
                failBlock:faileHandler];
    }
}


//发送一个 post
- (void) sendRequest:(NSString*)url
            postBody:(NSDictionary*)postBody
         finishBlock:(void (^)(NSString* request))completionHandler
           failBlock:(void (^)(NSString* request))failedHandler
{
   url = ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, ( CFStringRef)url, nil, CFSTR(""), kCFStringEncodingUTF8));
   
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                 URLString:url
                                                                                parameters:postBody
                                                                                     error:nil];
    
    NSLog(@"DiskCache: %@ of %@", @([[NSURLCache sharedURLCache] currentDiskUsage]), @([[NSURLCache sharedURLCache] diskCapacity]));
    NSLog(@"MemoryCache: %@ of %@", @([[NSURLCache sharedURLCache] currentMemoryUsage]), @([[NSURLCache sharedURLCache] memoryCapacity]));
    
    
    NSURLSessionDataTask *dataTask = [sessionManager_ dataTaskWithRequest:request
                                                        completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                            
                                                            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                            NSLog(@"response:%@",str);
                                                        }];
    
    [dataTask resume];
}

@end
