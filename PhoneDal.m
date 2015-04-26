//
//  PhoneDal.m
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "PhoneDal.h"
#import "DbModel.h"

@interface PhoneDal(){
    DbModel *dbHelper;
}
@end

@implementation PhoneDal

static const int COLUMN_ID = 0;
static const int COLUMN_NUMBER = 1;
static const int COLUMN_TYPE = 2;
static const int COLUMN_PERSON_ID = 3;
static const int COLUMN_PERSON_NAME = 4;

-(id)init{
    self = [super init];
    if(self){
        dbHelper = [[DbModel alloc]initWithDbFilename:PHONEBOOK_SQLITE_FILENAME];
    }
    return self;
}

-(NSArray *)getByPerson:(NSNumber *)personId{
    [dbHelper openDb];
    
    NSMutableArray *phoneList = [[NSMutableArray alloc]init];
    
    NSString *selectSql = [NSString stringWithFormat:@"select phone.id, phone.number, phone.type, person.id, person.name from person inner join phone_number phone on person.id = phone.person where person.id = %@", personId];
    const char *query = [selectSql UTF8String];
    sqlite3_stmt *query_stmt = NULL;
    
    sqlite3 *database = [dbHelper getDatabase];
    int res;
    if((res = sqlite3_prepare_v2(database, query, -1, &query_stmt, NULL))!=SQLITE_OK){
        NSLog(@"error preparing statement: %@\nError Code: %i", selectSql, res);
        return nil;
    }
    while(sqlite3_step(query_stmt)==SQLITE_ROW){
        long long _phone_ID = sqlite3_column_int(query_stmt, COLUMN_ID);
        char *_phone_number = (char *)sqlite3_column_text(query_stmt, COLUMN_NUMBER);
        char *_phone_type = (char *)sqlite3_column_text(query_stmt, COLUMN_TYPE);
        long long _person_ID = sqlite3_column_int(query_stmt, COLUMN_PERSON_ID);
        char *_person_name = (char *)sqlite3_column_text(query_stmt, COLUMN_PERSON_NAME);
        
        NSNumber *phoneId = [NSNumber numberWithLongLong:_phone_ID];
        NSString *phone_number = [NSString stringWithUTF8String:_phone_number];
        NSString *phone_type = [NSString stringWithUTF8String:_phone_type];
        NSNumber *personId = [NSNumber numberWithLongLong:_person_ID];
        NSString *person_name = [NSString stringWithUTF8String:_person_name];
        
        Person *pers = [[Person alloc]initWithPerson:personId name:person_name];
        
        PhoneNumber *phone = [[PhoneNumber alloc]initWithPhone:phoneId number:phone_number type:phone_type person:pers];
        [phoneList addObject:phone];
    }
    
    [dbHelper closeDb];
    
    return phoneList;
}

@end
