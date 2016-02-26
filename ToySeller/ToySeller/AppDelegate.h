//
//  AppDelegate.h
//  ToySeller
//
//  Created by jellastar on 1/27/16.
//  Copyright © 2016 jellastar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class UserAccountViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UserAccountViewController *userAccountViewController;


@end

