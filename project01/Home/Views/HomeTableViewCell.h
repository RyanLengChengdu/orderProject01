//
//  HomeTableViewCell.h
//  project01
//
//  Created by 冷锐鹏 on 2022/3/23.
//

#import <UIKit/UIKit.h>
@class ListItem;
NS_ASSUME_NONNULL_BEGIN
@protocol HomeTableViewCellDelegate <NSObject>
-(void)tableViewCell:(UITableViewCell *)tableViewCell idd:(NSInteger *)idd;
-(void)tableViewCell:(UITableViewCell *)tableViewCell clickDotView:(UIImageView*)dotImageView idd:(NSInteger *)idd;
@end
@interface HomeTableViewCell : UITableViewCell
@property(nonatomic,weak,readwrite)id <HomeTableViewCellDelegate>delegate;
-(void)layoutWithItem:(ListItem *)item;

@end

NS_ASSUME_NONNULL_END
