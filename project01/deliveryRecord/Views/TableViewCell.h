//
//  TableViewCell.h
//  project01
//
//  Created by 冷锐鹏 on 2022/3/22.
//

#import <UIKit/UIKit.h>
#import "ListItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
-(void)layoutWithItem:(ListItem *)item;
@end

NS_ASSUME_NONNULL_END
