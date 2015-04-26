//
//  Person.h
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property NSNumber *personId;
@property NSString *name;
-(id)initWithPerson:(NSNumber *)pid name:(NSString *)n;
@end
