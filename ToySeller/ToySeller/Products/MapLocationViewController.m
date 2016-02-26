//
//  MapLocationViewController.m
//  ToySeller
//
//  Created by stepanekdavid on 2/9/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import "MapLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"
@interface MapLocationViewController ()

@end

@implementation MapLocationViewController

@synthesize productLocationLat;
@synthesize productLocationLong;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setTranslucent:YES];
    
    self.productLocationLat = productLocationLat;
    self.productLocationLong = productLocationLong;
    
    NSLog(@"jella---------%@",productLocationLat);
    NSLog(@"jella---------%@",productLocationLong);
    self.mapView.delegate = self;
    
    self.mapView.showsUserLocation = YES;
    self.mapView.showsBuildings = YES;
    
    
    MKCoordinateRegion region = {{0.0, 0.0}, {0.0, 0.0}};
    region.center.latitude = [productLocationLat intValue];
    region.center.longitude = [productLocationLong intValue];
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [self.mapView setRegion:region animated:YES];
    
    MapPin *ann = [[MapPin alloc] init];
    ann.title = @"test";
    ann.subtitle = @"ads";
    ann.coordinate = region.center;
    [self.mapView addAnnotation:ann];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
