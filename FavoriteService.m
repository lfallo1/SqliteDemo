//
//  FavoriteService.m
//  SqliteDemo
//
//  Created by Lance Fallon on 4/27/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "FavoriteService.h"


@implementation FavoriteService
+(void)addToFavorites:(Person *)p filename:(NSString *)fn callback:(void (^)(NSString *))clb{
    NSURL *fileUrl = [FileManagerHelper getDocumentUrlByFilename: fn];
    NSString *filePath = [fileUrl path];
    NSMutableArray *savedPersons = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSString *msg;
    
    if(!savedPersons){
        savedPersons = [[NSMutableArray alloc]init];
    }
    
    BOOL alreadyExists = NO;
    for(int i = 0; i < [savedPersons count]; i++){
        if([[savedPersons objectAtIndex:i]personId] == [p personId]){
            alreadyExists = YES;
        }
    }
    
    if(alreadyExists){
        msg = @"Person already exists in favorites";
    }
    
    else{
        [savedPersons addObject:p];
        BOOL success = [NSKeyedArchiver archiveRootObject:savedPersons toFile:filePath];

        if(success){
            msg = @"Contact was successfully added to database";
        }
        else{
            msg = @"Failed to save data. Please try again later.";
        }
    }
    clb(msg);
}

+(NSMutableArray *)getFavorites:(NSString *)fn{
    NSURL *fileUrl = [FileManagerHelper getDocumentUrlByFilename: fn];
    NSMutableArray *favs = [NSKeyedUnarchiver unarchiveObjectWithFile:[fileUrl path]];
    return favs;
}

@end
