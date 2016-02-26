//
//  AppManager.h
//  Vanity
//
//  Created by Alex Lee on 7/4/15.
//  Copyright (c) 2015 egon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AppManager : NSObject

+ (instancetype)sharedManager;
- (void)httpRequest:(NSString*)_urlString params:(NSDictionary *)_params
            success:(void (^)(id))_success
            failure:(void (^)(NSError *))_failure
;

- (void)httpRequest:(NSString*)_urlString params:(NSDictionary *)_params
             avatar:(NSData *)_avatar
            success:(void (^)(id))_success
            failure:(void (^)(NSError *))_failure
;
- (void)loginWithParams:(NSDictionary *)_params;
@end
