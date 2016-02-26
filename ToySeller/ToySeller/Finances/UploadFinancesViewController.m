//
//  UploadFinancesViewController.m
//  ToySeller
//
//  Created by stepanekdavid on 2/3/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "UploadFinancesViewController.h"
#import "DateTableViewCell.h"
@interface UploadFinancesViewController ()

@end

@implementation UploadFinancesViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    showKeyboard = NO;
    self.dateTableView.hidden = YES;
    self.monthTableView.hidden = YES;
    
    //self.monthTableView.delegate = self;
    //self.monthTableView.dataSource = self;
    
    lstDate = [[NSMutableArray alloc] init];
    for (int i = 1990; i <= 2050; i++) {
        [lstDate addObject:[NSString stringWithFormat:@"%d",i]];
    }
    lstMonth = [[NSArray alloc] initWithObjects:@"January",@"February",@"March",@"April",@"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December",nil];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
}

- (void) setupUI
{
    [self.navigationItem setTitle:@"Save Money"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        //[scrView setContentSize:CGSizeMake(0, 0)];
        showKeyboard = NO;
    }
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    if (!showKeyboard)
    {
        showKeyboard = YES;
        
        
    }
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    if (showKeyboard)
    {
        [self.view endEditing:YES];
        //[scrView setContentSize:CGSizeMake(0, 0)];
        showKeyboard = NO;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.dateTableView) {
        return [lstDate count];
    }else{
        return [lstMonth count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"DateItem";
    
    
    if (tableView == self.dateTableView) {
        DateTableViewCell *cell = [_dateTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            cell = [DateTableViewCell sharedCell];
        }
        
        [cell setDelegate:self];
        
        //NSLog(@"DATE--------%@",[lstDate objectAtIndex:indexPath.row]);
        [cell setCurDateItem:[lstDate objectAtIndex:indexPath.row]];
        return cell;
    }else{
        DateTableViewCell *cell = [_monthTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            cell = [DateTableViewCell sharedCell];
        }
        
        [cell setDelegate:self];
       // NSLog(@"DATE--------%@",[lstMonth objectAtIndex:indexPath.row]);
        [cell setCurDateItem:[lstMonth objectAtIndex:indexPath.row]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.dateTableView) {
        [self.btnDate setTitle:[lstDate objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }else{
        [self.btnMonth setTitle:[lstMonth objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    
    tableView.hidden = YES;
}
-(void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)showAlert:(NSString*)msg :(NSString*)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtUploadBill)
    {
        //     [txtCatergory becomeFirstResponder];
    } else {
        [self btAddClick:nil];
    }
    return YES;
}

- (IBAction)btnSearchClick:(id)sender {
}

- (IBAction)btAddClick:(id)sender {
}

- (IBAction)btnDateClick:(id)sender {
    if(self.dateTableView.hidden == YES){
        self.dateTableView.hidden = NO;
        self.monthTableView.hidden = YES;
    }else{
        self.dateTableView.hidden = YES;
        self.monthTableView.hidden = YES;
    }
}

- (IBAction)btnMonthClick:(id)sender {
    if(self.monthTableView.hidden == YES){
        self.monthTableView.hidden = NO;
        self.dateTableView.hidden = YES;
    }else{
        self.monthTableView.hidden = YES;
        self.dateTableView.hidden = YES;
    }
}
@end