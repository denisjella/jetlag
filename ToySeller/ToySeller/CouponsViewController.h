//
//  CouponsViewController.h
//  ToySeller
//
//  Created by stepanekdavid on 2/3/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponsViewController : UIViewController<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *priceArray;
@property (nonatomic, strong) NSMutableArray *detailsArray;
@property (nonatomic, strong) NSMutableArray *latArray;
@property (nonatomic, strong) NSMutableArray *longArray;

@property (nonatomic, strong) NSString *mainStateCoupon;

@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;

@property (nonatomic, weak) IBOutlet UICollectionView *couponsCollectionView;
- (IBAction)btProductFilter:(id)sender;

@end
