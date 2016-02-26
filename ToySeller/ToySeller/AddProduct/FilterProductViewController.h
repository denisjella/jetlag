//
//  FilterProductViewController.h
//  ToySeller
//
//  Created by stepanekdavid on 2/9/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterProductViewController : UIViewController<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *nameFilter;
@property (nonatomic, strong) NSMutableArray *imageFilter;
@property (nonatomic, strong) NSMutableArray *categoryFilter;
@property (nonatomic, strong) NSMutableArray *priceFilter;
@property (nonatomic, strong) NSMutableArray *detailsFilter;
@property (nonatomic, strong) NSMutableArray *latFilter;
@property (nonatomic, strong) NSMutableArray *longFilter;

@property (nonatomic, weak) IBOutlet UICollectionView *productFilterCollectionView;

@end
