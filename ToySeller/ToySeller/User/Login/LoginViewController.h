//
//  LoginViewController.h
//  ToySeller
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    UIButton *btLogin;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UIScrollView *scrView;
    BOOL showKeyboard;
}
- (IBAction)btForgotClick:(id)sender;


@end