//
//  RegisterViewController.h
//  ToySeller
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UIScrollView *scrView;
    
    BOOL showKeyboard;
}
//- (IBAction)btFBLoginClick:(id)sender;
- (IBAction)btAgreeClick:(id)sender;
- (IBAction)btBackClick:(id)sender;
@end