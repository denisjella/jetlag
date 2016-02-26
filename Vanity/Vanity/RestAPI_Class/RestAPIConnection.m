//
//  JNSURLRequest.m
//  ChatDemo-UI2.0
//
//  Created by Richard Stewart on 3/19/15.
//  Copyright (c) 2015 Richard Stewart. All rights reserved.
//

#import "RestAPIConnection.h"

@implementation RestAPIConnection 


-(id)initWithURLString:(NSString *)path
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://vanity.ourbuddies.org/api%@",path] ];
    self.request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0];
    //NSURLRequestUseProtocolCachePolicy
    self.request.HTTPMethod = @"POST";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data"];
    [self.request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    //[self.request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] stringForKey:@"cookie"];
    [self.request addValue: cookie forHTTPHeaderField:@"Cookie"];
    //TTAlertNoTitle([NSString stringWithFormat:@"cookie=%@",cookie]);
    /*
    if(authCookie != nil) {
//        [self.request setValue: authCookie forHTTPHeaderField: @"UserSessionId" ];
        [self.request addValue: authCookie forHTTPHeaderField:@"Cookie"];
        //TTAlertNoTitle(authCookie);
    }
     */
    return self;
}
-(id)sendAsyncWithDelegate:(id)delegate
{
    if(!self.request) {
        NSLog(@"request is null...");
        return nil;
    }
    
    self.m_statusCode = @"";
    self.m_errorMessage = @"";
    self.m_contents = @"";
 /*
//    [self showHudInView:self.view hint:NSLocalizedString(@"waiting", @"Waiting...")];
    [NSURLConnection sendAsynchronousRequest:self.request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
//         [self hideHud];
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             self.m_statusCode = [[result valueForKey:@"statusCode"] stringValue];
             self.m_errorMessage = [[result valueForKey:@"errorMessage"] stringValue];
             self.m_contents = [[result valueForKey:@"contents"] stringValue];
         } else {
             NSLog(@"--------ajax error----------");
         }
     }];
  */
    return nil;
}
-(void)setParameterWithString:(NSString *)params
{
    [self.request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
}

-(void)setParameterWithArray:(NSArray *)list
{
/*
    for(id key in list){
        NSString *temp = (NSString *)[list objectAtIndex:key];
        [self.request setHTTPBody:[NSString stringWithFormat:@"%@=%@",key,[temp dataUsingEncoding:NSUTF8StringEncoding]]];
    }
 */
}
-(void)setCookieWithString:(NSString *)cookie
{
    [self.request setHTTPShouldHandleCookies:YES];
}


@end
