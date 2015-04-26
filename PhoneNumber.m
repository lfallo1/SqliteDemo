//
//  PhoneNumber.m
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "PhoneNumber.h"

@implementation PhoneNumber

-(id)initWithPhone:(NSNumber *)pid number:(NSString *)n type:(NSString *)t person:(Person *)pers{
    self = [super init];
    if(self){
        [self setPhoneId:pid];
        [self setNumber:n];
        [self setType:t];
        [self setPerson: pers];
    }
    return self;
}

@end
