//
//  JKAbstractResource.h
//  JIRAFoundation
//
//  Created by nathan spindel on 3/22/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKAbstractResource : NSObject

@property (nonatomic, retain) NSURL *resourceURL;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *key;

@end
