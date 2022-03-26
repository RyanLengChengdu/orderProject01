//
//  ViewController.h
//  project01
//
//  Created by 冷锐鹏 on 2022/3/17.
//

#import <UIKit/UIKit.h>
#import "RootVCViewController.h"
@class ViewController;
@protocol ViewControllerDelegate <NSObject>
-(void)userArray:(NSMutableArray *)arr;
@end
@interface ViewController : RootVCViewController
@property(nonatomic,weak,readwrite)id <ViewControllerDelegate> delegate;
@end

