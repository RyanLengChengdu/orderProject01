//
//  AboutUsViewController.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/18.
//

#import "AboutUsViewController.h"
#import "Masonry.h"
@interface AboutUsViewController ()
@property(nonatomic,strong,readwrite)UIView *circleView;
@property(nonatomic,strong,readwrite)UILabel *name;
@property(nonatomic,strong,readwrite)UILabel *version;
@end

@implementation AboutUsViewController

-(instancetype)init{
    if ([super init]) {
        
        [self.view addSubview:({
            _circleView = [[UIView alloc]init];
            _circleView.backgroundColor = [UIColor colorWithRed:181.0/255 green:181.0/255 blue:181.0/255 alpha:1];
            _circleView.layer.cornerRadius = 5;
            _circleView;
        })];
        [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.equalTo(self.view).with.offset(137.5);
            make.top.equalTo(self.mas_topLayoutGuideBottom).with.offset(40);
            make.height.equalTo(self.view).multipliedBy(100.0/667);
        }];
        [self.view addSubview:({
            _name = [[UILabel alloc]init];
            _name.text = @"农家蛋厂管理薄";
            [_name sizeToFit];
            _name;
        })];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(_circleView.mas_bottom).with.offset(25);
        }];
        [self.view addSubview:({
            _version = [[UILabel alloc]init];
            _version.text = @"v1.0";
            [_version sizeToFit];
            _version;
        })];
        [_version mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(_name.mas_bottom).with.offset(14.5);
        }];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}



@end
