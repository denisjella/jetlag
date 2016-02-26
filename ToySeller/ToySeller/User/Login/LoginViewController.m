//
//  LoginViewController.m
//  ToySeller
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "SBJson.h"
//#import "ForgotViewController.h"
#import "MainViewController.h"
//#import "ContactViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    
    showKeyboard = NO;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [scrView addGestureRecognizer:gesture];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}
-(void)handleTap
{
    if (showKeyboard)
    {
        [self.view endEditing:YES];
        [scrView setContentSize:CGSizeMake(0, 0)];
        showKeyboard = NO;
    }
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    if (!showKeyboard)
    {
        showKeyboard = YES;
        [scrView setContentSize:CGSizeMake(320, scrView.frame.size.height + 216.0f)];
        if (IS_IPHONE_5) {
            [scrView setContentOffset:CGPointMake(0, 110) animated:YES];
        } else [scrView setContentOffset:CGPointMake(0, 160) animated:YES];
        
    }
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    if (showKeyboard)
    {
        [self.view endEditing:YES];
        [scrView setContentSize:CGSizeMake(0, 0)];
        showKeyboard = NO;
    }
}
- (void) setupUI
{
    [self.navigationItem setTitle:@"Login"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
     self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    	UIButton *btBack = [UIButton buttonWithType:UIButtonTypeCustom];
    	[btBack setImage:[UIImage imageNamed:@"img_bt_back"] forState:UIControlStateNormal];
    	[btBack setFrame:CGRectMake(0, 0, 60, 30)];
    	[btBack addTarget:self action:@selector(btBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    	UIBarButtonItem *btBarBack = [[UIBarButtonItem alloc] initWithCustomView:btBack];
    	[self.navigationItem setLeftBarButtonItem:btBarBack];
    
    btLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btLogin setFrame:CGRectMake(0, 0, 60, 30)];
    [btLogin setTitle:@"Login" forState:UIControlStateNormal];
    [btLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btLogin setFont:[UIFont fontWithName:@"Raleway" size:19]];
    [btLogin addTarget:self action:@selector(btLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btBarLogin = [[UIBarButtonItem alloc] initWithCustomView:btLogin];
    [self.navigationItem setRightBarButtonItem:btBarLogin];
    
    NSAttributedString *attrForEmail = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    NSAttributedString *attrForPasswird = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    txtEmail.attributedPlaceholder = attrForEmail;
    txtPassword.attributedPlaceholder = attrForPasswird;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(IBAction)btBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
///add by jella --temp method
-(void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
-(IBAction)btLoginClick:(id)sender
{
    txtEmail.text = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    if (!txtEmail.text.length)
    {
        [self showAlert:@"Please input Email Address" :@"Input Error"];
        return;
    }
    if (!txtPassword.text.length)
    {
        [self showAlert:@"Please input Password" :@"Input Error"];
        return;
    }
    
    [self.view endEditing:YES];
    [ MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    /*    void ( ^successed )( id _responseObject ) = ^( id _responseObject )
     {
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     
     if ([[_responseObject objectForKey:@"success"] boolValue])
     {
     [AppDelegate sharedDelegate].sessionId	= [[_responseObject objectForKey:@"data"] objectForKey:@"sessionId"];
     [AppDelegate sharedDelegate].userId		= [[_responseObject objectForKey:@"data"] objectForKey:@"user_id"];
     [AppDelegate sharedDelegate].firstName	= [[_responseObject objectForKey:@"data"] objectForKey:@"first_name"];
     [AppDelegate sharedDelegate].lastName = [[_responseObject objectForKey:@"data"] objectForKey:@"last_name"];
     [AppDelegate sharedDelegate].photoUrl = _responseObject[@"data"][@"photo_url"];
     [AppDelegate sharedDelegate].syncTimeStamp = [[_responseObject objectForKey:@"data"] objectForKey:@"sync_timestamp"];
     [AppDelegate sharedDelegate].qrCode = [[_responseObject objectForKey:@"data"] objectForKey:@"qrcode"];
     
     //deleted
     //			[[AppDelegate sharedDelegate] goToSetupCB];
     //            return;
     //wang class interrupt
     //           SetupLocationer *locationer = [[SetupLocationer alloc] init];
     //          [locationer configAfterSignIn:_responseObject];
     //wang class interrupt end
     NSLog(@"success");
     }
     else
     {
     if (_responseObject && _responseObject[@"err"] && _responseObject[@"err"][@"errMsg"])
     [self showAlert:_responseObject[@"err"][@"errMsg"] :@"Login Error"];
     else
     [self showAlert:@"Email or password may be incorrect. Check them and try again." :@"Login Error"];
     }
     } ;
     
     void ( ^failure )( NSError* _error ) = ^( NSError* _error )
     {
     
     [ MBProgressHUD hideHUDForView : self.view animated : YES ] ;
     [ self  showAlert: @"No Internet Connection." :@"Oops!"] ;
     
     } ;
     
     if (![AppDelegate sharedDelegate].strDeviceToken)
     {
     [AppDelegate sharedDelegate].strDeviceToken = @"11111111111111";
     }
     
     NSLog(@"token = %@", [AppDelegate sharedDelegate].strDeviceToken);
     
     [[YYYCommunication sharedManager] UserLogin:txtEmail.text
     password:txtPassword.text
     udid:[OpenUDID value]
     token:[AppDelegate sharedDelegate].strDeviceToken
     successed:successed
     failure:failure];*/
    
    @try {
        
        if([[txtEmail text] isEqualToString:@""] || [[txtPassword text] isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"email=%@&password=%@",[txtEmail text],[txtPassword text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://payzlitch.bargainspecialists.com/payzlitch/login.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSLog(@"url=%@",url);
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                SBJsonParser *jsonParser = [SBJsonParser new];
                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                NSLog(@"%@",jsonData);
                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                NSLog(@"%ld",(long)success);
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    //[self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    [ MBProgressHUD hideHUDForView : self.view animated : YES ] ;
                    
                    //ProductSearchViewController *productSearchViewController = [[ProductSearchViewController alloc] initWithNibName:nil bundle:nil];
                    //[self.navigationController pushViewController:productSearchViewController animated:YES];
                    
                    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
                    //[self presentViewController:loginViewController animated:YES completion:NULL];
                    [self.navigationController pushViewController:mainViewController animated:YES];
                    
                } else {
                    
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    [self alertStatus:error_msg :@"Login Failed!"];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Login Failed!"];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}
-(void)showAlert:(NSString*)msg :(NSString*)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtEmail)
    {
        [txtPassword becomeFirstResponder];
    } else {
        [self btLoginClick:nil];
    }
    return YES;
}
- (IBAction)btForgotClick:(id)sender {
  //  ForgotViewController *forgotViewController = [[ForgotViewController alloc] initWithNibName:@"ForgotViewController" bundle:nil];
  //  [self.navigationController pushViewController:forgotViewController animated:YES];
}

//- (IBAction)btFBLoginClick:(id)sender {
//}
@end