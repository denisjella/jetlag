//
//  DateTableViewCell.m
//  ToySeller
//
//  Created by stepanekdavid on 2/3/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "DateTableViewCell.h"

@implementation DateTableViewCell

@synthesize delegate;
@synthesize dateItem = _dateItem;

+ (DateTableViewCell *)sharedCell
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DateTableViewCell" owner:nil options:nil];
    DateTableViewCell *cell = [array objectAtIndex:0];
    
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
- (void)setCurDateItem:(NSString *)dateItem
{
    _dateItem.text = dateItem;
    //[imgValid setImage:curCBEmail.valid ? [UIImage imageNamed:@"IconConfirm"] : [UIImage imageNamed:@"IconWarning"]];
    [self.dateItem setText:dateItem];
}

@end
