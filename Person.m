//
//  Person.m
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "Person.h"

@implementation Person
-(id)initWithPerson:(NSNumber *)pid name:(NSString *)n{
    self = [super init];
    if(self){
        [self setPersonId:pid];
        [self setName:n];
    }
    return self;
}
@end
