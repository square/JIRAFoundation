//
//  JKAPIController.m
//  JIRAFoundation
//
//  Created by nathan spindel on 3/22/12.
//  Copyright (c) 2012 Square, Inc. All rights reserved.
//

#import "JKAPIController.h"
#import <JIRAFoundation/JIRAFoundation.h>
#import <RestKit/RestKit.h>
#import "JKObjectMappings.h"

@interface JKAPIController () <RKObjectLoaderDelegate>

@property (nonatomic, retain) NSMutableDictionary *completionHandlersForResourcePaths;

@end

@implementation JKAPIController

@synthesize session;
@synthesize completionHandlersForResourcePaths;

#pragma mark Initialization

- (id)init;
{
    self = [super init];
    if (!self) {
        return nil;
    }

    self.completionHandlersForResourcePaths = [[NSMutableDictionary alloc] init];    
    
    return self;
}

#pragma mark Accessors

- (void)setSession:(JKSession *)inSession;
{
    if (session != inSession) {
        session = inSession;
        
        // Configure RestKit objects and mappings.
        NSString *baseURL = session.baseURL.absoluteString;
        RKClient *client = [RKClient clientWithBaseURL:baseURL username:session.userName password:session.password];
        RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
        objectManager.client = client;
        [JKObjectMappings registerMappings];
    }
}

#pragma mark JKAPIController

- (void)loadIssueWithIdentifier:(NSString *)identifier completionHandler:(JKServerResponseBlock)completionHandler;
{
    assert(identifier.length);
    
    NSString *resourcePath = [NSString stringWithFormat:@"issue/%@", identifier];
    [self loadResourcesAtPath:resourcePath objectClass:[JKIssue class] withCompletionHandler:completionHandler];
}

- (void)loadAllIssuesAssignedToMeWithCompletionHandler:(JKServerResponseBlock)completionHandler;
{
    NSString *resourcePath = [NSString stringWithFormat:@"search?jql=assignee=%@", self.session.userName];
    [self loadResourcesAtPath:resourcePath objectClass:nil withCompletionHandler:completionHandler];
}

- (void)loadAllProjectsWithCompletionHandler:(JKServerResponseBlock)completionHandler;
{
    [self loadResourcesAtPath:@"project" objectClass:[JKProject class] withCompletionHandler:completionHandler];
}

#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects;
{
    [self dispatchCompletionHandlerResultsWithObjects:objects error:nil forResourcePath:objectLoader.resourcePath];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error;
{
    [self dispatchCompletionHandlerResultsWithObjects:nil error:error forResourcePath:objectLoader.resourcePath];
}

#pragma mark Private

- (void)loadResourcesAtPath:(NSString *)resourcePath objectClass:(Class)objectClass withCompletionHandler:(JKServerResponseBlock)completionHandler;
{
    NSAssert(self.session, @"Session must be set on JKAPIController before contacting the network");
    NSAssert(resourcePath.length, @"Resource path not valid");
    
    NSString *fullResourcePath = [@"/rest/api/latest/" stringByAppendingString:resourcePath];
    
    NSMutableArray *completionHandlers = [self.completionHandlersForResourcePaths objectForKey:fullResourcePath];
    if (!completionHandlers) {
        completionHandlers = [NSMutableArray array];
        [self.completionHandlersForResourcePaths setObject:completionHandlers forKey:fullResourcePath];
    }
    
    if (completionHandler) {
        [completionHandler copy];
        [completionHandlers addObject:completionHandler];
    }
    
    if (objectClass) {
        RKObjectMapping *objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForClass:objectClass];
        NSAssert(objectMapping, @"Could not find an object mapping for %@", NSStringFromClass(objectClass));
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:fullResourcePath objectMapping:objectMapping delegate:self];
    } else {
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:fullResourcePath delegate:self];
    }
}

- (void)dispatchCompletionHandlerResultsWithObjects:(NSArray *)objects error:(NSError *)error forResourcePath:(NSString *)resourcePath;
{
    NSMutableArray *completionHandlers = [self.completionHandlersForResourcePaths objectForKey:resourcePath];
    for (JKServerResponseBlock completionHandler in completionHandlers) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(error, objects);
        });
    }
    [self.completionHandlersForResourcePaths removeObjectForKey:resourcePath];    
}

@end
