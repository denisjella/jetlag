//
//  ProductSearchViewController.h
//  ToySeller
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSearchViewController : UIViewController<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageArrayFree;
@property (nonatomic, strong) NSMutableArray *categoryArrayFree;
@property (nonatomic, strong) NSMutableArray *priceArrayFree;
@property (nonatomic, strong) NSMutableArray *detailsArrayFree;
@property (nonatomic, strong) NSMutableArray *latArrayFree;
@property (nonatomic, strong) NSMutableArray *longArrayFree;


@property (nonatomic, strong) NSMutableArray *imageArrayFixed;
@property (nonatomic, strong) NSMutableArray *categoryArrayFixed;
@property (nonatomic, strong) NSMutableArray *priceArrayFixed;
@property (nonatomic, strong) NSMutableArray *detailsArrayFixed;
@property (nonatomic, strong) NSMutableArray *latArrayFixed;
@property (nonatomic, strong) NSMutableArray *longArrayFixed;

@property (nonatomic, strong) NSString *mainStateProduct;

@property (nonatomic, weak) IBOutlet UICollectionView *freeProductCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *priceProductCollectionView;

@end
