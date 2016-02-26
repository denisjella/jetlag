//
//  AppManager.m
//  Vanity
//
//  Created by Alex Lee on 7/4/15.
//  Copyright (c) 2015 egon. All rights reserved.
//

#import "AppManager.h"


#define BASE_URL                @"http://stage-api.medlanes.com/api_1/call/json"
@implementation AppManager

+ (instancetype)sharedManager
{
    static AppManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[AppManager alloc] init];
    });
    
    return _sharedManager;
}

- (void)sendToService:(NSString*)_urlString
               params:(NSDictionary *)_params
              success:(void (^)(id))_success
              failure:(void (^)(NSError *))_failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *strWithSignUp = [NSString stringWithFormat:@"%@%@",BASE_URL,_urlString];
    
    [manager POST:strWithSignUp parameters:_params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        
        if (_success) {
            
            _success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (_failure) {
            
            _failure(error);
        }
    }];
    
}
- (void)sendToService:(NSString*)_urlString
               params:(NSDictionary *)_params
           avatarData:(NSData *)_avatarData
              success:(void (^)(id))_success
              failure:(void (^)(NSError *))_failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *strWithSignUp = [NSString stringWithFormat:@"%@%@",BASE_URL,_urlString];

    [manager POST:strWithSignUp parameters:_params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:_avatarData name:@"avatar" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        
        if (_success) {
            
            _success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (_failure) {
            
            _failure(error);
        }
    }];
    
}
- (void)httpRequest:(NSString*)_urlString params:(NSDictionary *)_params
                 success:(void (^)(id))_success
                 failure:(void (^)(NSError *))_failure
{
    [self sendToService:_urlString params:_params success:_success failure:_failure];
}
- (void)httpRequest:(NSString*)_urlString params:(NSDictionary *)_params
                  avatar:(NSData *)_avatar
                 success:(void (^)(id))_success
                 failure:(void (^)(NSError *))_failure
{
    [self sendToService:_urlString params:_params avatarData:_avatar success:_success failure:_failure];
}

- (void)loginWithParams:(NSDictionary *)_params
{
    
}
@end
