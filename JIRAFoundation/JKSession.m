//
//  JKSession.m
//  JIRAFoundation
//
//  Created by nathan spindel on 3/22/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import "JKSession.h"
#import <JIRAFoundation/JIRAFoundation.h>

@implementation JKSession

@synthesize baseURL;
@synthesize userName;
@synthesize password;

#pragma mark Initialization

- (id)initWithBaseURL:(NSURL *)inBaseURL userName:(NSString *)inUserName password:(NSString *)inPassword;
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    assert(inBaseURL);
    assert(inUserName);
    assert(inPassword);
    
    self.baseURL = inBaseURL;
    self.userName = inUserName;
    self.password = inPassword;
    
    return self;
}

@end
