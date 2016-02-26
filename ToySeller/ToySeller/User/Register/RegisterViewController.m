//
//  RegisterViewController.m
//  ToySeller
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "MainViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    showKeyboard = NO;
    
    [self.navigationController.navigationBar setTranslucent:YES];
#ifdef DEVENV
    [txtEmail		setText:@"fff@fff.com"];
    [txtName		setText:@"fff"];
    [txtPassword	setText:@"a"];
#endif
    
    txtEmail.delegate = self;
    txtEmail.delegate = self;
    txtPassword.delegate = self;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [scrView addGestureRecognizer:gesture];
    
    // Do any additional setup after loading the view from its nib.
    // Back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
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
-(void)setupUI
{
    [self.navigationItem setTitle:@"SignUp"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
    // self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    //	UIButton *btBack = [UIButton buttonWithType:UIButtonTypeCustom];
    //	[btBack setImage:[UIImage imageNamed:@"img_bt_back"] forState:UIControlStateNormal];
    //	[btBack setFrame:CGRectMake(0, 0, 60, 30)];
    //	[btBack addTarget:self action:@selector(btBackClick:) forControlEvents:UIControlEventTouchUpInside];
    //
    //	UIBarButtonItem *btBarBack = [[UIBarButtonItem alloc] initWithCustomView:btBack];
    //	[self.navigationItem setLeftBarButtonItem:btBarBack];
    
    UIButton *btLogin;
    
    btLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btLogin setFrame:CGRectMake(0, 0, 60, 30)];
    [btLogin setTitle:@"Signup" forState:UIControlStateNormal];
    [btLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btLogin setFont:[UIFont fontWithName:@"Raleway" size:19]];
    [btLogin addTarget:self action:@selector(btAgreeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btBarLogin = [[UIBarButtonItem alloc] initWithCustomView:btLogin];
    [self.navigationItem setRightBarButtonItem:btBarLogin];
    
    NSAttributedString *attrForName = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    NSAttributedString *attrForEmail = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    NSAttributedString *attrForPassword = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    txtName.attributedPlaceholder = attrForName;
    txtEmail.attributedPlaceholder = attrForEmail;
    txtPassword.attributedPlaceholder = attrForPassword;
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtEmail)
    {
        [txtPassword becomeFirstResponder];
    }
    else if (textField == txtName)
    {
        [txtEmail becomeFirstResponder];
    } else {
        //        showKeyboard = NO;
        //        [scrView setContentSize:CGSizeMake(0, 0)];
        [self btAgreeClick:nil];
    }
    
    return YES;
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)checkEmail:(UITextField *)checkText
{
    BOOL filter = YES ;
    NSString *filterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = filter ? filterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if([emailTest evaluateWithObject:checkText.text] == NO)
    {
        // [CommonMethods showAlertUsingTitle:@"Error" andMessage:@"Please enter a valid email address."];
        return NO ;
    }
    
    return YES ;
}
- (IBAction)btFBLoginClick:(id)sender {
}
-(IBAction)btBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showAlert:(NSString*)msg :(NSString*)title :(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
-(void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
-(IBAction)btAgreeClick:(id)sender
{
    NSLog(@"siginup button click");
    
    if (!txtName.text.length)
    {
        [self showAlert:@"Please input Name" :@"Input Error" :nil];
        return;
    }
    if (!txtEmail.text.length)
    {
        [self showAlert:@"Please input Email Address" :@"Input Error" :nil];
        return;
    }
    if (!txtPassword.text.length)
    {
        [self showAlert:@"Please input Password" :@"Input Error" :nil];
        return;
    }
#ifndef DEVENV
    if (txtPassword.text.length < 6)
    {
        [self showAlert:@"Password should have at least 6 characters" :@"Input Error" :nil];
        return;
    }
#endif
    if ([txtEmail.text rangeOfString:@" "].length != 0) {
        [self showAlert:@"Email field contains space. Please input again" :@"Input Error" :nil];
        return;
    }
    
    //if (![CommonMethods checkEmail:txtEmail]) {
    //    return;
    //}
    NSString *strName = txtName.text;
    NSString *strLastName = @"";
    
    if ([[strName componentsSeparatedByString:@" "] count] >= 3 )
    {
        [self showAlert:@"Please input first name and last name" :@"Oops!" :nil];
        return;
    }
    
    if ([strName rangeOfString:@" "].location != NSNotFound)
    {
        strName = [txtName.text substringToIndex:[txtName.text rangeOfString:@" "].location];
        strLastName = [txtName.text substringFromIndex:[txtName.text rangeOfString:@" "].location + 1];
    }
    
    [self.view endEditing:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    @try {
        
        if([[txtEmail text] isEqualToString:@""] || [[txtPassword text] isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"username=%@&email=%@&password=%@",[txtName text],[txtEmail text],[txtPassword text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://payzlitch.bargainspecialists.com/payzlitch/Signup.php"];
            
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
                NSLog(@"jsondata%@",jsonData);
                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                //NSLog(@"%ld",(long)success);
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    //[self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    [ MBProgressHUD hideHUDForView : self.view animated : YES ] ;
                    
                    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
                    //[self presentViewController:loginViewController animated:YES completion:NULL];
                    [self.navigationController pushViewController:mainViewController animated:YES];
                    
                } else {
                    
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"message"];
                    [self alertStatus:error_msg :@"Signup Failed!"];
                    [ MBProgressHUD hideHUDForView : self.view animated : YES ] ;
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Signup Failed!"];
                [ MBProgressHUD hideHUDForView : self.view animated : YES ] ;
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
    
}
@end
