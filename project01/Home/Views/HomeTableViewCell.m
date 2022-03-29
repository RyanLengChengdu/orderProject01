//
//  HomeTableViewCell.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/23.
//

#import "HomeTableViewCell.h"
#import "Masonry.h"
#import "ListItem.h"
#import "WMZDialog.h"
#import "FMDB.h"
#import <WebKit/WebKit.h>
@interface HomeTableViewCell ()
@property(nonatomic,strong,readwrite)UILabel *deliveryTimeLabel;
@property(nonatomic,strong,readwrite)UILabel *completeLabel;//我已送达按钮
@property(nonatomic,strong,readwrite)UILabel *amoutLabel;
@property(nonatomic,strong,readwrite)UILabel *buyerLabel;
@property(nonatomic,strong,readwrite)UILabel *phoneLabel;
@property(nonatomic,copy,readwrite)NSString *numberr;
@property(nonatomic,strong,readwrite)UIImageView *phoneImageView;
@property(nonatomic,strong,readwrite)UILabel *destinationLabel;
@property(nonatomic,strong,readwrite)UIImageView *placeImageView;
@property(nonatomic,strong,readwrite)UIView *lineView;
@property(nonatomic,strong,readwrite)UIView *squareView;
//右下角三个点
@property(nonatomic,strong,readwrite)UIImageView *dotImageView;
@property(nonatomic,readwrite)NSInteger *ItemID;
@end

@implementation HomeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self.contentView addSubview:({
            self.squareView = [[UIView alloc]init];
            self.squareView.layer.borderColor =[[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
            self.squareView.layer.borderWidth = 1;
            self.squareView;
        })];
        
        [self.contentView addSubview:({
            self.deliveryTimeLabel = [[UILabel alloc]init];
            //self.deliveryTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 217, 44)];
            _deliveryTimeLabel.textColor = [UIColor whiteColor];
            self.deliveryTimeLabel.backgroundColor = [UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0];
            self.deliveryTimeLabel;
        })];
        
        [self.contentView addSubview:({
            _completeLabel = [[UILabel alloc]init];
            _completeLabel.layer.borderColor = [[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
            _completeLabel.layer.borderWidth = 1;
            _completeLabel.userInteractionEnabled = YES;
            _completeLabel.text = @">> 我已送达";
            _completeLabel.textColor = [UIColor colorWithRed:251.0/255 green:177.0/255 blue:0 alpha:1.0];
            //_completeLabel.backgroundColor = [UIColor redColor];
            _completeLabel.textAlignment = NSTextAlignmentCenter;
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_deleteLabelClick)];
            [_completeLabel addGestureRecognizer:recognizer];
            _completeLabel;
        })];
        
        [self.contentView addSubview:({
            self.amoutLabel = [[UILabel alloc]init];
            //self.amoutLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.5, 59, 145, 13)];
            //self.amoutLabel.backgroundColor = [UIColor lightGrayColor];
            self.amoutLabel;
        })];
        
        [self.contentView addSubview:({
            self.buyerLabel = [[UILabel alloc]init];
            //self.buyerLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.5, 59+28, 145, 13)];
            //self.buyerLabel.backgroundColor = [UIColor lightGrayColor];
            self.buyerLabel;
        })];
        
        [self.contentView addSubview:({
            self.phoneLabel = [[UILabel alloc]init];
            //self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.5, 59+28+28, 145, 13)];
            //self.phoneLabel.backgroundColor = [UIColor lightGrayColor];
            self.phoneLabel;
        })];
        
        [self.contentView addSubview:({
            self.phoneImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_icon_call"]];
            _phoneImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_call)];
            [self.phoneImageView addGestureRecognizer:recognizer2];
            self.phoneImageView;
        })];
        
        //横线
        [self.contentView addSubview:({
            self.lineView = [[UIView alloc]init];
            self.lineView.backgroundColor = [UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1];
            self.lineView.layer.borderColor =[[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0] CGColor];
            self.lineView.layer.borderWidth = 1;
            self.lineView;
        })];
        [self.contentView addSubview:({
            self.destinationLabel = [[UILabel alloc]init];
            self.destinationLabel.textColor = [UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1.0];
            self.destinationLabel;
        })];
        [self.contentView addSubview:({
            self.placeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_icon_address"]];
            self.placeImageView;
        })];
        [self.contentView addSubview:({
            self.dotImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_icon_more"]];
            _dotImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_dotViewClick)];
            [_dotImageView addGestureRecognizer:recognizer];
            self.dotImageView;
        })];
        
        //写约束
        
        [_squareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(20);
            make.top.equalTo(self.mas_top).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.height.equalTo(self.mas_height).multipliedBy(177.5/187.5);
        }];
        
        //配送时间
        [_deliveryTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(20);
            make.width.equalTo(self.mas_width).with.multipliedBy(217.0/375);
            make.height.equalTo(self.mas_height).with.multipliedBy(44.0/187.5);
        }];
        
        //配送完成
        [_completeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_deliveryTimeLabel.mas_top).with.offset(0);
            make.left.equalTo(_deliveryTimeLabel.mas_right).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.height.equalTo(self.mas_height).with.multipliedBy(44.0/187.5);
        }];
        
        [_amoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(35.5);
            make.top.equalTo(_completeLabel.mas_bottom).with.offset(15);
            make.height.equalTo(self.mas_height).with.multipliedBy(13.0/187.5);
            make.width.equalTo(self.mas_width).multipliedBy(0.75);
        }];
        
        [_buyerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(35.5);
            make.top.equalTo(_amoutLabel.mas_bottom).with.offset(15);
            make.height.equalTo(self.mas_height).with.multipliedBy(13.0/187.5);
            make.width.equalTo(self.mas_width).multipliedBy(0.75);
        }];
        
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(35.5);
            make.top.equalTo(_buyerLabel.mas_bottom).with.offset(15);
            make.height.equalTo(self.mas_height).with.multipliedBy(13.0/187.5);
            make.width.equalTo(self.mas_width).multipliedBy(0.75);
        }];
        
        [_phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.top.equalTo(_phoneLabel.mas_top).offset(0);
            make.right.equalTo(_squareView.mas_right).offset(-15);
            make.bottom.equalTo(_lineView.mas_top).offset(-10);
        }];
        
        [_placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(35.5);
            make.bottom.equalTo(self.mas_bottom).with.offset(-25.5);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(20);
            make.bottom.equalTo(_destinationLabel.mas_top).with.offset(-15);
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.height.equalTo(self.mas_height).multipliedBy(1.0/187.5);
        }];
        
        [_destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_placeImageView.mas_right).with.offset(10);
            make.bottom.equalTo(self.mas_bottom).with.offset(-25.5);
            
        }];
        [_dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_squareView.mas_bottom).with.offset(-11);
            make.right.equalTo(_squareView.mas_right).with.offset(-15);
        }];
    }
    return self;
}

-(void)layoutWithItem:(ListItem *)item{
    self.deliveryTimeLabel.text = item.deliveryTime;
    self.deliveryTimeLabel.textAlignment = NSTextAlignmentCenter;
    //拼接amount、
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"数量："];
    [str appendString:item.amount];
    [str appendString:@"斤"];
    NSMutableAttributedString *initString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [[initString string] rangeOfString:@"数量："];
    [initString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1] range:range1];
    NSRange range2 = [[initString string] rangeOfString:item.amount];
    [initString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1] range:range2];
    NSRange range3 = [[initString string] rangeOfString:@" 斤"];
    [initString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1] range:range3];
    self.amoutLabel.attributedText = initString;
    self.ItemID = item.idd;
    
    
    //拼接订货人
    NSMutableString *str2 = [NSMutableString string];
    [str2 appendString:@"订货人："];
    [str2 appendString:item.username];
    NSMutableAttributedString *initString2 = [[NSMutableAttributedString alloc] initWithString:str2];
    NSRange range12 = [[initString2 string] rangeOfString:@"订货人："];
    [initString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1] range:range12];
    NSRange range22 = [[initString2 string] rangeOfString:item.username];
    [initString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1] range:range22];
    self.buyerLabel.attributedText = initString2;
    

    //拼接订货人
    NSMutableString *str3 = [NSMutableString string];
    [str3 appendString:@"联系电话："];
    [str3 appendString:item.phone];
    _numberr = item.phone;
    NSMutableAttributedString *initString3 = [[NSMutableAttributedString alloc] initWithString:str3];
    NSRange range13 = [[initString3 string] rangeOfString:@"联系电话："];
    [initString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1] range:range13];
    NSRange range23 = [[initString3 string] rangeOfString:item.phone];
    [initString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:137.0/255 green:210.0/255 blue:44.0/255 alpha:1] range:range23];
    self.phoneLabel.attributedText = initString3;
    
    self.destinationLabel.text = item.address;
}
-(void)_deleteLabelClick{
    //将item数据放进记录表
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //获取用户表路径
    NSString *userDBPath=[doc stringByAppendingPathComponent:@"user.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:userDBPath];
        
    //拼接sql
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:@"INSERT INTO "];
    NSString *tableName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    [sql appendString:tableName];
    [sql appendString:@"2"];
    [sql appendString:@" (amount,deliveryTime,username,phone,address) VALUES (?,?,?,?,?);"];
        if ([db open]) {
            BOOL res = [db executeUpdate:sql,_amoutLabel.text,_deliveryTimeLabel.text,_buyerLabel.text,_phoneLabel.text,_destinationLabel.text];
            if (res) {
                NSLog(@"插入记录表成功");
            }else{
                NSLog(@"插入记录表失败");
            }
            [db close];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:idd:)]) {
        [self.delegate tableViewCell:self idd:self.ItemID];
    }
}
}

-(void)_call{
    NSString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_numberr];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        //设备系统为IOS 10.0或者以上的
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    }
}
//什么都不做，或者不把触摸事件往下传递就行
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{}

-(void)_dotViewClick{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDotView:idd:)]){
        [self.delegate tableViewCell:self clickDotView:self.dotImageView idd:self.ItemID];
    }
}
@end
