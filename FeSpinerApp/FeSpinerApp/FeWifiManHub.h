//
//  FeWifiManHub.h
//  FeSpinerApp
//
//  Created by jellastar on 11/19/15.
//  Copyright (c) 2015 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, FeWifiManHubMode){
    FeWifiManHubModeOnlyLoader,
    FeWifiManHubModeOnlyPercent
};
@interface FeWifiManHub : UIView
@property (assign, readonly, nonatomic) BOOL isAnimate;
@property (assign, nonatomic) CGFloat percent;
@property (assign, readonly, nonatomic) FeWifiManHubMode currentMode;

-(id) initWithView:(UIView *) view withMode:(FeWifiManHubMode) mode;

-(void) show;

-(void) showWhileExecutingBlock:(dispatch_block_t) block;

-(void) showWhileExecutingBlock:(dispatch_block_t)block completion:(dispatch_block_t) completion;

-(void) showWhileExecutingSelector:(SEL) selector onTarget:(id) target withObject:(id) object;

-(void) showWhileExecutingSelector:(SEL)selector onTarget:(id)target withObject:(id)object completion:(dispatch_block_t) completion;

-(void) dismiss;
@end
