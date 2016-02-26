//
//  MainViewController.h
//  ToySeller
//
//  Created by stepanekdavid on 2/3/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate>{
    UIButton *btAddProduct;
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UIScrollView *scrView;
    
    __weak IBOutlet UITextField *txtNeed;
    NSArray *lstCategory;
    
    BOOL showKeyboard;
}
@property (weak, nonatomic) IBOutlet UIButton *btnProductCategory;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;


- (IBAction)btnCategoryClick:(id)sender;

@end
