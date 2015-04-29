//
//  DalProtocol.h
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "Person.h"

@protocol PersonDalProtocol

@required
-(NSArray *)allPerson;

-(Person *)getById;

-(NSNumber *)insertPerson:(Person *)p;

-(void)deletePerson:(NSInteger)personId;

@end
