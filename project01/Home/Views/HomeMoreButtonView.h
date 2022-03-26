//
//  HomeMoreButtonView.h
//  project01
//
//  Created by 冷锐鹏 on 2022/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeMoreButtonView : UIView
-(void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;
-(void)showDeleteViewFromPoint:(CGPoint)point clickBlock2:(dispatch_block_t)clickBlock2;
@end

NS_ASSUME_NONNULL_END
