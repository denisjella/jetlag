//
//  ProductSearchViewController.m
//  ToySeller
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "ProductSearchViewController.h"
#import "AddProductViewController.h"
#import "ProductCellCollectionViewCell.h"
#import "GetProductCellViewController.h"
#import "RegisterViewController.h"
#import "SearchViewController.h"
#import "MainViewController.h"

#import "UIImageView+AFNetworking.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
@interface ProductSearchViewController ()
@end

@implementation ProductSearchViewController

@synthesize imageArrayFree;
@synthesize categoryArrayFree;
@synthesize priceArrayFree;
@synthesize detailsArrayFree;
@synthesize latArrayFree;
@synthesize longArrayFree;

@synthesize imageArrayFixed;
@synthesize categoryArrayFixed;
@synthesize priceArrayFixed;
@synthesize detailsArrayFixed;
@synthesize latArrayFixed;
@synthesize longArrayFixed;

@synthesize mainStateProduct;

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
    
    //[[self freeProductCollectionView] setDataSource:self];
    //[[self freeProductCollectionView] setDelegate:self];
    
    [self.freeProductCollectionView registerNib:[UINib nibWithNibName:@"ProductCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCell"];
    self.freeProductCollectionView.backgroundColor = [UIColor clearColor];
    
    [self.priceProductCollectionView registerNib:[UINib nibWithNibName:@"ProductCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCell"];
    self.priceProductCollectionView.backgroundColor = [UIColor clearColor];
    
    self.imageArrayFree = imageArrayFree;
    self.categoryArrayFree = categoryArrayFree;
    self.priceArrayFree = priceArrayFree;
    self.detailsArrayFree = detailsArrayFree;
    self.latArrayFree = latArrayFree;
    self.longArrayFree = longArrayFree;
    
    self.imageArrayFixed = imageArrayFixed;
    self.categoryArrayFixed = categoryArrayFixed;
    self.priceArrayFixed = priceArrayFixed;
    self.detailsArrayFixed = detailsArrayFixed;
    self.latArrayFixed = latArrayFixed;
    self.longArrayFixed = longArrayFixed;
    
    self.mainStateProduct = mainStateProduct;
    
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
- (void) setupUI
{
    [self.navigationItem setTitle:@"Save Money"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIButton *btBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btBack setImage:[UIImage imageNamed:@"img_bt_back"] forState:UIControlStateNormal];
    [btBack setFrame:CGRectMake(0, 0, 60, 30)];
    [btBack addTarget:self action:@selector(btBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btBarBack = [[UIBarButtonItem alloc] initWithCustomView:btBack];
    [self.navigationItem setLeftBarButtonItem:btBarBack];
    
    UIBarButtonItem *btSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_icon_2x"] style:UIBarButtonItemStylePlain target:self action:@selector(onSearch:)];
    self.navigationItem.rightBarButtonItem = btSearch;
    
}

#pragma mark : Collection View Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.freeProductCollectionView) {
        return [categoryArrayFree count];
    }else{
        return [categoryArrayFixed count];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(150, 200);
}
-(ProductCellCollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentfier = @"ProductCell";
    ProductCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentfier forIndexPath:indexPath];
    //[[cell productImage] setImage:[UIImage imageNamed:[arrayOfImage objectAtIndex:indexPath.item]]];
    
    if (collectionView == self.freeProductCollectionView) {
        [[cell productImage] setImageWithURL:[NSURL URLWithString:[imageArrayFree objectAtIndex:indexPath.item]]];
        
        //[[cell productImage] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arrayOfImage objectAtIndex:indexPath.item]]]]];
        
        [[cell productCategory] setText:[categoryArrayFree objectAtIndex:indexPath.item]];
        [[cell productEachPrice] setText:[priceArrayFree objectAtIndex:indexPath.item]];
    }else{
        [[cell productImage] setImageWithURL:[NSURL URLWithString:[imageArrayFixed objectAtIndex:indexPath.item]]];
        
        //[[cell productImage] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arrayOfImage objectAtIndex:indexPath.item]]]]];
        
        [[cell productCategory] setText:[categoryArrayFixed objectAtIndex:indexPath.item]];
        [[cell productEachPrice] setText:[priceArrayFixed objectAtIndex:indexPath.item]];
    }
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GetProductCellViewController * getProductCellViewController = [[GetProductCellViewController alloc] initWithNibName:nil bundle:nil];
    /*[[getProductCellViewController getProductImage] setImage:[UIImage imageNamed:[arrayOfImage objectAtIndex:indexPath.item]]];
    [[getProductCellViewController getProductCategory] setText:[arrayOfCategory objectAtIndex:indexPath.item]];
    [[getProductCellViewController getProductPrice] setText:[arrayOfPrice objectAtIndex:indexPath.item]];*/
    if (collectionView == self.freeProductCollectionView) {
        getProductCellViewController.productImageUrl = [imageArrayFree objectAtIndex:indexPath.item];
        getProductCellViewController.productCagegory = [categoryArrayFree objectAtIndex:indexPath.item];
        getProductCellViewController.productPrice = [priceArrayFree objectAtIndex:indexPath.item];
        getProductCellViewController.productDetails = [detailsArrayFree objectAtIndex:indexPath.item];
        getProductCellViewController.productLat = [latArrayFree objectAtIndex:indexPath.item];
        getProductCellViewController.productLong = [longArrayFree objectAtIndex:indexPath.item];
        [self.navigationController pushViewController:getProductCellViewController animated:YES];
    }else{
        getProductCellViewController.productImageUrl = [imageArrayFixed objectAtIndex:indexPath.item];
        getProductCellViewController.productCagegory = [categoryArrayFixed objectAtIndex:indexPath.item];
        getProductCellViewController.productPrice = [priceArrayFixed objectAtIndex:indexPath.item];
        getProductCellViewController.productDetails = [detailsArrayFixed objectAtIndex:indexPath.item];
        getProductCellViewController.productLat = [latArrayFixed objectAtIndex:indexPath.item];
        getProductCellViewController.productLong = [longArrayFixed objectAtIndex:indexPath.item];
        [self.navigationController pushViewController:getProductCellViewController animated:YES];
    }
    
}
-(IBAction)btAddProductClick:(id)sender{
    AddProductViewController *vc = [[AddProductViewController alloc] initWithNibName:@"AddProductViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}
-(IBAction)onSearch:(id)sender{
     
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:nil bundle:nil];
    searchViewController.selectedPanel = @"SaveMoney";
    //[self presentViewController:loginViewController animated:YES completion:NULL];
    [self.navigationController pushViewController:searchViewController animated:YES];
}
-(IBAction)btBackClick:(id)sender
{
    
    NSLog(@"jellabsck");
    if ([mainStateProduct  isEqual: @"1"]){
        MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
        //[self presentViewController:loginViewController animated:YES completion:NULL];
        [self.navigationController pushViewController:mainViewController animated:YES];
    }else{
          [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
