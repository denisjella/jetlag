//
//  TableCell.h
//  TableTestApp
//
//  Created by jellastar on 11/20/15.
//  Copyright (c) 2015 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong,nonatomic) IBOutlet UILabel *DescriptionLabel;
@property (strong,nonatomic) IBOutlet UIImageView *ThumbImage;

@end
