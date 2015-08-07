//
//  RESTEngine.h
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface RESTEngine : NSObject {
    AFURLSessionManager *sessionManager_;
}

+ (instancetype)sharedManager;

- (id) init;

- (void) sendRequest:(NSString*)url
             setBody:(NSDictionary*)body
         finishBlock:(void (^)(NSString* request))completionHandler
           failBlock:(void (^)(NSString* request))faileHandler
              isPost:(Boolean)isPost;


@end
