//
//  ProductInviteCollectionViewCell.h
//  ToySeller
//
//  Created by stepanekdavid on 2/9/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductInviteCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isPlaying;

@property (weak, nonatomic) IBOutlet UILabel *txtProductName;
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeart;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
@end
