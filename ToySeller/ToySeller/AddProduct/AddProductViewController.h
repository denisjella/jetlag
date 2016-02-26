//
//  AddProductViewController.h
//  ToySeller
//
//  Created by jellastar on 1/28/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddProductViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>{
    __weak IBOutlet UIScrollView *scrView;
    
    __weak IBOutlet UITextField *txtPrice;
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UIImageView *priceImage;
    
    NSArray *lstCategory;
    
    BOOL showKeyboard;
    
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UIImageView *addProductImage;
@property (weak, nonatomic) IBOutlet UIButton *btnProductCategory;
@property (weak, nonatomic) IBOutlet UITableView *catetoryTableView;
@property (weak, nonatomic) IBOutlet UISwitch *freeSwitch;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@property (nonatomic, retain) IBOutlet UIView *navView;
- (IBAction)onCancel:(id)sender;

- (IBAction)productAdd:(id)sender;

- (IBAction)AddPhoto:(id)sender;

- (IBAction)btnCategoryClick:(id)sender;

@end
