//
//  JKAPIController.h
//  JIRAFoundation
//
//  Created by nathan spindel on 3/22/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKSession.h"

typedef void (^JKServerResponseBlock)(NSError *error, NSArray *resources);

@interface JKAPIController : NSObject

@property (nonatomic, retain) JKSession *session; // required

- (void)loadAllIssuesAssignedToMeWithCompletionHandler:(JKServerResponseBlock)completionHandler;
- (void)loadAllProjectsWithCompletionHandler:(JKServerResponseBlock)completionHandler;

- (void)loadIssueWithIdentifier:(NSString *)identifier completionHandler:(JKServerResponseBlock)completionHandler;

@end
