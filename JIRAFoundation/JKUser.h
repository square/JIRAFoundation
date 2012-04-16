//
//  JKUser.h
//  JIRAFoundation
//
//  Created by nathan spindel on 3/22/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKAbstractResource.h"

@interface JKUser : JKAbstractResource

@property (nonatomic, retain) NSString *displayName; // ie. "John Appleseed";
@property (nonatomic, retain) NSString *emailAddress;

@end
