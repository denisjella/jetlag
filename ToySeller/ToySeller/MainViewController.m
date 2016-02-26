//
//  MainViewController.m
//  ToySeller
//
//  Created by stepanekdavid on 2/3/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "MainViewController.h"
#import "ProductSearchViewController.h"
#import "CouponsViewController.h"
#import "ManageFinancesViewController.h"
#import "UploadFinancesViewController.h"

#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "SBJson.h"

#import "CategoryCell.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
@interface MainViewController ()
{
    NSMutableArray *arrayOfName;
    NSMutableArray *arrayOfImage;
    NSMutableArray *arrayOfCategory;
    NSMutableArray *arrayOfPrice;
    NSMutableArray *arrayOfDetails;
    NSMutableArray *arrayOfLat;
    NSMutableArray *arrayOfLong;
    
    NSMutableArray *arrayOfImageFree;
    NSMutableArray *arrayOfCategoryFree;
    NSMutableArray *arrayOfPriceFree;
    NSMutableArray *arrayOfDetailsFree;
    NSMutableArray *arrayOfLatFree;
    NSMutableArray *arrayOfLongFree;
    
    NSMutableArray *arrayOfImageFixed;
    NSMutableArray *arrayOfCategoryFixed;
    NSMutableArray *arrayOfPriceFixed;
    NSMutableArray *arrayOfDetailsFixed;
    NSMutableArray *arrayOfLatFixed;
    NSMutableArray *arrayOfLongFixed;
}
@end

@implementation MainViewController

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
    self.categoryTableView.hidden = YES;
    
    //self.categoryTableView.delegate = self;
    //self.categoryTableView.dataSource = self;
    
    lstCategory = [[NSArray alloc] initWithObjects:@"All",@"Home Goods",@"Furniture",@"Fashion",@"Baby & Kids",@ "Collect & Art",@"Sporting Goods",@"Tools", nil];
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    //[scrView addGestureRecognizer:gesture];
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
       // [scrView setContentSize:CGSizeMake(0, 0)];
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
      //  [scrView setContentSize:CGSizeMake(0, 0)];
        showKeyboard = NO;
    }
}
- (void) setupUI
{
    //[self.navigationItem setTitle:@"Get Coupon Save Money"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
    self.navigationItem.hidesBackButton = YES;
    //[self.navigationController.navigationItem setxtAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    /*UIBarButtonItem *btManage = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"manage"] style:UIBarButtonItemStylePlain target:self action:@selector(btnManageFinance:)];
    UIBarButtonItem *btUpload = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"upload"] style:UIBarButtonItemStylePlain target:self action:@selector(btnUploadFinance:)];
    UIBarButtonItem *btMoney = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"manage"] style:UIBarButtonItemStylePlain target:self action:@selector(btnSaveMoney:)];
    UIBarButtonItem *btCoupon = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"upload"] style:UIBarButtonItemStylePlain target:self action:@selector(btnCoupons:)];
    self.navigationItem.leftBarButtonItems = @[btMoney, btCoupon];
    self.navigationItem.rightBarButtonItems = @[btManage, btUpload];*/
    UIButton *btMoney=[UIButton buttonWithType:UIButtonTypeCustom];
    [btMoney setFrame:CGRectMake(10.0, 2.0, 65.0, 40.0)];
    [btMoney addTarget:self action:@selector(btnSaveMoney:) forControlEvents:UIControlEventTouchUpInside];
    [btMoney setImage:[UIImage imageNamed:@"moneyImg.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btLeftMoney = [[UIBarButtonItem alloc]initWithCustomView:btMoney];
    
    UIButton *btCoupon=[UIButton buttonWithType:UIButtonTypeCustom];
    [btCoupon setFrame:CGRectMake(10.0, 2.0, 65.0, 40.0)];
    [btCoupon addTarget:self action:@selector(btnCoupons:) forControlEvents:UIControlEventTouchUpInside];
    [btCoupon setImage:[UIImage imageNamed:@"couponImg.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btLeftCoupon = [[UIBarButtonItem alloc]initWithCustomView:btCoupon];
    
    UIButton *btManage=[UIButton buttonWithType:UIButtonTypeCustom];
    [btManage setFrame:CGRectMake(10.0, 2.0, 65.0, 40.0)];
    [btManage addTarget:self action:@selector(btnManageFinance:) forControlEvents:UIControlEventTouchUpInside];
    [btManage setImage:[UIImage imageNamed:@"manage.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btRightManage = [[UIBarButtonItem alloc]initWithCustomView:btManage];
    
    UIButton *btUpload=[UIButton buttonWithType:UIButtonTypeCustom];
    [btUpload setFrame:CGRectMake(10.0, 2.0, 65.0, 40.0)];
    [btUpload addTarget:self action:@selector(btnUploadFinance:) forControlEvents:UIControlEventTouchUpInside];
    [btUpload setImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btRightUpload = [[UIBarButtonItem alloc]initWithCustomView:btUpload];
    
    self.navigationItem.leftBarButtonItems = @[btLeftMoney, btLeftCoupon];
    self.navigationItem.rightBarButtonItems = @[btRightUpload, btRightManage];
    
    
    NSAttributedString *attrForName = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    NSAttributedString *attrForNeed = [[NSAttributedString alloc] initWithString:@"What Do you need?" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    txtName.attributedPlaceholder = attrForName;
    txtNeed.attributedPlaceholder = attrForNeed;
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
    static NSString *simpleTableIdentifier = @"CategoryItem";
    CategoryCell *cell = [_categoryTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [CategoryCell sharedCell];
    }
    
    [cell setDelegate:self];
    
    [cell setCurCategoryItem:[lstCategory objectAtIndex:indexPath.row]];
    //cell.categoryItem.text = [lstCategory objectAtIndex:indexPath.row];
    // NSLog(@"");
    // cell.backgroundColor = [UIColor clearColor];
    //[cell.imageView setImage:[UIImage imageNamed:@"LoginFieldBg.png"]];
    //cell.categoryItem.textColor = [UIColor whiteColor];
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
    if (textField == txtName)
    {
        //     [txtCatergory becomeFirstResponder];
    } else {
        //[self btSearchClick:nil];
    }
    return YES;
}


- (IBAction)btnCategoryClick:(id)sender {
    if(self.categoryTableView.hidden == YES){
        self.categoryTableView.hidden = NO;
    }else
        self.categoryTableView.hidden = YES;
}

- (IBAction)btnSaveMoney:(id)sender {
    [ MBProgressHUD showHUDAddedTo:self.view animated:YES];
    arrayOfImageFree = [[NSMutableArray alloc] init];
    arrayOfCategoryFree = [[NSMutableArray alloc] init];
    arrayOfPriceFree = [[NSMutableArray alloc] init];
    arrayOfDetailsFree = [[NSMutableArray alloc] init];
    arrayOfLatFree = [[NSMutableArray alloc] init];
    arrayOfLongFree = [[NSMutableArray alloc] init];
    
    arrayOfImageFixed = [[NSMutableArray alloc] init];
    arrayOfCategoryFixed = [[NSMutableArray alloc] init];
    arrayOfPriceFixed = [[NSMutableArray alloc] init];
    arrayOfDetailsFixed = [[NSMutableArray alloc] init];
    arrayOfLatFixed = [[NSMutableArray alloc] init];
    arrayOfLongFixed = [[NSMutableArray alloc] init];
    @try {
        
        if([self.btnProductCategory.titleLabel.text isEqualToString:@""]) {
            [self alertStatus:@"Please select Coupon Category" :@"Category!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"search=%@",self.btnProductCategory.titleLabel.text];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://payzlitch.bargainspecialists.com/payzlitch/searchProduct.php"];
            
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
                //NSLog(@"Response ==> %@", responseData);
                
                SBJsonParser *jsonParser = [SBJsonParser new];
                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                NSLog(@"jsondata---:%@",jsonData);
                for (NSDictionary *bpDic in jsonData){
                    NSString *imageUrl = (NSString *) [bpDic objectForKey:@"coupon_img"];
                    NSString *productCategory = (NSString *) [bpDic objectForKey:@"coupon_cat"];
                    NSString *eachPrice = (NSString *) [bpDic objectForKey:@"coupon_cost"];
                    NSString *details = (NSString *) [bpDic objectForKey:@"coupon_detail"];
                    NSString *lat = (NSString *) [bpDic objectForKey:@"latitude"];
                    NSString *ong = (NSString *) [bpDic objectForKey:@"longitude"];
                    NSRange range;
                    range = [eachPrice rangeOfString:@"free"];
                    if(range.location != NSNotFound){
                        [arrayOfImageFree addObject:imageUrl];
                        [arrayOfCategoryFree addObject:productCategory];
                        [arrayOfPriceFree addObject:eachPrice];
                        [arrayOfDetailsFree addObject:details];
                        [arrayOfLatFree addObject:lat];
                        [arrayOfLongFree addObject:ong];
                    }else{
                        [arrayOfImageFixed addObject:imageUrl];
                        [arrayOfCategoryFixed addObject:productCategory];
                        [arrayOfPriceFixed addObject:eachPrice];
                        [arrayOfDetailsFixed addObject:details];
                        [arrayOfLatFixed addObject:lat];
                        [arrayOfLongFixed addObject:ong];
                    }
                    
                }
                ProductSearchViewController *productSearchViewController = [[ProductSearchViewController alloc] initWithNibName:nil bundle:nil];
                productSearchViewController.imageArrayFree = arrayOfImageFree;
                productSearchViewController.categoryArrayFree = arrayOfCategoryFree;
                productSearchViewController.priceArrayFree = arrayOfPriceFree;
                productSearchViewController.detailsArrayFree = arrayOfDetailsFree;
                productSearchViewController.latArrayFree = arrayOfLatFree;
                productSearchViewController.longArrayFree  = arrayOfLongFree;
                
                productSearchViewController.imageArrayFixed = arrayOfImageFixed;
                productSearchViewController.categoryArrayFixed = arrayOfCategoryFixed;
                productSearchViewController.priceArrayFixed = arrayOfPriceFixed;
                productSearchViewController.detailsArrayFixed = arrayOfDetailsFixed;
                productSearchViewController.latArrayFixed = arrayOfLatFixed;
                productSearchViewController.longArrayFixed = arrayOfLongFixed;
                [self.navigationController pushViewController:productSearchViewController animated:YES];
                
                [MBProgressHUD hideHUDForView : self.view animated : YES ] ;
            } else {
                if (error) NSLog(@"Error: %@", error);
                [MBProgressHUD hideHUDForView : self.view animated : YES ] ;
                [self alertStatus:@"Connection Failed" :@"Search Failed!"];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}

- (IBAction)btnCoupons:(id)sender {
    [ MBProgressHUD showHUDAddedTo:self.view animated:YES];
    arrayOfName = [[NSMutableArray alloc] init];
    arrayOfImage = [[NSMutableArray alloc] init];
    arrayOfCategory = [[NSMutableArray alloc] init];
    arrayOfPrice = [[NSMutableArray alloc] init];
    arrayOfDetails = [[NSMutableArray alloc] init];
    arrayOfLat = [[NSMutableArray alloc] init];
    arrayOfLong = [[NSMutableArray alloc] init];
    
    @try {
            NSString *post =[[NSString alloc] initWithFormat:@"search=%@",@"All"];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://payzlitch.bargainspecialists.com/payzlitch/searchProduct.php"];
            
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
                
                for (NSDictionary *bpDic in jsonData){
                    NSString *name = (NSString *) [bpDic objectForKey:@"coupon_name"];
                    NSString *imageUrl = (NSString *) [bpDic objectForKey:@"coupon_img"];
                    NSString *productCategory = (NSString *) [bpDic objectForKey:@"coupon_cat"];
                    NSString *eachPrice = (NSString *) [bpDic objectForKey:@"coupon_cost"];
                    NSString *details = (NSString *) [bpDic objectForKey:@"coupon_detail"];
                    NSString *lat = (NSString *) [bpDic objectForKey:@"latitude"];
                    NSString *ong = (NSString *)[bpDic objectForKey:@"longitude"];
                    
                    [arrayOfName addObject:name];
                        [arrayOfImage addObject:imageUrl];
                        [arrayOfCategory addObject:productCategory];
                        [arrayOfPrice addObject:eachPrice];
                        [arrayOfDetails addObject:details];
                    [arrayOfLat addObject:lat];
                    [arrayOfLong addObject:ong];
                    
                }
                CouponsViewController *couponsViewController = [[CouponsViewController alloc] initWithNibName:nil bundle:nil];
                couponsViewController.nameArray = arrayOfName;
                couponsViewController.imageArray = arrayOfImage;
                couponsViewController.categoryArray = arrayOfCategory;
                couponsViewController.priceArray = arrayOfPrice;
                couponsViewController.detailsArray = arrayOfDetails;
                couponsViewController.latArray = arrayOfLat;
                couponsViewController.longArray = arrayOfLong;
                [self.navigationController pushViewController:couponsViewController animated:YES];
                
                [MBProgressHUD hideHUDForView : self.view animated : YES ] ;
            } else {
                if (error) NSLog(@"Error: %@", error);
                [MBProgressHUD hideHUDForView : self.view animated : YES ] ;
                [self alertStatus:@"Connection Failed" :@"Search Failed!"];
            }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}

- (IBAction)btnManageFinance:(id)sender {
    ManageFinancesViewController *vc = [[ManageFinancesViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnUploadFinance:(id)sender {
    UploadFinancesViewController *vc = [[UploadFinancesViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

