//
//  JSCRegExp.m
//  JavaScriptCoreRegExp
//
//  Created by Broken Rim on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSCRegExp.h"


@implementation JSCRegExp

+ (id)sharedInstance
{
	static id singleton;
	@synchronized(self) {
		if (!singleton)
			singleton = [[JSCRegExp alloc] init];
		return singleton;
	}
	return singleton;
}

- (id)init {
	self = [super init];
    if (self) {
        ctx = JSGlobalContextCreate(NULL);
        
        NSString* reScript = @"var result = string.match( new RegExp( pattern, flags ) ); if (result) result.join('');";
        reScriptJS = JSStringCreateWithCFString((CFStringRef)reScript);
    }
    return self;
}

- (void)setConstantStringValue:(NSString*)value forName:(NSString*)name {
    JSStringRef nameJS = JSStringCreateWithCFString((CFStringRef)name);
	JSStringRef valueJS = JSStringCreateWithCFString((CFStringRef)value);

	JSValueRef exception = NULL;
	JSObjectSetProperty(ctx, JSContextGetGlobalObject(ctx), nameJS, JSValueMakeString(ctx, valueJS), 
						kJSPropertyAttributeDontDelete | kJSPropertyAttributeReadOnly, &exception);

	JSStringRelease(nameJS);
	JSStringRelease(valueJS);
}

- (id)execute:(NSString*)string withPattern:(NSString*)pattern {

	NSString* flags = @"g";

	[self setConstantStringValue:string forName:@"string"];
	[self setConstantStringValue:pattern forName:@"pattern"];
	[self setConstantStringValue:flags forName:@"flags"];
	
    JSValueRef result = JSEvaluateScript( ctx, reScriptJS, NULL, NULL, 0, NULL );
	if (!result) return	nil;
	JSStringRef resultStringJS = JSValueToStringCopy( ctx, result, NULL );
	CFStringRef resultString = JSStringCopyCFString( kCFAllocatorDefault, resultStringJS );
	JSStringRelease( resultStringJS );
    return (id) resultString;
}

@end
