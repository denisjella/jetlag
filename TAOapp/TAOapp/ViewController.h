//
//  ViewController.h
//  TAOapp
//
//  Created by jellastar on 11/19/15.
//  Copyright (c) 2015 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAOverlay.h"
@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *items;
    
    UIButton *noString;
    UIButton *smallString;
    UIButton *longString;
    
    UIButton *bar;
    UIButton *fullscreen;
    UIButton *rect;
    
    UIButton *opaque;
    
    UIButton *dismiss;
    
    BOOL showBar;
    BOOL showFullscreen;
    BOOL showRect;
    BOOL showOpaque;
    
    UIView *buttonsView;
    
    CGFloat heightControl;
}

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSString *status;

@end

