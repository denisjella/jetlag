//
//  ProductCellCollectionViewCell.h
//  ToySeller
//
//  Created by jellastar on 1/28/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCellCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productCategory;
@property (weak, nonatomic) IBOutlet UILabel *productEachPrice;

@end
