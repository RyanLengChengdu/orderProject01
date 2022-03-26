//
//  ViewController.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/17.
//

#import "ViewController.h"
#import "project01-Swift.h"
#import <FMDB.h>
#import "Masonry.h"
@interface ViewController ()<UIApplicationDelegate,UITextFieldDelegate>
@property(nonatomic,strong,readwrite)UIButton *enterButton;
@property(nonatomic,strong,readwrite)NSMutableArray *array;
@property(nonatomic,strong,readwrite)UITextField *field1;
@property(nonatomic,strong,readwrite)UITextField *field2;
@property(nonatomic,strong,readwrite)UILabel *nameLabel;
@property(nonatomic,strong,readwrite)UILabel *phoneLabel;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ddViewController *ddvc = [[ddViewController alloc]init];
    [ddvc setname];
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
        _field1.placeholder = @"请输入姓名";
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
        _field2.placeholder = @"请输入手机号码";
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
    
    
    [self.view addSubview:({
        _enterButton = [[UIButton alloc]initWithFrame:CGRectMake(62.5,268,250,44)];
        [_enterButton setTitle:@"确定" forState:UIControlStateNormal];
        _enterButton.titleLabel.textColor = [UIColor whiteColor];
        _enterButton.backgroundColor = [UIColor systemGreenColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_loginMethod)];
        [_enterButton addGestureRecognizer:gesture];
        _enterButton;
    })];
    [_enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(62.5);
        make.top.equalTo(_field2.mas_bottom).with.offset(50);
        make.centerX.mas_equalTo(0);
        make.height.equalTo(self.view).multipliedBy(44.0/667);
    }];
}

-(void)_loginMethod{
    NSString *tt1 = _field1.text;
    [_array addObject:tt1];
    NSString *tt2 = _field2.text;
    [_array addObject:tt2];
    //获得数据库文件路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //获取用户表路径
    NSString *userDBPath=[doc stringByAppendingPathComponent:@"user.sqlite"];
    //创建用户表
    FMDatabase *db = [FMDatabase databaseWithPath:userDBPath];
        //self.db = db;
        if ([db open]) {
            BOOL res = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS user_tttt (id integer PRIMARY KEY AUTOINCREMENT,username text NOT NULL, phonenumber text NOT NULL);"];
            if (res) {
                NSLog(@"建表成功");
            }else{
                NSLog(@"失败");
            }
            
            BOOL res2 = [db executeUpdate:@"INSERT INTO user_tttt (username,phonenumber) VALUES (?, ?);", _array.firstObject, _array.lastObject];
                if (!res2) {
                    NSLog(@"增加数据失败");
                }else{
                    NSLog(@"增加数据成功");
                }
            
            FMResultSet *resultset = [db executeQuery:@"SELECT * FROM user_tttt"];
            while ([resultset next]) {
               NSString *str = [resultset stringForColumn:@"username"];
                NSLog(@"%@",str);
            }
            
            [db close];
            //跳转回主页面
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(userArray:)]) {
                [self.delegate userArray:_array];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    

    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    //NSLog(@"%@",_array);
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

[_field1 resignFirstResponder];
    [_field2 resignFirstResponder];

}
@end
