//
//  DataLoader.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/22.
//

#import "DataLoader.h"
#import "ListItem.h"
#import "FMDB.h"
@implementation DataLoader
- (void)loadListDataWithFinishBlock:(ListLoaderFinishBlock)finishBlock{
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
        }
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
        [db close];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(nil, listItemArray.copy);
            }
        });
    }
}

-(void)loadListData2WithFinishBlock:(ListLoaderFinishBlock)finishBlock{
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
            [sql appendString:@"2"];
        }
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
        [db close];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finishBlock) {
                finishBlock(nil, listItemArray.copy);
            }
        });
    }
}

@end
