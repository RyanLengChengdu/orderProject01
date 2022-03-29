//
//  ListItem.h
//  project01
//
//  Created by 冷锐鹏 on 2022/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListItem : NSObject
@property(nonatomic,assign)NSInteger idd;
@property(nonatomic,copy,readwrite)NSString *amount;
@property(nonatomic,copy,readwrite)NSString *deliveryTime;
@property(nonatomic,copy,readwrite)NSString *username;
@property(nonatomic,copy,readwrite)NSString *phone;
@property(nonatomic,copy,readwrite)NSString *address;
@end

NS_ASSUME_NONNULL_END
