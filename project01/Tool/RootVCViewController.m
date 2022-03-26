//
//  RootVCViewController.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/24.
//

#import "RootVCViewController.h"

@interface RootVCViewController ()
@property(nonatomic,strong,readwrite)UINavigationController *controller;
@end

@implementation RootVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _controller.navigationBar.hidden = NO;
}


@end
