//
//  JSCRegExp.h
//  JavaScriptCoreRegExp
//
//  Created by Broken Rim on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <JavascriptCore/JavascriptCore.h>

@interface JSCRegExp : NSObject {
	JSGlobalContextRef ctx;
	JSStringRef reScriptJS;
}

+ (id)sharedInstance;
- (id)execute:(NSString*)string withPattern:(NSString*)pattern;

@end
