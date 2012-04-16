//
//  JKObjectMappings.m
//  JIRAFoundation
//
//  Created by nathan spindel on 3/28/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import "JKObjectMappings.h"
#import <JIRAFoundation/JIRAFoundation.h>
#import <RestKit/RestKit.h>
#import "ISO8601DateFormatter.h"

@implementation JKObjectMappings

+ (RKObjectMapping *)JK_mappingForClass:(Class)class;
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:class];
    [mapping mapAttributes:@"key", @"name", nil];
    [mapping mapKeyPath:@"self" toAttribute:@"resourceURL"];
    [mapping mapKeyPath:@"id" toAttribute:@"identifier"];
    return mapping;
}

+ (void)registerMappings;
{
    RKObjectMapping *userMapping = [self JK_mappingForClass:[JKUser class]];
    [userMapping mapAttributes:@"displayName", @"emailAddress", nil];
    
    RKObjectMapping *projectMapping = [self JK_mappingForClass:[JKProject class]];
    
    RKObjectMapping *priorityMapping = [self JK_mappingForClass:[JKPriority class]];
    
    RKObjectMapping *attachmentMapping = [self JK_mappingForClass:[JKAttachment class]];
    [attachmentMapping mapAttributes:@"filename", @"mimeType", @"size", nil];    
    [attachmentMapping mapKeyPath:@"author" toRelationship:@"author" withMapping:userMapping];
    [attachmentMapping mapKeyPath:@"created" toAttribute:@"createdAt"];
    [attachmentMapping mapKeyPath:@"content" toAttribute:@"contentURL"];
    [attachmentMapping mapKeyPath:@"thumbnail" toAttribute:@"thumbnailURL"];    
    
    RKObjectMapping *commentMapping = [self JK_mappingForClass:[JKComment class]];
    [commentMapping mapAttributes:@"body", nil];
    [commentMapping mapKeyPath:@"created" toAttribute:@"createdAt"];
    [commentMapping mapKeyPath:@"author" toRelationship:@"author" withMapping:userMapping];
    
    RKObjectMapping *resolutionMapping = [self JK_mappingForClass:[JKResolution class]];
    [resolutionMapping mapKeyPath:@"description" toAttribute:@"resolutionDescription"];
    
    RKObjectMapping *issueMapping = [self JK_mappingForClass:[JKIssue class]];
    [issueMapping mapKeyPath:@"fields.description" toAttribute:@"issueDescription"];
    [issueMapping mapKeyPath:@"fields.summary" toAttribute:@"issueSummary"];
    [issueMapping mapKeyPath:@"fields.created" toAttribute:@"createdAt"];
    [issueMapping mapKeyPath:@"fields.updated" toAttribute:@"updatedAt"];
    [issueMapping mapKeyPath:@"fields.resolutiondate" toAttribute:@"resolvedAt"];
    [issueMapping mapKeyPath:@"fields.assignee" toRelationship:@"assignee" withMapping:userMapping];
    [issueMapping mapKeyPath:@"fields.reporter" toRelationship:@"reporter" withMapping:userMapping];
    [issueMapping mapKeyPath:@"fields.project" toRelationship:@"project" withMapping:projectMapping];
    [issueMapping mapKeyPath:@"fields.priority" toRelationship:@"priority" withMapping:priorityMapping];
    [issueMapping mapKeyPath:@"fields.resolution" toRelationship:@"resolution" withMapping:resolutionMapping];
    [issueMapping mapKeyPath:@"fields.attachment" toRelationship:@"attachments" withMapping:attachmentMapping];
    [issueMapping mapKeyPath:@"fields.comment.comments" toRelationship:@"comments" withMapping:commentMapping];    

    [[RKObjectManager sharedManager].mappingProvider setMapping:issueMapping forKeyPath:@"issues"];
    
    [[RKObjectManager sharedManager].mappingProvider addObjectMapping:projectMapping];

    [RKObjectMapping addDefaultDateFormatter:(NSDateFormatter *)[[ISO8601DateFormatter alloc] init]];
}

@end
