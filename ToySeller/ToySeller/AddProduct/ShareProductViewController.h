//
//  ShareProductViewController.h
//  ToySeller
//
//  Created by stepanekdavid on 2/9/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareProductViewController : UIViewController

@property (nonatomic, retain)  NSString *productImageUrl;
@property (nonatomic, retain)  NSString *productCagegory;
@property (nonatomic, retain) NSString *productPrice;
@property (nonatomic, retain) NSString *productDetails;
@property (nonatomic, retain) NSString *productLat;
@property (nonatomic, retain) NSString *productLong;

@property (weak, nonatomic) IBOutlet UIImageView *getProductImage;
@property (weak, nonatomic) IBOutlet UILabel *getProductName;
@property (weak, nonatomic) IBOutlet UILabel *getProductCategory;
@property (weak, nonatomic) IBOutlet UILabel *getProductPrice;
@property (weak, nonatomic) IBOutlet UILabel *getProductDetails;
- (IBAction)btnMapGeo:(id)sender;

- (IBAction)btnShareit:(id)sender;

@end
