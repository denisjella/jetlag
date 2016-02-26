//
//  CategoryCell.h
//  ToySeller
//
//  Created by stepanekdavid on 2/2/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell{
}
@property (weak, nonatomic) IBOutlet UILabel *categoryItem;

@property (nonatomic, strong) id delegate;
+ (CategoryCell *)sharedCell;
- (void)setCurCategoryItem:(NSString *)categoryItem;
@end
