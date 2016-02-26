//
//  ProductInviteCollectionViewCell.m
//  ToySeller
//
//  Created by stepanekdavid on 2/9/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "ProductInviteCollectionViewCell.h"

@interface ProductInviteCollectionViewCell ()
@property (nonatomic, strong) UIImage *speakerImage;
@end

@implementation ProductInviteCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews
{
    if (!_speakerImage) {
        self.speakerImage = [UIImage imageNamed:@"heart_on.png"];
    }
    if(!self.isPlaying){
        self.imgHeart.image = [UIImage imageNamed:@"heart_off.png"];
    } else {
        self.imgHeart.image = _speakerImage;
        self.imgHeart.hidden =NO;
    }
    [super layoutSubviews];
}

-(void) setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected];
    if (!selected) {
        self.isPlaying = NO;
    }
}

-(void)setIsPlaying:(BOOL)isPlaying
{
    _isPlaying = isPlaying;
    [self setNeedsLayout];
}
@end
