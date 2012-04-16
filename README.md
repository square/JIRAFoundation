# JIRAFoundation #

## Intro ##

JIRAFoundation is a Foundation framework that does network communication with the JIRA REST API and provides a model object layer. It's built on RESTKit and uses ARC.

It's definitely a work in progress; right now it can only get projects and issues, but the foundation is there to build upon.

## Example Usage ##

	JKAPIController *jiraAPIController = [[JKAPIController alloc] init];
	jiraAPIController.session = [[JKSession alloc] initWithBaseURL:[NSURL URLWithString:@"https://example.com/jira"] userName:@"USER" password:@"PASSWORD"];

	[jiraAPIController loadAllIssuesAssignedToMeWithCompletionHandler:^(NSError *error, NSArray *resources) {
		NSLog(@"loaded issues: %@", resources);
	}];

	[jiraAPIController loadAllProjectsWithCompletionHandler:^(NSError *error, NSArray *resources) {
		NSLog(@"loaded projects: %@", resources);
	}];

	[jiraAPIController loadIssueWithIdentifier:@"12345" completionHandler:^(NSError *error, NSArray *resources) {
		NSLog(@"loaded issue: %@", resources);
	}];
