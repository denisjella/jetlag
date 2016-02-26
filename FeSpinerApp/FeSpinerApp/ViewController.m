//
//  ViewController.m
//  FeSpinerApp
//
//  Created by jellastar on 11/19/15.
//  Copyright (c) 2015 jellastar. All rights reserved.
//

#import "ViewController.h"
#import "FXBlurView.h"
#import "UIColor+flat.h"
#import "FeSpinnerTenDot.h"

@interface ViewController ()
@property (strong, nonatomic) FeSpinnerTenDot *spinnerTenDot;
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _spinnerTenDot = [[FeSpinnerTenDot alloc] initWithView:_containerView withBlur:YES];
    _spinnerTenDot.titleLabelText = @"LOADING";
    _spinnerTenDot.fontTitleLabel = [UIFont fontWithName:@"Neou-Thin" size:22];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender
{
    
    [_spinnerTenDot show];
}
- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

- (IBAction)stop:(id)sender
{
    [_spinnerTenDot dismiss];
    //_spinnerTenDot.titleLabelText = @"Plz waiting";
}

@end
