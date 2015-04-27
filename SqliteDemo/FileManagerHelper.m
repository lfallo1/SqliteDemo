//
//  FileManagerHelper.m
//  SqliteDemo
//
//  Created by Lance Fallon on 4/27/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import "FileManagerHelper.h"

@implementation FileManagerHelper

+(NSURL *) getDocumentUrlByFilename:(NSString *)fileName{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *dirs = [manager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *docPath = [dirs objectAtIndex:0];
    NSURL *dataFile = [docPath URLByAppendingPathComponent:fileName];
    return dataFile;
}

@end
