//
//  GeoCoderViewController.m
//  MapSample
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "GeoCoderViewController.h"
#import "APTimeZones.h"

@interface GeoCoderViewController ()

@end

@implementation GeoCoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIText Field Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self geocodeCityZoneWithText:textField.text];
    return YES;
}

-(void)geocodeCityZoneWithText:(NSString *)text{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:text completionHandler:^(NSArray *placemarks, NSError *error){
        if(placemarks.count){
            CLPlacemark *placemark = placemarks[0];
            _textView.text = placemark.timeZone.description;
        }
    }];
}
@end
