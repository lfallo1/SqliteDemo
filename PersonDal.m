//
//  PersonDal.m
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "PersonDal.h"
#import "DbModel.h"

@interface PersonDal(){
    DbModel *dbHelper;
}
@end

@implementation PersonDal

static const int COLUMN_ID = 0;
static const int COLUMN_NAME = 1;

-(id)init{
    self = [super init];
    if(self){
        dbHelper = [[DbModel alloc]initWithDbFilename:PHONEBOOK_SQLITE_FILENAME];
    }
    return self;
}

-(NSArray *)allPerson{
    [dbHelper openDb];
    
    NSMutableArray *personList = [[NSMutableArray alloc]init];
    
    NSString *selectSql = @"select * from person";
    const char *query = [selectSql UTF8String];
    sqlite3_stmt *query_stmt = NULL;

    sqlite3 *database = [dbHelper getDatabase];
    int res;
    if((res = sqlite3_prepare_v2(database, query, -1, &query_stmt, NULL))!=SQLITE_OK){
        NSLog(@"error preparing statement: %@\nError Code: %i", selectSql, res);
        return nil;
    }
    while(sqlite3_step(query_stmt)==SQLITE_ROW){
        long long ID = sqlite3_column_int(query_stmt, COLUMN_ID);
        char *name = (char *)sqlite3_column_text(query_stmt, COLUMN_NAME);
        
        NSNumber *personId = [NSNumber numberWithLongLong:ID];
        NSString *personName = [NSString stringWithUTF8String:name];
        
        Person *person = [[Person alloc]initWithPerson:personId name:personName];
        [personList addObject:person];
    }
    
    [dbHelper closeDb];
    
    return personList;
}

-(Person *)getById{
    return nil;
}

-(NSNumber *)insertPerson:(Person *)p{
    [dbHelper openDb];
    NSString *selectSql = [NSString stringWithFormat: @"insert into person (name) values ('%@')",[p name] ];
    const char *query = [selectSql UTF8String];
    sqlite3_stmt *query_stmt = NULL;
    
    sqlite3 *database = [dbHelper getDatabase];
    int res;
    if((res = sqlite3_prepare_v2(database, query, -1, &query_stmt, NULL))!=SQLITE_OK){
        NSLog(@"error preparing statement: %@\nError Code: %i", selectSql, res);
        return [NSNumber numberWithInt:-1];
    }
    sqlite3_step(query_stmt);
    sqlite3_int64 last_inserted_id = sqlite3_last_insert_rowid(database);
    
    [dbHelper closeDb];
    
    return [NSNumber numberWithLongLong:last_inserted_id];
}

-(void)deletePerson:(NSInteger)personId
{
    
}
@end
