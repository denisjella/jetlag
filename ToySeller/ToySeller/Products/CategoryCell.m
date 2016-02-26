//
//  CategoryCell.m
//  ToySeller
//
//  Created by stepanekdavid on 2/2/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

@synthesize delegate;
@synthesize categoryItem = _categoryItem;

+ (CategoryCell *)sharedCell
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:nil options:nil];
    CategoryCell *cell = [array objectAtIndex:0];
    
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    NSLog(@"Cell selected");
    // Configure the view for the selected state
}
- (void)setCurCategoryItem:(NSString *)categoryItem
{
    _categoryItem.text = categoryItem;
    //[imgValid setImage:curCBEmail.valid ? [UIImage imageNamed:@"IconConfirm"] : [UIImage imageNamed:@"IconWarning"]];
    [self.categoryItem setText:categoryItem];
}
@end
