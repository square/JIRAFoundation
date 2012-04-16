//
//  JKIssue.h
//  JIRAFoundation
//
//  Created by nathan spindel on 3/22/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKAbstractResource.h"

@class JKPriority;
@class JKProject;
@class JKResolution;
@class JKUser;

@interface JKIssue : JKAbstractResource

@property (nonatomic, retain) NSString *issueDescription;
@property (nonatomic, retain) NSString *issueSummary;

@property (nonatomic, retain) JKProject *project;
@property (nonatomic, retain) JKUser *assignee;
@property (nonatomic, retain) JKUser *reporter;
@property (nonatomic, retain) JKPriority *priority;
@property (nonatomic, retain) JKResolution *resolution;

@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSDate *updatedAt;
@property (nonatomic, retain) NSDate *resolvedAt;

@property (nonatomic, retain) NSArray *attachments;
@property (nonatomic, retain) NSArray *comments;

@end
