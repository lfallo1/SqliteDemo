//
//  PhoneNumber.h
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface PhoneNumber : NSObject

@property NSNumber *phoneId;
@property NSString *number;
@property NSString *type;
@property Person *person;

-(id)initWithPhone:(NSNumber *)pid number:(NSString *)n type:(NSString *)t person:(Person *)pers;

@end
