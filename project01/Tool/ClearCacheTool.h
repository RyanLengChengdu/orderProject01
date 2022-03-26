//
//  ClearCacheTool.h
//  project01
//
//  Created by 冷锐鹏 on 2022/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClearCacheTool : NSObject
/// 计算缓存大小
+(float)filePath;
 /// 清理缓存
+(void)clearCache;
+ (float)folderSizeAtPath:(NSString *)folderPath;
@end

NS_ASSUME_NONNULL_END
