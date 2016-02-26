//
//  CouponSaveSearchViewController.h
//  ToySeller
//
//  Created by jellastar on 1/31/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponSaveSearchViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>{
    UIButton *btAddProduct;
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UIScrollView *scrView;
    
    NSArray *lstCategory;
    
    BOOL showKeyboard;
}
@property (weak, nonatomic) IBOutlet UIButton *btnProductCategory;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

- (IBAction)btnCategoryClick:(id)sender;
- (IBAction)btSearchClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@end
