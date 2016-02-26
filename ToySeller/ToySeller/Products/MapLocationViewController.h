//
//  MapLocationViewController.h
//  ToySeller
//
//  Created by stepanekdavid on 2/9/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapLocationViewController : UIViewController<UINavigationControllerDelegate,MKMapViewDelegate>{
    CLLocationManager *location;
}

@property (nonatomic, retain) NSString *productLocationLat;
@property (nonatomic, retain) NSString *productLocationLong;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIView *navView;

- (IBAction)onCancel:(id)sender;
@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;
@end
