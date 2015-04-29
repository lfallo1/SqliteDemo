//
//  FileManagerHelper.h
//  SqliteDemo
//
//  Created by Lance Fallon on 4/27/15.
//  Copyright (c) 2015 Lance Fallon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManagerHelper : NSObject
+(NSURL *) getDocumentUrlByFilename:(NSString *)fileName;
@end
