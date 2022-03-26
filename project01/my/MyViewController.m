//
//  MyViewController.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/17.
//

#import "MyViewController.h"
#import "ViewController.h"
#import "AboutUsViewController.h"
#import "ViewController.h"
#import "selfInfoViewController.h"
#import "FMDB.h"
#import "WMZDialog.h"
#import "Masonry.h"
#import "ClearCacheTool.h"
//#import "selfInfoViewController2.h"
@interface MyViewController () <ViewControllerDelegate>
@property(nonatomic,strong,readwrite)UIImageView *imageView;
@property(nonatomic,strong,readwrite)UIView *loginView;
@property(nonatomic,strong,readwrite)UIView *view1;
@property(nonatomic,strong,readwrite)UIView *view2;
@property(nonatomic,strong,readwrite)UIView *view3;
@property(nonatomic,strong,readonly)NSMutableArray *arr;
@property(nonatomic,strong,readwrite)UILabel * label1;
@property(nonatomic,strong,readwrite)UILabel * label2;
@property(nonatomic,strong,readwrite)UIButton *button;
@property(nonatomic,strong,readwrite)UILabel * CenterLabel;
@property(nonatomic,strong,readwrite)UIImageView *my_img;
@property(nonatomic,strong,readwrite)UIImageView *my_icon_personal;
@property(nonatomic,strong,readwrite)UIImageView *my_icon_arrow1;
@property(nonatomic,strong,readwrite)UIImageView *my_icon_clear;
@property(nonatomic,strong,readwrite)UIImageView *my_icon_arrow2;
@property(nonatomic,strong,readwrite)UIImageView *my_icon_about;
@property(nonatomic,strong,readwrite)UIImageView *my_icon_arrow3;

@property(nonatomic,strong,readwrite)UILabel * my_label_person;
@property(nonatomic,strong,readwrite)UILabel * my_label_clear;
@property(nonatomic,strong,readwrite)UILabel * cacheLabel;
@property(nonatomic,strong,readwrite)UILabel * my_label_aboutUs;
//@property(nonatomic,strong,readwrite)
@end

@implementation MyViewController
-(instancetype)init{
    if ([super init]) {
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"tabar_my_normal"];
        
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabar_my_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
   
    
    //
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    self.label1.text = username == nil ? @"未登录":username ;
    self.label2.text = phone == nil ? @"点击登录": phone;
    [_label2 sizeToFit];
    if(![self.label1.text isEqualToString:@"未登录"]){
        [self.view addSubview:({
            _button = [[UIButton alloc]init];
            [_button setTitle:@"退出登录" forState:UIControlStateNormal];
            _button.backgroundColor = [UIColor colorWithRed:210.0/255 green:44.0/255 blue:44.0/255 alpha:1];
            
            _button;
        })];
            [_button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
                make.left.equalTo(self.view).with.offset(20);
                make.top.equalTo(_view3.mas_bottom).with.offset(50);
                make.height.equalTo(_view3.mas_height);
            }];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_resign)];
        [_button addGestureRecognizer:gesture];
    }
    NSString *username2 = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cacheSize = [NSString stringWithFormat:@"%fM",[ClearCacheTool folderSizeAtPath:doc]];
    _cacheLabel.text = username2 == nil ? @"0.0M": cacheSize;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
    ViewController *viewController = [[ViewController alloc]init];
    viewController.delegate = self;
    [self.view addSubview:({
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 225)];
        _imageView.image = [UIImage imageNamed:@"my_bg"];
        _imageView;
    })];
    [_imageView addSubview:({
        _CenterLabel = [[UILabel alloc]init];
        _CenterLabel.text = @"个人中心";
        _CenterLabel;
    })];
    [_CenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        BOOL res = IPHONE_X;
        if (!res) {
            make.top.equalTo(self.view).with.offset(34);
        }else{
            make.top.equalTo(self.view).with.offset(56);
        }
        
        make.centerX.mas_equalTo(0);
        
    }];
    [self.view addSubview:({
        _loginView = [[UIView alloc]initWithFrame:CGRectMake(20,79,335,175)];
        _loginView.backgroundColor = [UIColor whiteColor];
        _loginView.layer.shadowColor = [UIColor colorWithRed:137/255.0 green:210/255.0 blue:44/255.0 alpha:0.8].CGColor;
        _loginView.layer.shadowOffset = CGSizeMake(0,0);
        _loginView.layer.shadowOpacity = 1;
        _loginView.layer.shadowRadius = 25;
        _loginView.layer.cornerRadius = 5;
        _loginView;
    })];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_CenterLabel.mas_bottom).with.offset(28);
        make.centerX.mas_equalTo(0);
        make.left.equalTo(self.view).with.offset(20);
        make.height.equalTo(self.view).multipliedBy(175.0/667);
    }];
    [_loginView addSubview:({
        _my_img = [[UIImageView alloc]init];
        _my_img.image = [UIImage imageNamed:@"my_img"];
        _my_img;
    })];
    [_my_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.equalTo(_loginView.mas_width).multipliedBy(60.0/335);
        make.top.equalTo(_loginView.mas_top).with.offset(25);
        make.height.equalTo(_loginView.mas_height).multipliedBy(60.0/175);
    }];
    [_loginView addSubview:({
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake(145.5, 100, 44, 14)];
        _label1.text =  @"未登录";
        _label1.font = [UIFont systemFontOfSize:15];
        [_label1 sizeToFit];
        _label1;
    })];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(_my_img.mas_bottom).with.offset(15);
        
    }];
    [_loginView addSubview:({
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake(140, 127.5, 55, 13)];
        _label2.text = @"点击登录";
        _label2.font = [UIFont systemFontOfSize:14];
        [_label2 sizeToFit];
        _label2;
    })];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(_label1.mas_bottom).with.offset(14);
    }];
    
    
    
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_login)];
    [_loginView addGestureRecognizer:recognizer];

#pragma mark - 个人信息View
    
    [self.view addSubview:({
        _view1 = [[UIView alloc]init];
        _view1.backgroundColor = [UIColor whiteColor];
        _view1;
    })];
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(_loginView.mas_bottom).with.offset(50);
        make.height.equalTo(self.view).multipliedBy(44.0/667);
    }];
    
    [_view1 addSubview:({
        _my_icon_personal = [[UIImageView alloc]init];
        _my_icon_personal.image = [UIImage imageNamed:@"my_icon_personal"];
        _my_icon_personal;
    })];
    [_my_icon_personal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view1.mas_left).with.offset(16);
        //make.top.equalTo(_view1.mas_top).with.offset(11);
        make.centerY.mas_equalTo(_view1).with.offset(0);
    }];
    
    [_view1 addSubview:({
        _my_label_person = [[UILabel alloc]init];
        _my_label_person.text = @"个人信息";
        _my_label_person.font = [UIFont systemFontOfSize:14];
        [_my_label_person sizeToFit];
        _my_label_person;
    })];
    [_my_label_person mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view1.mas_top).with.offset(11);
        make.left.equalTo(_my_icon_personal.mas_right).with.offset(12);
        make.centerY.mas_equalTo(_view1).with.offset(0);
    }];
    
    [_view1 addSubview:({
        _my_icon_arrow1 = [[UIImageView alloc]initWithFrame:CGRectMake(309, 12, 12, 15)];
        _my_icon_arrow1.image = [UIImage imageNamed:@"my_icon_arrow"];
        _my_icon_arrow1;
    })];
    [_my_icon_arrow1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view1.mas_right).with.offset(-15);
        make.centerY.mas_equalTo(_view1).with.offset(0);
    }];
    
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_selfInfo)];
    [_view1 addGestureRecognizer:gesture1];
    
    
#pragma mark - 清除缓存view
    [self.view addSubview:({
        _view2 = [[UIView alloc]initWithFrame:CGRectMake(20,363,335,44)];
        _view2.backgroundColor = [UIColor whiteColor];
        _view2;
    })];
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(_view1.mas_bottom).with.offset(15);
        make.height.equalTo(self.view).multipliedBy(44.0/667);
    }];
    [_view2 addSubview:({
        _my_icon_clear = [[UIImageView alloc]init];
        _my_icon_clear.image = [UIImage imageNamed:@"my_icon_clear"];
        _my_icon_clear;
    })];
    [_my_icon_clear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view2.mas_left).with.offset(16);
        //make.top.equalTo(_view2.mas_top).with.offset(11);
        make.centerY.mas_equalTo(_view2).with.offset(0);
    }];
    
    
    [_view2 addSubview:({
        _my_label_clear = [[UILabel alloc]init];
        _my_label_clear.text = @"清除缓存";
        _my_label_clear.font = [UIFont systemFontOfSize:14];
        [_my_label_clear sizeToFit];
        _my_label_clear;
    })];
    [_my_label_clear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view2.mas_top).with.offset(11);
        make.left.equalTo(_my_icon_clear.mas_right).with.offset(12);
        make.centerY.mas_equalTo(_view2).with.offset(0);
    }];

    
    [_view2 addSubview:({
        _my_icon_arrow2 = [[UIImageView alloc]initWithFrame:CGRectMake(309, 12, 12, 15)];
        _my_icon_arrow2.image = [UIImage imageNamed:@"my_icon_arrow"];
        _my_icon_arrow2;
    })];
    [_my_icon_arrow2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view2.mas_right).with.offset(-15);
        make.centerY.mas_equalTo(_view2).with.offset(0);
    }];
    [_view2 addSubview:({
        _cacheLabel = [[UILabel alloc]init];
        
        _cacheLabel;
    })];
    [_cacheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_my_icon_arrow2.mas_left).with.offset(-10.5);
        make.top.equalTo(_view2.mas_top).with.offset(11);
        make.centerY.mas_equalTo(0);
    }];
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_deleteCache)];
    [_view2 addGestureRecognizer:gesture2];
    
#pragma mark - 关于我们view
    [self.view addSubview:({
        _view3 = [[UIView alloc]init];
        _view3.backgroundColor = [UIColor whiteColor];
        _view3;
    })];
    [_view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(_view2.mas_bottom).with.offset(15);
        make.height.equalTo(self.view).multipliedBy(44.0/667);
    }];
    [_view3 addSubview:({
        _my_icon_about = [[UIImageView alloc]initWithFrame:CGRectMake(16, 11, 19, 22)];
        _my_icon_about.image = [UIImage imageNamed:@"my_icon_about"];
        _my_icon_about;
    })];
    [_my_icon_about mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view3.mas_left).with.offset(16);
       // make.top.equalTo(_view3.mas_top).with.offset(11);
        make.centerY.mas_equalTo(_view3).with.offset(0);
    }];
    [_view3 addSubview:({
        _my_label_aboutUs = [[UILabel alloc]initWithFrame:CGRectMake(47,15.5,55.5,13)];
        _my_label_aboutUs.text = @"关于我们";
        _my_label_aboutUs.font = [UIFont systemFontOfSize:14];
        [_my_label_aboutUs sizeToFit];
        _my_label_aboutUs;
    })];
    [_my_label_aboutUs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view3.mas_top).with.offset(11);
        make.left.equalTo(_my_icon_about.mas_right).with.offset(12);
        make.centerY.mas_equalTo(_view3).with.offset(0);
    }];
    
    
    [_view3 addSubview:({
        _my_icon_arrow3 = [[UIImageView alloc]initWithFrame:CGRectMake(309, 12, 12, 15)];
        _my_icon_arrow3.image = [UIImage imageNamed:@"my_icon_arrow"];
        _my_icon_arrow3;
    })];
    [_my_icon_arrow3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view3.mas_right).with.offset(-15);
        make.centerY.mas_equalTo(_view3).with.offset(0);
    }];
    
    UITapGestureRecognizer *gesture3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_aboutUS)];
    [_view3 addGestureRecognizer:gesture3];
}

-(void)_login{
    ViewController *controller = [[ViewController alloc]init];
    controller.title = @"个人信息";
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)_selfInfo{
    selfInfoViewController *controller = [[selfInfoViewController alloc]init];
    controller.title = @"个人信息";
    //controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)_aboutUS{
    AboutUsViewController *aboutUsViewController = [[AboutUsViewController alloc]init];
    aboutUsViewController.title = @"关于我们";
    [self.navigationController pushViewController:aboutUsViewController animated:YES];
}

-(void)userArray:(NSMutableArray *)arr{
    //vc.delegate = self;
    _label1.text = [arr firstObject];
    [_label1 sizeToFit];
    _label2.text = [arr lastObject];
    [_label2 sizeToFit];
    [[NSUserDefaults standardUserDefaults] setObject:_label1.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:_label2.text forKey:@"phone"];
    [self createDeliveryTable];
    
//    [self.view addSubview:({
//        _button = [[UIButton alloc]init];
//        [_button setTitle:@"退出登录" forState:UIControlStateNormal];
//        _button.backgroundColor = [UIColor redColor];
//        _button;
//    })];
//    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(0);
//        make.left.equalTo(self.view).with.offset(20);
//        make.top.equalTo(_view3.mas_bottom).with.offset(50);
//        make.height.equalTo(_view3.mas_height);
//    }];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_resign)];
    [_button addGestureRecognizer:gesture];
}

//获取username和phone之后，根据用户名创建两个表（一个是配送表，一个记录表）
-(void)createDeliveryTable{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //获取用户表路径
    NSString *userDBPath=[doc stringByAppendingPathComponent:@"user.sqlite"];
    //创建用户表
    FMDatabase *db = [FMDatabase databaseWithPath:userDBPath];
        //self.db = db;
        if ([db open]) {
            //创建配送表
            NSMutableString *sql = [NSMutableString string];
            [sql appendString:@"CREATE TABLE IF NOT EXISTS "];
            [sql appendString:_label1.text];
            [sql appendString: @" (id integer PRIMARY KEY AUTOINCREMENT,amount text NOT NULL, deliveryTime text NOT NULL,username text NOT NULL,phone text NOT NULL,address text NOT NULL);"];
            BOOL res = [db executeUpdate:sql];
            if (res) {
                NSLog(@"建表成功");
            }else{
                NSLog(@"失败");
            }
            
            //创建记录表
            NSMutableString *sql2 = [NSMutableString string];
            [sql2 appendString:@"CREATE TABLE IF NOT EXISTS "];
            [sql2 appendString:_label1.text];
            [sql2 appendString: @"2 (id integer PRIMARY KEY AUTOINCREMENT,amount text NOT NULL, deliveryTime text NOT NULL,username text NOT NULL,phone text NOT NULL,address text NOT NULL);"];
            BOOL res2 = [db executeUpdate:sql2];
            if (res2) {
                NSLog(@"建表成功");
            }else{
                NSLog(@"失败");
            }
            [db close];
}
}

-(void)_resign{
    _label1.text = @"未登录";
    [_label1 sizeToFit];
    _label2.text = @"点击登录";
    [_label2 sizeToFit];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"phone"];
    [_button removeFromSuperview];
}

//清除缓存操作
-(void)_deleteCache{
    Dialog()
                //出现动画
                .wShowAnimationSet(AninatonZoomIn)
                //消失动画
                .wHideAnimationSet(AninatonZoomOut)
                .wEventCancelFinishSet(^(id anyID, id otherData) {})
                .wMessageSet(@"\n\n确定要清除缓存吗？\n")
                //.wTitleSet(@"这是一条标题\n这是一条标题")
                .wOKTitleSet(@"确定")
                
                .wCancelTitleSet(@"取消")
                .wMessageColorSet(DialogColor(0x333333))
                .wTitleColorSet(DialogColor(0x666666))
                .wOKColorSet([UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1])
                .wCancelColorSet([UIColor lightGrayColor])
                .wTitleFontSet(15)
                .wTypeSet(DialogTypeNornal)
                .wEventOKFinishSet(^(id anyID, id otherData) {
                    [ClearCacheTool clearCache];
                    }).wStart();
        _cacheLabel.text = @"0.0M";
}
@end


