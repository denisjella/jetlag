//
//  JNSURLRequest.h
//  ChatDemo-UI2.0
//
//  Created by Richard Stewart on 3/19/15.
//  Copyright (c) 2015 Richard Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+HUD.h"
#import "TTGlobalUICommon.h"
#import "MBProgressHUD.h"
NSString *authCookie;

@interface RestAPIConnection : NSObject


@property (nonatomic,copy) NSString *m_statusCode;
@property (nonatomic,copy) NSString *m_errorMessage;
@property (nonatomic,copy) NSString *m_contents;

@property (nonatomic,strong) NSMutableURLRequest *request;

-(id)initWithURLString:(NSString *)path;
-(id)sendAsyncWithDelegate:(id)delegate;
-(void)setParameterWithString:(NSString *)params;
-(void)setParameterWithArray:(NSArray *)list;
-(void)setCookieWithString:(NSString *)cookie;

@end
