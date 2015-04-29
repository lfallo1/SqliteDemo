//
//  FavoriteService.h
//  SqliteDemo
//
//  Created by Lance Fallon on 4/27/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "FileManagerHelper.h"

@interface FavoriteService : NSObject
+(void)addToFavorites:(Person *)p filename:(NSString *)fn callback:(void (^)(NSString *))clb;
+(NSMutableArray *)getFavorites:(NSString *)fn;
@end
