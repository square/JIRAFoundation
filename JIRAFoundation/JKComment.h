//
//  JKComment.h
//  JIRAFoundation
//
//  Created by nathan spindel on 3/28/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import "JKAbstractResource.h"

@class JKUser;

@interface JKComment : JKAbstractResource

@property (nonatomic, retain) JKUser *author;
@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSString *body;

@end
