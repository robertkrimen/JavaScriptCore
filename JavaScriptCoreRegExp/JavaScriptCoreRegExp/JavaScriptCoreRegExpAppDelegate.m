//
//  JavaScriptCoreRegExpAppDelegate.m
//  JavaScriptCoreRegExp
//
//  Created by Broken Rim on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JavaScriptCoreRegExpAppDelegate.h"
#import "JSCRegExp.h"

@implementation JavaScriptCoreRegExpAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *result = [[JSCRegExp sharedInstance] execute:@"abc01defgh234i5j6k789lmnop" withPattern:@"(\\d+)"];
    NSLog(@"%@", result);
    // Insert code here to initialize your application
    [[NSApplication sharedApplication] terminate:self];
}

@end
