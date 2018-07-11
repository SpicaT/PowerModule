#include "MRYRootListController.h"

@implementation MRYRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)creatorMethod
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Muirey03"] options:@{} completionHandler:nil];
}

-(void)creditsMethod
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.reddit.com/user/thecoderkiller"] options:@{} completionHandler:nil];
}

@end
