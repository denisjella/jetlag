//
//  GetProductCellViewController.m
//  ToySeller
//
//  Created by jellastar on 1/28/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "GetProductCellViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MapLocationViewController.h"
@interface GetProductCellViewController ()

@end

@implementation GetProductCellViewController
@synthesize productImageUrl,productCagegory,productPrice,productDetails,productLat,productLong;

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
    
    self.productImageUrl = productImageUrl;
    self.productCagegory = productCagegory;
    self.productPrice = productPrice;
    self.productDetails = productDetails;
    self.productLat  = productLat;
    self.productLong = productLong;
    
    //[[cell productImage] setImageWithURL:[NSURL URLWithString:[arrayOfImage objectAtIndex:indexPath.item]]];
    [[self getProductImage] setImageWithURL:[NSURL URLWithString:productImageUrl]];
    self.getProductCategory.text = productCagegory;
    self.getProductPrice.text = productPrice;
    self.getProductDetails.text = productDetails;
    
    [self.navigationController.navigationBar setTranslucent:YES];
}
- (void) setupUI
{
    [self.navigationItem setTitle:@"Get it"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Raleway" size:22]}];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnMapGeo:(id)sender {
    MapLocationViewController *vc = [[MapLocationViewController alloc] initWithNibName:@"MapLocationViewController" bundle:nil];
    vc.productLocationLat = productLat;
    vc.productLocationLong = productLong;
    [self presentViewController:vc animated:YES completion:nil];
}
@end
