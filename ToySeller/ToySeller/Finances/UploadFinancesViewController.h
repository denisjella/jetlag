//
//  UploadFinancesViewController.h
//  ToySeller
//
//  Created by stepanekdavid on 2/3/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadFinancesViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *lstDate;
    NSArray *lstMonth;
    
    BOOL showKeyboard;
}

@property (weak, nonatomic) IBOutlet UITextField *txtUploadBill;
@property (weak, nonatomic) IBOutlet UITableView *dateTableView;
@property (weak, nonatomic) IBOutlet UITableView *monthTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth;

- (IBAction)btnSearchClick:(id)sender;
- (IBAction)btAddClick:(id)sender;
- (IBAction)btnDateClick:(id)sender;
- (IBAction)btnMonthClick:(id)sender;

@end
