//
//  Model.h
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DbModel : NSObject

-(instancetype)initWithDbFilename:(const NSString *)dbFilename;
-(void)openDb;
-(void)closeDb;
-(sqlite3 *)getDatabase;

@end
