//
//  Model.m
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "DbModel.h"
#import "ApplicationConstants.h"
#import "Person.h"

@interface DbModel()
{
    NSString *_dbFilename;
}
@property (nonatomic, strong) NSString *_documentsDirectory;
@end

@implementation DbModel

static sqlite3 *database;

-(instancetype)initWithDbFilename:(NSString *)dbFilename{
    self = [super init];
    if(self){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self._documentsDirectory = [paths objectAtIndex:0];
        _dbFilename = dbFilename;
        [self copyDbIntoDocumentsDirectory];
    }
    return self;
}

-(sqlite3 *)getDatabase{
    return database;
}

-(void)copyDbIntoDocumentsDirectory{
    NSString *destinationPath = [self._documentsDirectory stringByAppendingPathComponent:_dbFilename];
    if(![[NSFileManager defaultManager]fileExistsAtPath:destinationPath]){
        NSString *sourcePath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:_dbFilename];
        NSError *error;
        [[NSFileManager defaultManager]copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        if(error != nil){
            NSLog(@"Error copying file: %@", error);
        }
    }
}

-(void)openDb{
    NSString *dbPath = [NSString stringWithFormat:@"%@%@%@",self._documentsDirectory, @"/", _dbFilename];
    if( (sqlite3_open([dbPath UTF8String], &database))!= SQLITE_OK){
        NSLog(@"error opening db");
    }
    else{
        NSLog(@"Db opened succesfully!");
    }
}

-(void)closeDb{
    sqlite3_close(database);
    NSLog(@"DB now closed");
}

@end
