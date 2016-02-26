//
//  HomeViewController.m
//  Vanity
//
//  Created by Alex Lee on 7/4/15.
//  Copyright (c) 2015 egon. All rights reserved.
//

#import "HomeViewController.h"
#import "Reachability.h"
#import "RestAPIConnection.h"
#import "LoginViewController.h"
#import "JSImagePickerViewController.h"
#import "DownPicker.h";
#import "AppManager.h"

@interface HomeViewController (){
   
}
@property (strong, nonatomic) IBOutlet UIButton *userAvatar;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UITextField *genderTextField;
@property (strong, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (strong, nonatomic) IBOutlet UITextField *intrestedInTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) DownPicker *genderdownPicker;
@property (strong, nonatomic) DownPicker *interestdownPicker;
@end

@implementation HomeViewController
@synthesize scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [scrollView setScrollEnabled:YES];
    //[scrollView setContentSize:CGSizeMake(250,620)];
    _userNameTextField.returnKeyType = UIReturnKeyDone;
    [_userNameTextField setDelegate:self];
    _emailTextField.returnKeyType = UIReturnKeyDone;
    [_emailTextField setDelegate:self];
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    [_passwordTextField setDelegate:self];
    _genderTextField.returnKeyType = UIReturnKeyDone;
    [_genderTextField setDelegate:self];
    _birthdayTextField.returnKeyType = UIReturnKeyDone;
    [_birthdayTextField setDelegate:self];
    _intrestedInTextField.returnKeyType = UIReturnKeyDone;
    [_intrestedInTextField setDelegate:self];
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateBirthday) forControlEvents:UIControlEventValueChanged];
    [_birthdayTextField setInputView:datePicker];
    /*
     UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(doRegister)];
     self.navigationItem.rightBarButtonItem = item;
     [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"signup_topbanner"] forBarMetrics:UIBarMetricsDefault];
     [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
     */
    
    // create the array of data
    NSMutableArray* bandArray = [[NSMutableArray alloc] init];
    
    // add some sample data
    [bandArray addObject:@"Male"];
    [bandArray addObject:@"Female"];
    
    
    // bind yourTextField to DownPicker
    self.genderdownPicker = [[DownPicker alloc] initWithTextField:_genderTextField withData:bandArray];
    self.interestdownPicker = [[DownPicker alloc] initWithTextField:_intrestedInTextField withData:bandArray];
    [self.genderdownPicker addTarget:self
                            action:@selector(dp_Selected:)
                  forControlEvents:UIControlEventValueChanged];
    [self.interestdownPicker addTarget:self
                              action:@selector(dp_Selected:)
                    forControlEvents:UIControlEventValueChanged];
    
}
-(void)dp_Selected:(id)dp {
    //NSString* selectedValue = [self.interestdownPicker text];
    // do what you want
}
- (IBAction)goBack:(id)sender {
    LoginViewController *nextVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:NO];
    [self.navigationController setNavigationBarHidden:YES];
}
- (IBAction)SaveBtnDidClicked:(id)sender {
    

    [self doRegister];
}

- (void)updateBirthday{
    UIDatePicker *picker = (UIDatePicker*) _birthdayTextField.inputView;
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _birthdayTextField.text = [formatter stringFromDate:picker.date];
}

- (IBAction)avatarDidClicked:(id)sender {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
}
- (void)imagePickerDidSelectImage:(UIImage *)image {
    
    [self.userAvatar setImage:image forState:UIControlStateNormal];
    [self saveImage:image forPerson:@"me"];
    
     NSString *filename = [@"me" stringByAppendingString:@".png"]; // or .jpg
     
     // Get the path of the app documents directory
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     
     // Append the filename and get the full image path
     NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:filename];
     
     UIImage *faceImage=[self loadImage:savedImagePath];
     [self.userAvatar setImage:faceImage forState:UIControlStateNormal];
    
    }
- (void)saveImage:(UIImage *)image forPerson:(NSString *)userid
{
    // Make file name first
    NSString *filename = [userid stringByAppendingString:@".png"]; // or .jpg
    
    // Get the path of the app documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // Append the filename and get the full image path
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    //  Now convert the image to PNG/JPEG and write it to the image path
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:NO];
    
    
}
- (UIImage *)loadImage:(NSString *)filePath
{
    return [UIImage imageWithContentsOfFile:filePath];
}
- (void) doRegister{
    NSLog(@"Registering...");
    
    if (![self isEmpty]) {
        /*
        if(![_passwordTextField.text isEqualToString:_password2TextField.text]){
            TTAlertNoTitle(@"确认密码");
            return;
        }*/
        Reachability* reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
        NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
        
        if(remoteHostStatus == NotReachable) {
            NSLog(@"not reachable");
           // TTAlertNoTitle(@"网络连接失败");
        }
        else{//if internet connection is good
            NSString *_gender=@"";
            NSString *_intrestedIn=@"";
            if([_genderTextField.text isEqualToString:@"Male"]){
                _gender=@"1";
                
            }
            else if ([_genderTextField.text isEqualToString:@"Female"]){
                _gender=@"2";
            }
            if([_intrestedInTextField.text isEqualToString:@"Male"]){
                _intrestedIn=@"1";
                
            }
            else if ([_intrestedInTextField.text isEqualToString:@"Female"]){
                _intrestedIn=@"2";
            }
            NSString *filename = [@"me" stringByAppendingString:@".png"]; // or .jpg
            
            // Get the path of the app documents directory
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            // Append the filename and get the full image path
            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:filename];
            
            UIImage *faceImage=[self loadImage:savedImagePath];
            
            NSString *urlString=@"/account/signup";
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setValue:_userNameTextField.text forKey:@"username"];
            [params setValue:_emailTextField.text forKey:@"email"];
            [params setValue:_passwordTextField.text forKey:@"password"];
            [params setValue:_gender forKey:@"gender"];
            [params setValue:_birthdayTextField.text forKey:@"birthday"];
            [params setValue:_intrestedIn forKey:@"interested_in"];
            
            NSData *avataData = UIImageJPEGRepresentation(faceImage, 0.8f);
            
            [[AppManager sharedManager] httpRequest:urlString params:params avatar:avataData success:^(id _responseObject) {
                
                NSString *valueOfSuccess = [_responseObject objectForKey:@"success"];
                
                if (valueOfSuccess.integerValue == 0) {
                    NSString *valueOfmessage = [_responseObject objectForKey:@"message"];
                    TTAlertNoTitle(valueOfmessage);
                    return;
                    
                }
                else if (valueOfSuccess.integerValue == 1)
                {
                    TTAlertNoTitle(@"Your account has been logged in successfully.");
                    [self goBack:nil];
                }
                
                
            } failure:^(NSError *_error) {
                
                TTAlertNoTitle(_error);
                
            }];


           
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y-200);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
    
    
   
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    //if filed is username
    if (textField == _userNameTextField) {
        [_emailTextField becomeFirstResponder];
    }
    else if (textField == _emailTextField) {
        [_passwordTextField becomeFirstResponder];
    }
    else if (textField == _passwordTextField) {
        [_genderTextField becomeFirstResponder];
    }
    else if (textField == _genderTextField) {
        //[_idTextField becomeFirstResponder];
        [_birthdayTextField becomeFirstResponder];
    }
    else if (textField == _birthdayTextField) {
        [_intrestedInTextField becomeFirstResponder];
    }
    else if (textField == _intrestedInTextField) {
        [_userNameTextField resignFirstResponder];
        [_emailTextField resignFirstResponder];
        [_passwordTextField resignFirstResponder];
        [_genderTextField resignFirstResponder];
        [_birthdayTextField resignFirstResponder];
        [_intrestedInTextField resignFirstResponder];
        //[_userNameTextField becomeFirstResponder];
        [self doRegister];
    }
    /*
    else if (textField == _password2TextField) {
        [_password2TextField resignFirstResponder];
        
    }
     */
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
  [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (BOOL)isEmpty{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    if([_userNameTextField.text isEqualToString:@""]){
        hud.labelText = @"Input your name.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        return YES;
    }
    if([_emailTextField.text isEqualToString:@""]){
        
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
    if([_genderTextField.text isEqualToString:@""]){
        hud.labelText = @"Input your gender.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        return YES;
    }
    if([_birthdayTextField.text isEqualToString:@""]){
        hud.labelText = @"Input your birthday.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        return YES;
    }
    if([_intrestedInTextField.text isEqualToString:@""]){
        hud.labelText = @"Input your intrest.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        return YES;
    }
    
    return NO;
}

@end
