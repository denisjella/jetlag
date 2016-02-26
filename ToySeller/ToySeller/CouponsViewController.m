//
//  CouponsViewController.m
//  ToySeller
//
//  Created by stepanekdavid on 2/3/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "CouponsViewController.h"
#import "ProductInviteCollectionViewCell.h"
#import "AddProductViewController.h"
#import "GetProductCellViewController.h"
#import "RegisterViewController.h"
#import "SearchViewController.h"
#import "MainViewController.h"
#import "FilterProductViewController.h"

#import "UIImageView+AFNetworking.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
#import "SBJson.h"

@interface CouponsViewController ()
{
    
    NSMutableArray *nameArrayFilter;
    NSMutableArray *imageArrayFilter;
    NSMutableArray *categoryArrayFilter;
    NSMutableArray *priceArrayFilter;
    NSMutableArray *detailsArrayFilter;
    NSMutableArray *latArrayFilter;
    NSMutableArray *longArrayFilter;
    
    NSMutableArray *arraySelected;
    
    UIRefreshControl *refreshControl;
}
@end

@implementation CouponsViewController

@synthesize nameArray;
@synthesize imageArray;
@synthesize categoryArray;
@synthesize priceArray;
@synthesize detailsArray;
@synthesize latArray;
@synthesize longArray;

@synthesize mainStateCoupon;

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
    
    [self.couponsCollectionView registerNib:[UINib nibWithNibName:@"ProductInviteCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductInviteCell"];
    self.couponsCollectionView.backgroundColor = [UIColor clearColor];
    
    self.nameArray = nameArray;
    self.imageArray = imageArray;
    self.categoryArray = categoryArray;
    self.priceArray = priceArray;
    self.detailsArray = detailsArray;
    self.latArray = latArray;
    self.longArray = longArray;
    
    arraySelected = [[NSMutableArray alloc] init];
    for (int i = 0; i < [categoryArray count]; i++) {
        [arraySelected addObject:@"0"];
    }
    
    nameArrayFilter = [[NSMutableArray alloc] init];
    imageArrayFilter = [[NSMutableArray alloc] init];
    categoryArrayFilter = [[NSMutableArray alloc] init];
    priceArrayFilter = [[NSMutableArray alloc] init];
    detailsArrayFilter = [[NSMutableArray alloc] init];
    latArrayFilter = [[NSMutableArray alloc] init];
    longArrayFilter = [[NSMutableArray alloc] init];
    
    self.mainStateCoupon = mainStateCoupon;
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.couponsCollectionView addSubview:refreshControl];
    
}
-(void)showAlert:(NSString*)msg :(NSString*)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
-(void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refresh:(UIRefreshControl *)refreshControl {
    [self reloadProducts];
    NSLog(@"Testing-------refresh");
}
- (void) setupUI
{
    [self.navigationItem setTitle:@"Coupons"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIButton *btBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btBack setImage:[UIImage imageNamed:@"img_bt_back"] forState:UIControlStateNormal];
    [btBack setFrame:CGRectMake(0, 0, 60, 30)];
    [btBack addTarget:self action:@selector(btBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btBarBack = [[UIBarButtonItem alloc] initWithCustomView:btBack];
    [self.navigationItem setLeftBarButtonItem:btBarBack];
    
    UIBarButtonItem *btAddProduct = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_add_green"] style:UIBarButtonItemStylePlain target:self action:@selector(btAddProductClick:)];
    UIBarButtonItem *btSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_icon_2x"] style:UIBarButtonItemStylePlain target:self action:@selector(onSearch:)];
    self.navigationItem.rightBarButtonItems = @[btAddProduct, btSearch];
    
}

-(void)reloadProducts{
    [refreshControl endRefreshing];
}
#pragma mark : Collection View Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.couponsCollectionView) {
        return [categoryArray count];
    }else{
        return [categoryArray count];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(150, 200);
}
-(ProductInviteCollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentfier = @"ProductInviteCell";
    ProductInviteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentfier forIndexPath:indexPath];
    
    
    if ([[arraySelected objectAtIndex:indexPath.item]  isEqual: @"1"]) {
        cell.isPlaying = true;
    }else{
        cell.isPlaying = false;
    }
    [[cell imgProduct] setImageWithURL:[NSURL URLWithString:[imageArray objectAtIndex:indexPath.item]]];
        
    [[cell txtProductName] setText:[categoryArray objectAtIndex:indexPath.item]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ProductInviteCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //[[cell imgHeart] setImage:[UIImage imageNamed:@"heart_on.png"]];
    cell.isPlaying = !cell.isPlaying;
    if (cell.isPlaying) {
        [arraySelected replaceObjectAtIndex:indexPath.item withObject:@"1"];
    }else{
        [arraySelected replaceObjectAtIndex:indexPath.item withObject:@"0"];
    }
    
}
-(IBAction)btAddProductClick:(id)sender{
    AddProductViewController *vc = [[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}
-(IBAction)onSearch:(id)sender{
    
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:nil bundle:nil];
    searchViewController.selectedPanel = @"Coupons";
    [self.navigationController pushViewController:searchViewController animated:YES];
}
-(IBAction)btBackClick:(id)sender
{
    if ([mainStateCoupon  isEqual: @"1"]){
        MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
        //[self presentViewController:loginViewController animated:YES completion:NULL];
        [self.navigationController pushViewController:mainViewController animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)btProductFilter:(id)sender {
    FilterProductViewController *cv = [[FilterProductViewController alloc] initWithNibName:nil bundle:nil];
    
    [nameArrayFilter removeAllObjects];
    [imageArrayFilter removeAllObjects];
    [categoryArrayFilter removeAllObjects];
    [priceArrayFilter removeAllObjects];
    [detailsArrayFilter removeAllObjects];
    [latArrayFilter removeAllObjects];
    [longArrayFilter removeAllObjects];
    
    for (int i = 0; i < [categoryArray count]; i++) {
        if ([[arraySelected objectAtIndex:i] isEqual:@"1"]) {
            [nameArrayFilter addObject:[nameArray objectAtIndex:i]];
            [imageArrayFilter addObject:[imageArray objectAtIndex:i]];
            [categoryArrayFilter addObject:[categoryArray objectAtIndex:i]];
            [priceArrayFilter addObject:[priceArray objectAtIndex:i]];
            [detailsArrayFilter addObject:[detailsArray objectAtIndex:i]];
            [latArrayFilter addObject:[latArray objectAtIndex:i]];
            [longArrayFilter addObject:[longArray objectAtIndex:i]];
        }
    }
    
    cv.nameFilter = nameArrayFilter;
    cv.imageFilter = imageArrayFilter;
    cv.categoryFilter = categoryArrayFilter;
    cv.priceFilter = priceArrayFilter;
    cv.detailsFilter = detailsArrayFilter;
    cv.latFilter = latArrayFilter;
    cv.longFilter = longArrayFilter;
    
    [self.navigationController pushViewController:cv animated:YES];
}
@end
