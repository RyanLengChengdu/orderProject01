//
//  HomeViewController.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/17.
//

#import "HomeViewController.h"
#import <LYEmptyView/LYEmptyViewHeader.h>
#import "deliveryRecordViewController.h"
#import "HomeTableViewCell.h"
#import "DataLoader.h"
#import "FMDB.h"
#import "BRPickerView.h"
#import "HomeMoreButtonView.h"
#import "editViewController.h"
#import "Masonry.h"


@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource,HomeTableViewCellDelegate>
@property(nonatomic,strong,readwrite)UITableView *tableView;

@property(nonatomic,strong,readwrite)UIView *topView;
@property(nonatomic,strong,readwrite)UIButton *buttonLeft;
@property(nonatomic,strong,readwrite)UIButton *buttonRight;
@property(nonatomic,strong,readwrite)UILabel * label0;

@property(nonatomic,strong,readwrite)DataLoader *dataLoader;
@property(nonatomic,strong,readwrite)NSMutableArray *dataArray;
@property(nonatomic,strong,readwrite)BRDatePickerView *datePickerView;
@property(nonatomic,strong,readwrite)UIImageView *placeholderImageView;
@property(nonatomic,strong,readwrite)UILabel *label;
@property(nonatomic,strong,readwrite)UILabel *dateLabel;



@end

@implementation HomeViewController
-(instancetype)init{
    if ([super init]) {
        self.tabBarItem.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"tabar_home_normal"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    //tableView相关
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView addSubview:({
        _placeholderImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_Img"]];
        //_placeholderImageView.frame = CGRectMake(75, 219, 225, 169.5);
        _placeholderImageView;
    })];
    [_tableView addSubview:({
        _label = [[UILabel alloc]init];
        _label.text = @"目前还没有订单，去’添加‘";
        [_label sizeToFit];
        _label;
    })];
    
    [_placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.equalTo(self.view).with.offset(75);
        make.height.equalTo(self.view).multipliedBy(169.5/667);
        make.centerY.mas_equalTo(self.view).with.offset(-50);
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_placeholderImageView.mas_bottom);
        make.centerX.mas_equalTo(0);
        
    }];
    
    [self getDataFromDb];
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _dateLabel.text = @"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    ddViewController *viewc = [[ddViewController alloc]init];
//    [ddViewController ]
    [self.view addSubview:({
        BOOL res = IPHONE_X;
        if (!res) {
            _topView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,64)];
        }else{
            _topView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,88)];
        }
        
        [_topView setBackgroundColor:[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1]];
        //_topView.userInteractionEnabled = YES;
        _topView;
    })];
    
    //首页label
    [self.view addSubview:({
        _label0 = [[UILabel alloc]init];
        _label0.text = @"首页";
        _label0;
    })];
    [_label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_topView.mas_bottom).with.offset(-15);
        make.centerX.mas_equalTo(0);
    }];
    //buttonLeft
    [_topView addSubview:({
        _buttonLeft = [[UIButton alloc]init];
        [_buttonLeft setImage:[UIImage imageNamed:@"nav_calendar"] forState:UIControlStateNormal];
        _datePickerView = [[BRDatePickerView alloc]init];
                _datePickerView.pickerMode = BRDatePickerModeMD;
        _datePickerView.showUnitType = BRShowUnitTypeOnlyCenter;
                _datePickerView.title = @"请选择时间";
                _datePickerView.showToday = YES;
                _datePickerView.selectDate = [NSDate date];
                _datePickerView.minDate = [NSDate br_setMonth:1 day:1];
                _datePickerView.maxDate = [NSDate br_setMonth:12 day:30];
                _datePickerView.isAutoSelect = YES;
        __weak typeof(self)weakSelf = self;
                _datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
                    __strong typeof(self)strongSelf = weakSelf;
                    //NSLog(@"选择的值：%@", selectValue);
                    NSMutableString *str = [NSMutableString string];
                    [str appendString:@"2022-"];
                    [str appendString:selectValue];
                    NSLog(@"%@",str);
                    //将selectValue的值赋值给leftButton的右边label.text
                    strongSelf.dateLabel.text = selectValue;
                    [strongSelf.dateLabel sizeToFit];
                    //根据str查询数据库
                    [strongSelf getDataFromDBWithStr:str];
                    
                    //刷新tableview
                };
        
                BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
        customStyle.pickerColor = [UIColor whiteColor];
        customStyle.selectRowTextColor = [UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1];
                customStyle.separatorColor = [UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1];
                _datePickerView.pickerStyle = customStyle;
        UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_showDatePicker)];
        [_buttonLeft addGestureRecognizer:recognizer2];
        _buttonLeft;
    })];
    [_buttonLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.bottom.equalTo(_topView.mas_bottom).with.offset(-15);
    }];
    //左边按钮 还需要当日时间
    [_topView addSubview:({
        _dateLabel = [[UILabel alloc]init];
        _dateLabel;
    })];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_buttonLeft.mas_right).with.offset(5.5);
        make.bottom.equalTo(_topView.mas_bottom).with.offset(-15);
    }];
    //右边按钮
    [self.view addSubview:({
        //_topView.userInteractionEnabled = YES;
        //self.view.userInteractionEnabled = YES;
        self.navigationController.navigationBar.hidden = YES;
        _buttonRight = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20-21.5, 31.5, 22, 22)];
        _buttonRight.userInteractionEnabled = YES;
        [_buttonRight setImage:[UIImage imageNamed:@"nav_record"] forState:UIControlStateNormal];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_jumpTodeliveryRecord)];
        [_buttonRight addGestureRecognizer:recognizer];
//        [self.buttonRight addTarget:self action:@selector(_jumpTodeliveryRecord:) forControlEvents:UIControlEventTouchUpInside];
        _buttonRight;
    })];
    [_buttonRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-20);
        make.bottom.equalTo(_topView.mas_bottom).with.offset(-15);
    }];
}





-(void)_jumpTodeliveryRecord{
    deliveryRecordViewController *recordViewController = [[deliveryRecordViewController alloc]init];
    recordViewController.title = @"配送记录";
    [self.navigationController pushViewController:recordViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell layoutWithItem:[_dataArray objectAtIndex:indexPath.row]];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (197.5/667)* [UIScreen mainScreen].bounds.size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}


//delegate自定义代理方法
- (void)tableViewCell:(UITableViewCell *)tableViewCell idd:(NSInteger *)idd{
    
    //根据idd找到该条数据 复制到record表
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //获取用户表路径
    NSString *userDBPath=[doc stringByAppendingPathComponent:@"user.sqlite"];
    //创建用户表
    FMDatabase *db = [FMDatabase databaseWithPath:userDBPath];
        //self.db = db;
        if ([db open]) {
            //创建配送表
//            NSMutableString *sql = [NSMutableString string];
//            [sql appendString:@"DELETE FROM "];
            NSString * tableName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where id = %d",tableName,(int)idd];
//            [sql appendString:tableName];
//            [sql appendString: @" WHERE id = '%d'",idd];
            BOOL res = [db executeUpdate:sql];
            if (res) {
                NSLog(@"建表成功");
            }else{
                NSLog(@"失败");
            }
            [db close];
        }
    //根据idd删除配送表中的数据
    
    //在ViewController中删除该条数据
    //[self getDataFromDb];
    
    [_dataArray removeObjectAtIndex:[_tableView indexPathForCell:tableViewCell].row];
    [_tableView reloadData];
    
    //[_tableView deleteRowsAtIndexPaths:@[[_tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
}



-(void)tableViewCell:(UITableViewCell *)tableViewCell clickDotView:(UIImageView *)dotImageView idd:(NSInteger *)idd{
    HomeMoreButtonView *moreButtonView = [[HomeMoreButtonView alloc]initWithFrame:self.view.bounds];
    CGRect rect = [tableViewCell convertRect:dotImageView.frame toView:nil];
    [[NSUserDefaults standardUserDefaults]setObject:@([_tableView indexPathForCell:tableViewCell].row) forKey:@"editRow"];
    __weak typeof(self) weakself = self;
        //点击deletecellview 调用block删除cell
        [moreButtonView showDeleteViewFromPoint:CGPointMake(rect.origin.x, rect.origin.y) clickBlock:^{
            __strong typeof(self)strongself = weakself;
            NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            //获取用户表路径
            NSString *userDBPath=[doc stringByAppendingPathComponent:@"user.sqlite"];
            //创建用户表
            FMDatabase *db = [FMDatabase databaseWithPath:userDBPath];
                //self.db = db;
                if ([db open]) {
                    //创建配送表
        //            NSMutableString *sql = [NSMutableString string];
        //            [sql appendString:@"DELETE FROM "];
                    NSString * tableName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
                    NSString *sql = [NSString stringWithFormat:@"delete from %@ where id = %d",tableName,(int)idd];
        //            [sql appendString:tableName];
        //            [sql appendString: @" WHERE id = '%d'",idd];
                    BOOL res = [db executeUpdate:sql];
                    if (res) {
                        NSLog(@"建表成功");
                    }else{
                        NSLog(@"失败");
                    }
                    [db close];
                }
            //根据idd删除配送表中的数据
            
            //在ViewController中删除该条数据
            //[self getDataFromDb];
            
            [strongself.dataArray removeObjectAtIndex:[_tableView indexPathForCell:tableViewCell].row];
            [strongself.tableView reloadData];
        }];
            
            
            
//            //block作用：删除cell
//            __strong typeof(self)strongself = weakself;
//
//            //在此处增加数据库的逻辑
//            [strongself _deleteItemWithIdd:idd];
//            [strongself.dataArray removeObjectAtIndex:[strongself.tableView indexPathForCell:tableViewCell].row];
//            //[strongself.tableView deleteRowsAtIndexPaths:@[[strongself.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
//            [strongself.tableView reloadData];

    __weak typeof(self) weakself2 = self;
    [moreButtonView showDeleteViewFromPoint:CGPointMake(rect.origin.x, rect.origin.y) clickBlock2:^{
        __strong typeof(self)strongself = weakself2;
        editViewController *editVC = [[editViewController alloc]init];
        [[NSUserDefaults standardUserDefaults]setObject:@([strongself.tableView indexPathForCell:tableViewCell].row+1) forKey:@"editRow"];
        editVC.title = @"编辑订单";
        [strongself.navigationController pushViewController:editVC animated:YES];
    }];
    
    
    
}


-(void)getDataFromDb{
    //获取数据
    self.dataLoader = [[DataLoader alloc]init];
    __weak typeof(self)weakSelf = self;
    [self.dataLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<ListItem *> *dataArray) {
        __strong typeof(self)strongSelf = weakSelf;
        strongSelf.dataArray = dataArray.mutableCopy;
        [strongSelf.tableView reloadData];
        
        if (strongSelf.dataArray != nil && ![strongSelf.dataArray isKindOfClass:[NSNull class]] && strongSelf.dataArray.count != 0){
            [strongSelf.placeholderImageView  removeFromSuperview];
            [strongSelf.label removeFromSuperview];
        }
    }];
}

-(void)getDataFromDBWithStr:(NSString *)str{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userDBPath=[doc stringByAppendingPathComponent:@"user.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:userDBPath];
    if (![db open]) {
        NSLog(@"打开失败");
        return;
    }else{
        //拼接sql userdefault
        NSString *tableName = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE deliveryTime like '%@%%'",tableName,str];

        FMResultSet *rs = [db executeQuery:sql];
        NSMutableArray *listItemArray = @[].mutableCopy;
        while ([rs next]) {
            ListItem *item = [[ListItem alloc]init];
            item.idd = (NSInteger *)[rs intForColumn:@"id"];
            item.amount = [rs stringForColumn:@"amount"];
            item.deliveryTime = [rs stringForColumn:@"deliveryTime"];
            item.username = [rs stringForColumn:@"username"];
            item.phone = [rs stringForColumn:@"phone"];
            item.address = [rs stringForColumn:@"address"];
            [listItemArray addObject:item];
        }
        _dataArray = listItemArray;
        [db close];
        [_tableView reloadData];
        if (_dataArray != nil && ![_dataArray isKindOfClass:[NSNull class]] && _dataArray.count != 0){
            [_placeholderImageView  removeFromSuperview];
            [_label removeFromSuperview];
        }
}
}

-(void)_showDatePicker{
    [_datePickerView show];
}

-(void)_deleteItemWithIdd:(NSInteger *)idd{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userDBPath=[doc stringByAppendingPathComponent:@"user.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:userDBPath];
    if (![db open]) {
        NSLog(@"打开失败");
        return;
    }else{
        NSString * tableName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where id = %d",tableName,(int)idd];
        BOOL res  = [db executeQuery:sql];
        [db close];
        //[_tableView reloadData];
        if (res) {
            NSLog(@"建表成功");
        }else{
            NSLog(@"失败");
        }
        [db close];
    
}
}
@end
