//
//  HomeMoreButtonView.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/25.
//

#import "HomeMoreButtonView.h"

@interface HomeMoreButtonView ()
@property(nonatomic,strong,readwrite)UIView *backgroundView;
@property(nonatomic,strong,readwrite)UIView *smallBG;
@property(nonatomic,strong,readwrite)UIButton *editButton;
@property(nonatomic,strong,readwrite)UIButton *deleteButton;
@property(nonatomic,copy,readwrite)dispatch_block_t deleteBlock;
@property(nonatomic,copy,readwrite)dispatch_block_t editBlock;
@end


@implementation HomeMoreButtonView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _backgroundView = [[UIView alloc]initWithFrame:self.bounds];
            self.backgroundView.backgroundColor = [UIColor blackColor];
            self.backgroundView.alpha = 0.05;
    [self.backgroundView addGestureRecognizer:({
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_dismissDeleteView)];
        gesture;
    })];
            _backgroundView;
        })];
        
        [self addSubview:({
            self.smallBG = [[UIView alloc]init];
            self.smallBG.backgroundColor = [UIColor blackColor];
            _smallBG.layer.cornerRadius = 5;
            self.smallBG;
        })];
        [self addSubview:({
                    self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            [self.deleteButton setImage:[UIImage imageNamed:@"home_icon_delete"] forState:UIControlStateNormal];
                    [self.deleteButton addTarget:self action:@selector(_clickButton) forControlEvents:UIControlEventTouchUpInside];
                    //self.deleteButton.backgroundColor = [UIColor orangeColor];
                    self.deleteButton.titleLabel.text = @"title";
                    self.deleteButton;
                })];
        
        [self addSubview:({
                    self.editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            [self.editButton setImage:[UIImage imageNamed:@"home_icon_edit"] forState:UIControlStateNormal];
                    [self.editButton addTarget:self action:@selector(_clickEditButton) forControlEvents:UIControlEventTouchUpInside];
                    //self.editButton.backgroundColor = [UIColor blackColor];
                    self.editButton.titleLabel.text = @"title";
                    self.editButton;
                })];
    }
    return self;
}
-(void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock{
    
    //设置deleteButton的起始frame初始值
    self.smallBG.frame = CGRectMake(point.x-103, point.y-11, 103, 44);
    self.editButton.frame = CGRectMake(point.x-88, point.y, 22, 22);
    self.deleteButton.frame = CGRectMake(point.x-34, point.y, 22, 22);
    //当点击的时候持有该block   此句让这个deleteCellView拥有block的属性，才能在最下方clickButton方法内执行从ViewController传递过来的block
    self.deleteBlock = [clickBlock copy];
    //让新出现的View不影响下面的viewController
    //[[UIApplication sharedApplication].keyWindow addSubview:self];
//    UIWindow *window = [[[UIApplication sharedApplication]windows] objectAtIndex:0];
//    [window addSubview:self];
    [self.window.windowScene.keyWindow addSubview:self];
    //UIView的动画方法都是类方法，所以需要用UIView来调用
   /* [UIView animateWithDuration:1.f animations:^{
        
        //使用与物理弹簧运动相对应的时序曲线执行视图动画。
        [UIView animateWithDuration:1.f delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            //设置deleteButton的frame终点位置值
            self.deleteButton.frame = CGRectMake(point.x-20, point.y, 20, 20);
        } completion:^(BOOL finished) {
            NSLog(@"动画完成");
        }];
    }];*/
}
-(void)showDeleteViewFromPoint:(CGPoint)point clickBlock2:(dispatch_block_t)clickBlock2{
    self.smallBG.frame = CGRectMake(point.x-103, point.y-11, 103, 44);
    self.editButton.frame = CGRectMake(point.x-88, point.y, 22, 22);
    self.deleteButton.frame = CGRectMake(point.x-34, point.y, 22, 22);
    self.editBlock = [clickBlock2 copy];
    [self.window.windowScene.keyWindow addSubview:self];
}

-(void)_dismissDeleteView{
    [self removeFromSuperview];
}
-(void)_clickButton{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
    [self removeFromSuperview];
}

-(void)_clickEditButton{
    [self removeFromSuperview];
    //跳转到编辑页面
    if (self.editBlock) {
        self.editBlock();
    }
}
@end
