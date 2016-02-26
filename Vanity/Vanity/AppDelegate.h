#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SplashViewController.h"
#import "LoginViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//@property (strong, nonatomic) SplashViewController *viewController;
@property (strong, nonatomic) LoginViewController *viewController;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

