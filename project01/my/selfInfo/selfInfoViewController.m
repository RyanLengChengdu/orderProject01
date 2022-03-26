//
//  ViewController.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/17.
//

#import "selfInfoViewController.h"
#import "Masonry.h"
@interface selfInfoViewController ()<UIApplicationDelegate,UITextFieldDelegate>
@property(nonatomic,strong,readwrite)NSMutableArray *array;
@property(nonatomic,strong,readwrite)UITextField *field1;
@property(nonatomic,strong,readwrite)UITextField *field2;
@property(nonatomic,strong,readwrite)UILabel *nameLabel;
@property(nonatomic,strong,readwrite)UILabel *phoneLabel;
@end

@implementation selfInfoViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ddViewController *ddvc = [[ddViewController alloc]init];
//    [ddvc setname];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _array = @[].mutableCopy;
    [self.view addSubview:({
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"姓名";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [_nameLabel sizeToFit];
        _nameLabel;
    })];
    
    [self.view addSubview:({
        _field1 = [[UITextField alloc]init];
        _field1.placeholder = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        _field1.allowsEditingTextAttributes = NO;
        _field1.borderStyle = UITextBorderStyleRoundedRect;
        _field1.layer.borderWidth = 0.5f;
        _field1.layer.borderColor = [[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
        //field1.layer.borderColor =
        _field1.delegate = self;
        _field1;
    })];
    [_field1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.mas_topLayoutGuideBottom).with.offset(46);
        make.height.equalTo(self.view).multipliedBy(44.0/667);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_field1.mas_left);
        make.bottom.equalTo(_field1.mas_top).with.offset(-5);
    }];
    
    [self.view addSubview:({
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = @"手机";
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        [_phoneLabel sizeToFit];
        _phoneLabel;
    })];
    
    [self.view addSubview:({
        _field2 = [[UITextField alloc]init];
        _field2.placeholder = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
        _field2.allowsEditingTextAttributes = NO;
        _field2.borderStyle = UITextBorderStyleRoundedRect;
        _field2.layer.borderWidth = 0.5f;
        _field2.layer.borderColor = [[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
        _field2.delegate = self;
        _field2;
    })];
    [_field2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_field1.mas_left);
        make.top.equalTo(_field1.mas_bottom).with.offset(33);
        make.centerX.mas_equalTo(0);
        make.height.equalTo(self.view).multipliedBy(44.0/667);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_field2.mas_left);
        make.bottom.equalTo(_field2.mas_top).with.offset(-5);
    }];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

[_field1 resignFirstResponder];
    [_field2 resignFirstResponder];

}
@end
