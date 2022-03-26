//
//  AppDelegate.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/17.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "AddViewController.h"
#import "MyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    homeViewController.title = @"首页";
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(_share)];
        homeViewController.navigationItem.rightBarButtonItem = button;
    
    
    AddViewController *addViewController = [[AddViewController alloc]init];
    addViewController.title = @"添加订单";
    MyViewController *myViewController = [[MyViewController alloc]init];
    
    [tabBarController setViewControllers:@[homeViewController,addViewController,myViewController]];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:tabBarController];
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

-(void)_share{
    
}
#pragma mark - UISceneSession lifecycle
-(void)applicationWillResignActive:(UIApplication *)application{
    
}
-(void)applicationDidEnterBackground:(UIApplication *)application{
    
}
-(void)applicationWillEnterForeground:(UIApplication *)application{
    
}
-(void)applicationDidBecomeActive:(UIApplication *)application{
    
}
- (void)applicationWillTerminate:(UIApplication *)application{
    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"username"];
    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"phone"];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"project01"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
