//
//  UserAccountViewController.h
//  ToySeller
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserAccountViewController : UIViewController
- (IBAction)btLoginClick:(id)sender;
- (IBAction)btSignupClick:(id)sender;
- (IBAction)btFBLoginClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end
