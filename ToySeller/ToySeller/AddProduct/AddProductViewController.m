//
//  AddProductViewController.m
//  ToySeller
//
//  Created by jellastar on 1/28/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "AddProductViewController.h"
#import "MBProgressHUD.h"
//#import "SBJson.h"
#import "ProductSearchViewController.h"
#import "AFHTTPRequestOperationManager.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface AddProductViewController ()

@end

@implementation AddProductViewController

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
    
    showKeyboard = NO;
    
    txtPrice.hidden = YES;
    priceImage.hidden = YES;
    
    self.catetoryTableView.hidden = YES;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    //self.catetoryTableView.delegate = self;
    //self.catetoryTableView.dataSource = self;
    
    lstCategory = [[NSArray alloc] initWithObjects:@"All",@"Home Goods",@"Furniture",@"Fashion",@"Baby & Kids",@"Collect & Art",@"Sporting Goods",@"Tools", nil];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [scrView addGestureRecognizer:gesture];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.freeSwitch addTarget:self action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
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
            [scrView setContentOffset:CGPointMake(0, 20) animated:YES];
        } else [scrView setContentOffset:CGPointMake(0, 40) animated:YES];
        
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
    [self.navigationItem setTitle:@"Add Product"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
    
    NSAttributedString *attrForName = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    NSAttributedString *attrForPrice = [[NSAttributedString alloc] initWithString:@"Price" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
      txtName.attributedPlaceholder = attrForName;
      txtPrice.attributedPlaceholder = attrForPrice;
}
#pragma mark - Actions
- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
- (IBAction)productAdd:(id)sender {
    if (!txtName.text.length)
    {
        [self showAlert:@"Please input Name" :@"Input Error" :nil];
        return;
    }
    [self.view endEditing:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    NSDate *currentime = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMddhhmmss"];
    NSString *imagefileName = [dateformatter stringFromDate:currentime];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://payzlitch.bargainspecialists.com"]];
    NSData *imageData = UIImageJPEGRepresentation(self.addProductImage.image, 0.5);
    NSString *freeState;
    if ([self.freeSwitch isOn]) {
        freeState = @"1";
    }else{
        freeState = @"0";
    }
    
    
    NSDictionary *parameters = @{@"productName": [txtName text], @"category" : self.btnProductCategory.titleLabel.text,@"free" : freeState,@"price" :[txtPrice text],@"details":[self.detailsTextView text],@"latitude":[NSString stringWithFormat:@"%f",locationManager.location.coordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude]};
    NSLog(@"jellastart______locations%f",locationManager.location.coordinate.latitude);
    NSLog(@"jellastart______locations%f",locationManager.location.coordinate.longitude);
    AFHTTPRequestOperation *op = [manager POST:@"/payzlitch/AddProduct.php" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"Jella-%@.png",imagefileName] mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ MBProgressHUD hideHUDForView : self.view animated : YES ] ;
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        [ MBProgressHUD hideHUDForView : self.view animated : YES ] ;
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [op start];
    
}

- (IBAction)AddPhoto:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add your photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take a Photo" otherButtonTitles:@"Photo From Gallery", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)btnCategoryClick:(id)sender {
    showKeyboard = NO;
    if(self.catetoryTableView.hidden == YES){
        self.catetoryTableView.hidden = NO;
    }else
        self.catetoryTableView.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [lstCategory count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"CategoryTable";
    UITableViewCell *cell = [_catetoryTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [lstCategory objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    //[cell.imageView setImage:[UIImage imageNamed:@"LoginFieldBg.png"]];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"jella");
    // CategoryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.btnProductCategory setTitle:[lstCategory objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    tableView.hidden = YES;
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 2) {
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        return;
    }
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    
    switch (buttonIndex) {
        case 0:
            imgPicker.delegate = self;
            imgPicker.allowsEditing = YES;
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            imgPicker.delegate = self;
            imgPicker.allowsEditing = YES;
            imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            break;
    }
    
    imgPicker.delegate = self;
    
    //[self saveData];
    [self presentViewController:imgPicker animated:YES completion:nil];
    
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [[self addProductImage] setImage:chosenImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)stateChanged:(UISwitch *)freeSwitch{
    if ([freeSwitch isOn]) {
        txtPrice.hidden = YES;
        priceImage.hidden = YES;
    }else{
        txtPrice.hidden = NO;
        priceImage.hidden = NO;
    }
}
@end