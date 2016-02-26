//
//  FilterProductViewController.m
//  ToySeller
//
//  Created by stepanekdavid on 2/9/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "FilterProductViewController.h"
#import "ProductCellCollectionViewCell.h"
#import "ShareProductViewController.h"
#import "UIImageView+AFNetworking.h"
@interface FilterProductViewController ()

@end

@implementation FilterProductViewController

@synthesize nameFilter;
@synthesize imageFilter;
@synthesize categoryFilter;
@synthesize priceFilter;
@synthesize detailsFilter;
@synthesize latFilter;
@synthesize longFilter;

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
    
    [self.productFilterCollectionView registerNib:[UINib nibWithNibName:@"ProductCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCell"];
    self.productFilterCollectionView.backgroundColor = [UIColor clearColor];
    
    self.nameFilter = nameFilter;
    self.imageFilter = imageFilter;
    self.categoryFilter = categoryFilter;
    self.priceFilter = priceFilter;
    self.detailsFilter = detailsFilter;
    self.latFilter = latFilter;
    self.longFilter = longFilter;
}

- (void) setupUI
{
    [self.navigationItem setTitle:@"Filter Products"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIButton *btBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btBack setImage:[UIImage imageNamed:@"img_bt_back"] forState:UIControlStateNormal];
    [btBack setFrame:CGRectMake(0, 0, 60, 30)];
    [btBack addTarget:self action:@selector(btBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btBarBack = [[UIBarButtonItem alloc] initWithCustomView:btBack];
    [self.navigationItem setLeftBarButtonItem:btBarBack];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark : Collection View Datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [categoryFilter count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(150, 200);
}
-(ProductCellCollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentfier = @"ProductCell";
    ProductCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentfier forIndexPath:indexPath];
    
        [[cell productImage] setImageWithURL:[NSURL URLWithString:[imageFilter objectAtIndex:indexPath.item]]];
        
        [[cell productCategory] setText:[categoryFilter objectAtIndex:indexPath.item]];
        [[cell productEachPrice] setText:[priceFilter objectAtIndex:indexPath.item]];
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   ShareProductViewController * shareProductCellViewController = [[ShareProductViewController alloc] initWithNibName:nil bundle:nil];
    
        shareProductCellViewController.productImageUrl = [imageFilter objectAtIndex:indexPath.item];
        shareProductCellViewController.productCagegory = [categoryFilter objectAtIndex:indexPath.item];
        shareProductCellViewController.productPrice = [priceFilter objectAtIndex:indexPath.item];
        shareProductCellViewController.productDetails = [detailsFilter objectAtIndex:indexPath.item];
        shareProductCellViewController.productLat = [latFilter objectAtIndex:indexPath.item];
        shareProductCellViewController.productLong = [longFilter objectAtIndex:indexPath.item];
        [self.navigationController pushViewController:shareProductCellViewController animated:YES];
    
}

-(IBAction)btBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
