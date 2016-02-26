//
//  SearchViewController.m
//  ToySeller
//
//  Created by jellastar on 1/28/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "SearchViewController.h"
#import "ProductSearchViewController.h"
#import "CouponsViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "SBJson.h"

#import "CategoryCell.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface SearchViewController ()
{
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

@implementation SearchViewController

@synthesize selectedPanel;

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
    self.catetoryTableView.hidden = YES;
    
    //self.tableView.delegate = self;
    //self.tableView.dataSource = self;
    
    lstCategory = [[NSArray alloc] initWithObjects:@"All",@"Home Goods",@"Furniture",@"Fashion",@"Baby & Kids",@ "Collect & Art",@"Sporting Goods",@"Tools", nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [scrView addGestureRecognizer:gesture];
    
    self.selectedPanel = selectedPanel;
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
    [self.navigationItem setTitle:@"Search"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
    //self.navigationItem.hidesBackButton = YES;
    //self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    	/*UIButton *btBack = [UIButton buttonWithType:UIButtonTypeCustom];
    	[btBack setImage:[UIImage imageNamed:@"img_bt_back"] forState:UIControlStateNormal];
    	[btBack setFrame:CGRectMake(0, 0, 60, 30)];
    	[btBack addTarget:self action:@selector(btBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    	UIBarButtonItem *btBarBack = [[UIBarButtonItem alloc] initWithCustomView:btBack];
    	[self.navigationItem setLeftBarButtonItem:btBarBack];*/
    
    
    NSAttributedString *attrForName = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    //NSAttributedString *attrForCategory = [[NSAttributedString alloc] initWithString:@"Category" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    txtName.attributedPlaceholder = attrForName;
    //txtCatergory.attributedPlaceholder = attrForCategory;
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
    CategoryCell *cell = [_catetoryTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
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
        [self btSearchClick:nil];
    }
    return YES;
}


- (IBAction)btnCategoryClick:(id)sender {
    if(self.catetoryTableView.hidden == YES){
        self.catetoryTableView.hidden = NO;
    }else
        self.catetoryTableView.hidden = YES;
}

- (IBAction)btSearchClick:(id)sender {
    [ MBProgressHUD showHUDAddedTo:self.view animated:YES];
    arrayOfImage = [[NSMutableArray alloc] init];
    arrayOfCategory = [[NSMutableArray alloc] init];
    arrayOfPrice = [[NSMutableArray alloc] init];
    arrayOfDetails = [[NSMutableArray alloc] init];
    arrayOfLat = [[NSMutableArray alloc] init];
    arrayOfLong = [[NSMutableArray alloc] init];
    
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
        
        if([self.btnProductCategory.titleLabel.text isEqualToString:@""] || [txtName.text isEqualToString:@""]) {
            [self alertStatus:@"Please enter Coupon Name and select Coupon Category" :@"Category!"];
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
            
           // NSLog(@"Response code: %ld", (long)[response statusCode]);
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
                    NSString *lat = (NSString *)[bpDic objectForKey:@"latitude"];
                    NSString *ong = (NSString *)[bpDic objectForKey:@"longitude"];
                    NSLog(@"lat---------   %@",lat);
                    NSLog(@"long--------   %@",ong);
                    if ([self.selectedPanel isEqualToString:@"SaveMoney"]) {
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
                    }else{
                        [arrayOfImage addObject:imageUrl];
                        [arrayOfCategory addObject:productCategory];
                        [arrayOfPrice addObject:eachPrice];
                        [arrayOfDetails addObject:details];
                        [arrayOfLat addObject:lat];
                        [arrayOfLong addObject:ong];
                    }
                }
                if ([self.selectedPanel isEqualToString:@"SaveMoney"]) {
                    ProductSearchViewController *productSearchViewController = [[ProductSearchViewController alloc] initWithNibName:nil bundle:nil];
                    productSearchViewController.imageArrayFree = arrayOfImageFree;
                    productSearchViewController.categoryArrayFree = arrayOfCategoryFree;
                    productSearchViewController.priceArrayFree = arrayOfPriceFree;
                    productSearchViewController.detailsArrayFree = arrayOfDetailsFree;
                    productSearchViewController.latArrayFree = arrayOfLatFree;
                    productSearchViewController.longArrayFree = arrayOfLongFree;
                
                    productSearchViewController.imageArrayFixed = arrayOfImageFixed;
                    productSearchViewController.categoryArrayFixed = arrayOfCategoryFixed;
                    productSearchViewController.priceArrayFixed = arrayOfPriceFixed;
                    productSearchViewController.detailsArrayFixed = arrayOfDetailsFixed;
                    productSearchViewController.latArrayFixed = arrayOfLatFixed;
                    productSearchViewController.longArrayFixed = arrayOfLongFixed;
                    
                    productSearchViewController.mainStateProduct = @"1";
                    [self.navigationController pushViewController:productSearchViewController animated:YES];
                }else{
                    CouponsViewController *couponsViewController = [[CouponsViewController alloc] initWithNibName:nil bundle:nil];
                    couponsViewController.imageArray = arrayOfImage;
                    couponsViewController.categoryArray = arrayOfCategory;
                    couponsViewController.priceArray = arrayOfPrice;
                    couponsViewController.detailsArray = arrayOfDetails;
                    couponsViewController.latArray = arrayOfLat;
                    couponsViewController.longArray = arrayOfLong;
                    
                    couponsViewController.mainStateCoupon = @"1";
                    
                    [self.navigationController pushViewController:couponsViewController animated:YES];
                }
                [MBProgressHUD hideHUDForView : self.view animated : YES ] ;

            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Search Failed!"];
                [MBProgressHUD hideHUDForView : self.view animated : YES ] ;

            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}

-(IBAction)btBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end