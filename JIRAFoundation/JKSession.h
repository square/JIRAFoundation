//
//  JKSession.h
//  JIRAFoundation
//
//  Created by nathan spindel on 3/22/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKSession : NSObject

@property (nonatomic, retain) NSURL *baseURL; // ie. "https://jira.atlassian.com/" or "https://example.com/jira"
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *password;

- (id)initWithBaseURL:(NSURL *)baseURL userName:(NSString *)userName password:(NSString *)password;

@end
