//
//  JKAttachment.h
//  JIRAFoundation
//
//  Created by nathan spindel on 3/28/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import "JKAbstractResource.h"

@class JKUser;

@interface JKAttachment : JKAbstractResource

@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) JKUser *author;

@property (nonatomic, retain) NSURL *contentURL;
@property (nonatomic, retain) NSURL *thumbnailURL;
@property (nonatomic) unsigned long long size;
@property (nonatomic, retain) NSString *filename;
@property (nonatomic, retain) NSString *mimeType;

@end
