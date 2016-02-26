//
//  FeRollingViewController.m
//  FeSpinner
//
//  Created by Nghia Tran on 8/18/14.
//  Copyright (c) 2014 fe. All rights reserved.
//

#import "FeRollingViewController.h"
#import "FeRollingLoader.h"

@interface FeRollingViewController ()
@property (strong, nonatomic) FeRollingLoader *rollingLoader;

@end

@implementation FeRollingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _rollingLoader = [[FeRollingLoader alloc] initWithView:self.view title:@"LOADING"];
    [self.view addSubview:_rollingLoader];
    
    [_rollingLoader showWhileExecutingBlock:^{
        [self myTask];
    } completion:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}
- (void)myTask
{
    // Do something usefull in here instead of sleeping ...
    sleep(2);
}
@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
