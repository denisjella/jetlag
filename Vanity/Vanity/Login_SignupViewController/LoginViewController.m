//
//  LoginViewController.m
//  Vanity
//
//  Created by Alex Lee on 7/4/15.
//  Copyright (c) 2015 egon. All rights reserved.
//

#import "LoginViewController.h"
#import "Reachability.h"
#import "RestAPIConnection.h"
#import "AppManager.h"
#import "TableViewController.h"
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController
@synthesize scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [scrollView setScrollEnabled:YES];
    [self.navigationController setNavigationBarHidden:YES];
    _userNameTextField.returnKeyType = UIReturnKeyDone;
    [_userNameTextField setDelegate:self];
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    [_passwordTextField setDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)LoginDidClicked:(id)sender {
    if (![self isEmpty]) {
        
        Reachability* reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
        NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
        
        if(remoteHostStatus == NotReachable) {
            NSLog(@"not reachable");
        }
        else{//if internet connection is good
            
            NSString * infoParam = @"{\"action\":\"login\",\"parameters\":{\"email\": \"androidtest@43ideas.com\",         \"password\": \"test1\"}}";
            NSString *post =[NSString stringWithFormat:@"request=%@",infoParam];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://stage-api.medlanes.com/api_1/call/json"]]];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            NSError *error;
            NSURLResponse *response;
            [self showHudInView:self.view hint:@"Loading..."];
            NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"response = %@", response);
            
            [self hideHud];
            
            if (data != nil && data.length > 0 && error == nil)
            {
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSString *statusCode = [[result valueForKey:@"success"] stringValue];
                //TTAlertNoTitle(statusCode);
                NSLog(@"statusCode=%@",statusCode);
                @try{
                    if ([statusCode isEqualToString:@"1"]) {
                        //success;
                        //set-cookie
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                        NSDictionary *fields = [httpResponse allHeaderFields];
                        NSString *cookie = [fields valueForKey:@"Set-Cookie"];
                        extern NSString *authCookie;
                        authCookie = cookie;
                        //saving cookie on iphone
                        NSString *valueToSave = cookie;
                        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"cookie"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        [self.view endEditing:YES];
                        TableViewController *nextVC = [[TableViewController alloc] init];
                        [self.navigationController pushViewController:nextVC animated:YES];
                        [self.navigationController setNavigationBarHidden:YES];
                        
                        
                        
                    } else {
                        NSString *errorMessage = [[result valueForKey:@"errorMessage"] stringValue];
                        TTAlertNoTitle(errorMessage);
                        return;
                    }
                }@catch(NSException *e){
                    NSLog(@"Login Error");
                    TTAlertNoTitle(@"Login Error!");
                }@finally{
                    
                }
            }


            
        }
    }

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y-120);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
    
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    //if filed is username
    if (textField == _userNameTextField) {
        [_passwordTextField becomeFirstResponder];
    }
    else if (textField == _passwordTextField) {
        [_userNameTextField resignFirstResponder];
        [_passwordTextField resignFirstResponder];

        [self LoginDidClicked:nil];
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}
- (BOOL)isEmpty{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    if([_userNameTextField.text isEqualToString:@""]){
        hud.labelText = @"Input your Email.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        return YES;
    }
   
    if([_passwordTextField.text isEqualToString:@""]){
        //TTAlertNoTitle(@"Input your password");
        hud.labelText = @"Input your password.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        return YES;
    }
    
    return NO;
}

@end
