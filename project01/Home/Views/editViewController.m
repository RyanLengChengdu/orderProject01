//
//  AddViewController.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/17.
//

#import "editViewController.h"
#import "ListItem.h"
#import "FMDB.h"
#import <BRPickerView.h>
#import "Masonry.h"

@interface editViewController ()
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong,readwrite)UITextField *field1;
@property(nonatomic,strong,readwrite)UITextField *field2;
@property(nonatomic,strong,readwrite)BRDatePickerView *datePickerView;
@property(nonatomic,strong,readwrite)UITextField *field3;
@property(nonatomic,strong,readwrite)UITextField *field4;
@property(nonatomic,strong,readwrite)UITextField *field5;
@property(nonatomic,strong,readwrite)UILabel *label0;
@property(nonatomic,strong,readwrite)UILabel *label1;
@property(nonatomic,strong,readwrite)UILabel *label2;
@property(nonatomic,strong,readwrite)UILabel *label3;
@property(nonatomic,strong,readwrite)UILabel *label4;
@property(nonatomic,strong,readwrite)UILabel *label5;
@property(nonatomic,strong,readwrite)UIButton *button;
@property(nonatomic,strong,readwrite)ListItem *item;


@end

@implementation editViewController
-(instancetype)init{
    if ([super init]) {
        
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    //[super viewWillDisappear:animated];
    //保存 删除操作
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //查询item
    NSString *itemNumber=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"editRow"]];
    
    
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userDBPath=[doc stringByAppendingPathComponent:@"user.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:userDBPath];
    if (![db open]) {
        NSLog(@"打开失败");
        return;
    }else{
        //拼接sql userdefault
        NSMutableString *sql = [NSMutableString string];
        [sql appendString:@"SELECT * FROM "];
        NSString * tableName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        
        
        if (tableName != nil) {
            [sql appendString:tableName];
            [sql appendString:@" where id = "];
            [sql appendString:itemNumber];
        }
        FMResultSet *rs = [db executeQuery:sql];
        _item = [[ListItem alloc]init];
        while ([rs next]) {
            _item.amount = [rs stringForColumn:@"amount"];
            _item.deliveryTime = [rs stringForColumn:@"deliveryTime"];
            _item.username = [rs stringForColumn:@"username"];
            _item.phone = [rs stringForColumn:@"phone"];
            _item.address = [rs stringForColumn:@"address"];
        }
        [db close];
    
}
    //表单
    [self.view addSubview:({
        _label1 = [[UILabel alloc]init];
        _label1.text = @"数量";
        _label1.font = [UIFont systemFontOfSize:14];
        [_label1 sizeToFit];
        _label1;
    })];
    
    [self.view addSubview:({
        _field1 = [[UITextField alloc]init];
        _field1.placeholder = _item.amount;
        _field1.borderStyle = UITextBorderStyleRoundedRect;
        _field1.layer.borderWidth = 0.5f;
        _field1.layer.borderColor = [[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = @"斤";
        //label1.textColor = [UIColor redColor];
        _field1.rightView = label1;
        _field1.rightViewMode = UITextFieldViewModeAlways;
        _field1;
    })];
    [_field1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(97);
        make.left.equalTo(self.view).with.offset(20);
        make.height.equalTo(self.view.mas_height).multipliedBy(44.0/667);
        make.centerX.mas_equalTo(0);
    }];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_field1.mas_left).with.offset(0);
        make.bottom.equalTo(_field1.mas_top).with.offset(0);
    }];
    
    [self.view addSubview:({
        _label2 = [[UILabel alloc]init];
        _label2.text = @"配送时间";
        _label2.font = [UIFont systemFontOfSize:14];
        [_label2 sizeToFit];
        _label2;
    })];
    
    [self.view addSubview:({
        _field2 = [[UITextField alloc]init];
        _datePickerView = [[BRDatePickerView alloc]init];
                _datePickerView.pickerMode = BRDatePickerModeYMDH;
        _datePickerView.showUnitType = BRShowUnitTypeOnlyCenter;
                //_datePickerView.title = @"请选择时间";
                _datePickerView.showToday = YES;
                _datePickerView.selectDate = [NSDate date];
                _datePickerView.minDate = [NSDate date];
                _datePickerView.maxDate = [NSDate br_setYear:2022 month:12 day:30 hour:24];
                _datePickerView.isAutoSelect = YES;
        __weak typeof(self)weakSelf = self;
                _datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                    __strong typeof(self)strongSelf = weakSelf;
                    //NSLog(@"选择的值：%@", selectValue);
                    NSMutableString *str = [NSMutableString string];
                    [str appendString:selectValue];
                    [str appendString:@":00-"];
                    [str appendString:[NSString stringWithFormat:@"%ld",(long)selectDate.br_hour+1]];
                    [str appendString:@":00"];
                    strongSelf.field2.text = str;
                };
        
                BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
        customStyle.pickerColor = [UIColor whiteColor];
        customStyle.selectRowTextColor = [UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1];
                customStyle.separatorColor = [UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1];
                _datePickerView.pickerStyle = customStyle;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_show)];
        [_field2 addGestureRecognizer:recognizer];
                //[_datePickerView show];
        
        
                _field2.inputView = _datePickerView;
                
                
                
                _field2.placeholder = _item.deliveryTime;
                _field2.borderStyle = UITextBorderStyleRoundedRect;
                _field2.layer.borderWidth = 0.5f;
                _field2.layer.borderColor = [[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
                [_field2.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1])];
                _field2;
        
//
//        _datePickerView;
        
        
    })];
    
    [_field2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_field1.mas_bottom).with.offset(33);
        make.left.equalTo(self.view).with.offset(20);
        make.height.equalTo(self.view.mas_height).multipliedBy(44.0/667);
        make.centerX.mas_equalTo(0);
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_field2.mas_left).with.offset(0);
        make.bottom.equalTo(_field2.mas_top).with.offset(0);
    }];
//

    
    [self.view addSubview:({
        _label3 = [[UILabel alloc]initWithFrame:CGRectMake(19.5,156+77,27.5,13)];
        _label3.text = @"姓名";
        _label3.font = [UIFont systemFontOfSize:14];
        [_label3 sizeToFit];
        _label3;
    })];
    
    [self.view addSubview:({
        _field3 = [[UITextField alloc]init];
        _field3.placeholder = _item.username;
        _field3.borderStyle = UITextBorderStyleRoundedRect;
        _field3.layer.borderWidth = 0.5f;
        _field3.layer.borderColor = [[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
        [_field3.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1])];
        _field3;
    })];
    [_field3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_field2.mas_bottom).with.offset(33);
        make.left.equalTo(self.view).with.offset(20);
        make.height.equalTo(self.view.mas_height).multipliedBy(44.0/667);
        make.centerX.mas_equalTo(0);
    }];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_field3.mas_left).with.offset(0);
        make.bottom.equalTo(_field3.mas_top).with.offset(0);
    }];
    [self.view addSubview:({
        _label4 = [[UILabel alloc]initWithFrame:CGRectMake(19.5,156+77+77,27.5,13)];
        _label4.text = @"手机";
        _label4.font = [UIFont systemFontOfSize:14];
        [_label4 sizeToFit];
        _label4;
    })];
    
    [self.view addSubview:({
        _field4 = [[UITextField alloc]init];
        _field4.placeholder = _item.phone;
        _field4.borderStyle = UITextBorderStyleRoundedRect;
        _field4.layer.borderWidth = 1.0f;
        _field4.layer.borderColor = [[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
        [_field4.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1])];
        _field4;
    })];
    [_field4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_field3.mas_bottom).with.offset(33);
        make.left.equalTo(self.view).with.offset(20);
        make.height.equalTo(self.view.mas_height).multipliedBy(44.0/667);
        make.centerX.mas_equalTo(0);
    }];
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_field4.mas_left).with.offset(0);
        make.bottom.equalTo(_field4.mas_top).with.offset(0);
    }];
    [self.view addSubview:({
        _label5 = [[UILabel alloc]initWithFrame:CGRectMake(19.5,156+231,27.5,13)];
        _label5.text = @"地址";
        _label5.font = [UIFont systemFontOfSize:14];
        [_label5 sizeToFit];
        _label5;
    })];
    
    [self.view addSubview:({
        _field5 = [[UITextField alloc]init];
        _field5.placeholder = _item.address;
        _field5.borderStyle = UITextBorderStyleRoundedRect;
        _field5.layer.borderWidth = 0.5f;
        _field5.layer.borderColor = [[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
        [_field5.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1])];
        _field5;
    })];
    [_field5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_field4.mas_bottom).with.offset(33);
        make.left.equalTo(self.view).with.offset(20);
        make.height.equalTo(self.view.mas_height).multipliedBy(44.0/667);
        make.centerX.mas_equalTo(0);
    }];
    [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_field5.mas_left).with.offset(0);
        make.bottom.equalTo(_field5.mas_top).with.offset(0);
    }];
    
    [self.view addSubview:({
        _button = [[UIButton alloc]init];
        _button.backgroundColor = [UIColor colorWithRed:137/255.0 green:210/255.0 blue:44/255.0 alpha:1.0];
        _button.layer.cornerRadius = 5;
        [_button setTitle:@"确定" forState:UIControlStateNormal];
        _button.titleLabel.textColor = [UIColor whiteColor];
        _button.backgroundColor = [UIColor systemGreenColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_recordButton)];
        [_button addGestureRecognizer:gesture];
        _button;
    })];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_field5.mas_bottom).with.offset(50);
        make.centerX.mas_equalTo(0);
        make.left.equalTo(self.view).with.offset(62.5);
        make.height.equalTo(self.view).multipliedBy(44.0/667);
    }];
    
}

-(void)_recordButton{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //获取用户表路径
    NSString *userDBPath=[doc stringByAppendingPathComponent:@"user.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:userDBPath];
        
    //拼接sql
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:@"INSERT INTO "];
    NSString *tableName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    [sql appendString:tableName];
    [sql appendString:@" (amount,deliveryTime,username,phone,address) VALUES (?,?,?,?,?);"];
        if ([db open]) {
            BOOL res = [db executeUpdate:sql,_field1.text,_field2.text,_field3.text,_field4.text,_field5.text];
            if (res) {
                NSLog(@"插入成功");
            }else{
                NSLog(@"失败");
            }
            [db close];
}
    _field1.text = @"";
    _field2.text = @"";
    _field3.text = @"";
    _field4.text = @"";
    _field5.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    //NSLog(@"%@",_array);
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

[_field1 resignFirstResponder];
    [_field2 resignFirstResponder];
    [_field3 resignFirstResponder];
    [_field4 resignFirstResponder];
    [_field5 resignFirstResponder];

}

-(void)selectDate{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"MM-dd HH:mm"];
//    [formatter setLocale:_dateLocale];
//    _field2.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_datePicker.date]];
}

-(void)_show{
    [_datePickerView show];
}
@end
