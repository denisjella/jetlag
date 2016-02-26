//
//  SearchViewController.h
//  ToySeller
//
//  Created by jellastar on 1/28/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>{
    UIButton *btAddProduct;
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UIScrollView *scrView;
    
    NSArray *lstCategory;
    
    BOOL showKeyboard;
}

@property (nonatomic, strong) NSString *selectedPanel;

@property (weak, nonatomic) IBOutlet UIButton *btnProductCategory;
@property (weak, nonatomic) IBOutlet UITableView *catetoryTableView;

- (IBAction)btnCategoryClick:(id)sender;
- (IBAction)btSearchClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end
