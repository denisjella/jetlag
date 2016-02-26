//
//  UserAccountViewController.m
//  ToySeller
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "UserAccountViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface UserAccountViewController ()

@end

@implementation UserAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btLoginClick:(id)sender {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    //[self presentViewController:loginViewController animated:YES completion:NULL];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (IBAction)btSignupClick:(id)sender {
    RegisterViewController * registerViewController = [[RegisterViewController alloc] initWithNibName:nil bundle:nil];
    //[self presentViewController:signupViewController animated:YES completion:NULL];
    [self.navigationController pushViewController:registerViewController animated:YES];
}
- (IBAction)btFBLoginClick:(id)sender{

}
@end
