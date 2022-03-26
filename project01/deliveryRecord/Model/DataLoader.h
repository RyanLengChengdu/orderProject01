//
//  DataLoader.h
//  project01
//
//  Created by 冷锐鹏 on 2022/3/22.
//

#import <Foundation/Foundation.h>
#import "ListItem.h"
@class ListItem;
typedef void(^ListLoaderFinishBlock)(BOOL success, NSMutableArray<ListItem *> *dataArray);
typedef void(^ListLoaderFinishBlock2)(NSString *str, NSMutableArray<ListItem *> *dataArray);
NS_ASSUME_NONNULL_BEGIN

@interface DataLoader : NSObject
-(void)loadListDataWithFinishBlock:(ListLoaderFinishBlock)finishBlock;
-(void)loadListData2WithFinishBlock:(ListLoaderFinishBlock)finishBlock;
-(void)loadListData_dateWithFinishBlock:(ListLoaderFinishBlock2)finishBlock;
@end

NS_ASSUME_NONNULL_END
