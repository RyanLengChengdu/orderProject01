//
//  AppDelegate.h
//  project01
//
//  Created by 冷锐鹏 on 2022/3/17.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property(nonatomic,strong)UIWindow *window;
- (void)saveContext;


@end

