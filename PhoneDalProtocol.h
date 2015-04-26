//
//  PhoneDalProtocol.h
//  SqliteDemo
//
//  Created by Lance Fallon on 4/26/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

@protocol PhoneDalProtocol

@required
-(NSArray *)getByPerson:(NSNumber *)personId;
@end