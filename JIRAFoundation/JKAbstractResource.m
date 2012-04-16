//
//  JKAbstractResource.m
//  JIRAFoundation
//
//  Created by nathan spindel on 3/22/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import "JKAbstractResource.h"

@implementation JKAbstractResource

@synthesize resourceURL;
@synthesize identifier;
@synthesize name;
@synthesize key;

- (NSString *)description;
{
    NSString *superDescription = [super description];
    return [NSString stringWithFormat:@"%@, name: %@, key: %@, identifier: %@, resourceURL: %@>", [superDescription substringToIndex:superDescription.length - 2], self.name, self.key, self.identifier, self.resourceURL];
}

@end
