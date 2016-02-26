//
//  DateTableViewCell.h
//  ToySeller
//
//  Created by stepanekdavid on 2/3/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateItem;

@property (nonatomic, strong) id delegate;
+ (DateTableViewCell *)sharedCell;
- (void)setCurDateItem:(NSString *)dateItem;

@end
