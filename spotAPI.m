//
//  spotAPI.m
//  spotAPI
//
//  Created by Ruaridh Thomson on 09/09/2010.
//  Copyright 2010 Life Up North. All rights reserved.
//

#import "spotAPI.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>
#import "something.h"

#import "GrowlApplicationBridgeDelegate-Protocol.h"

#import <SDGlobalShortcuts/SDGlobalShortcuts.h>

enum {
	kVK_Shift	= 0x38,
	kVK_Option	= 0x3A,
	kVK_Control = 0x3B,
	kVK_Command = 0x37,
};

@implementation spotAPI

/**
 * A special method called by SIMBL once the application has started and all classes are initialized.
 */
+ (void) load
{
	spotAPI* plugin = [spotAPI sharedInstance];
	// ... do whatever
	//[plugin swizzleGrowl];
	[plugin enableShortcuts];
}

/**
 * @return the single static instance of the plugin object
 */
+ (spotAPI*) sharedInstance
{
	static spotAPI* plugin = nil;
	
	if (plugin == nil)
		plugin = [[spotAPI alloc] init];
	
	return plugin;
}

- (void)swizzleGrowl
{
	/*
	Class spgrowl = NSClassFromString(@"SPGrowlDelegate");
	
	Method notification = class_getInstanceMethod(spgrowl, @selector(notificationWithTrackInfo:));
	Method swizNotification = class_getInstanceMethod([self class], @selector(swizNotificationWithTrackInfo:));
	method_exchangeImplementations(notification, swizNotification);
	*/
	
	Class spgrowl = NSClassFromString(@"SPEditMetadataWindowController");
	
	Method notification = class_getInstanceMethod(spgrowl, @selector(nextAction:));
	Method swizNotification = class_getInstanceMethod([self class], @selector(swizNotificationWithTrackInfo:));
	method_exchangeImplementations(notification, swizNotification);
	
	
	
	//[self performSelector:@selector(printPlaying) withObject:nil afterDelay:15.0];
}

- (void)printPlaying
{
	NSLog(@"-------------- NOW PLAYING --------------");
	Class control = NSClassFromString(@"SpotifyController");
	
	//controller = [control sharedInstance];
	
	//[controller getSpotifyPlaying];
	//NSLog(@"%@", [controller getSpotifyPlaying]);
	updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkNowPlaying) userInfo:nil repeats:YES];
}

- (void)checkNowPlaying
{
	prevPlayed = nowPlaying;
	
	//NSString *something = [controller getSpotifyPlaying];
	
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"RTSpotifyNowPlaying" object:@"HAHAHAHA"];
	
	/*
	if (![nowPlaying isEqual:prevPlayed]) {
		[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"RTSpotifyNowPlaying" object:nowPlaying];
	}
	 */
}
	 
- (void)swizNotificationWithTrackInfo:(struct TrackInfo *)arg1
{
	NSLog(@"---------------Growl Interception------------------");
}

- (void)pauseMe
{
	NSEvent *event = [NSEvent keyEventWithType:NSKeyDown location:NSMakePoint(0, 0) modifierFlags:0 timestamp:0 windowNumber:0 context:[NSGraphicsContext currentContext] characters:@" " charactersIgnoringModifiers:@" " isARepeat:NO keyCode:49];
	[NSApp postEvent:event atStart:YES];
}

- (void)skipFwrd
{
	NSEvent *event = [NSEvent keyEventWithType:NSKeyDown location:NSMakePoint(0, 0) modifierFlags:NSCommandKeyMask timestamp:0 windowNumber:0 context:[NSGraphicsContext currentContext] characters:@"" charactersIgnoringModifiers:@"" isARepeat:NO keyCode:124];
	[NSApp postEvent:event atStart:YES];
}

- (void)skipBack
{
	NSEvent *event = [NSEvent keyEventWithType:NSKeyDown location:NSMakePoint(0, 0) modifierFlags:NSCommandKeyMask timestamp:0 windowNumber:0 context:[NSGraphicsContext currentContext] characters:@"" charactersIgnoringModifiers:@"" isARepeat:NO keyCode:123];
	[NSApp postEvent:event atStart:YES];
}

- (void)enableShortcuts
{
	theSource = NULL;
	
	NSString *path = [NSString stringWithFormat:@"%@%@%@", @"/Users/", NSUserName(), @"/Library/Preferences/com.lifeupnorth.Spotify-Menubar.plist"];
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
	
	NSDictionary *ppGH;
	NSDictionary *sfGH;
	NSDictionary *sbGH;
	
	if (dict) {
		ppGH = [dict objectForKey:@"ppGlobalHotkey"];
		sfGH = [dict objectForKey:@"sfGlobalHotkey"];
		sbGH = [dict objectForKey:@"sbGlobalHotkey"];
	} else {
		ppGH = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:49], @"keyCode", [NSNumber numberWithInt:2560], @"modifiers", nil];
		sfGH = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:124], @"keyCode", [NSNumber numberWithInt:8391168], @"modifiers", nil];
		sbGH = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:123], @"keyCode", [NSNumber numberWithInt:8391168], @"modifiers", nil];
	}
	
	[[NSUserDefaults standardUserDefaults] setObject:ppGH forKey:@"ppGHlun"];
	[[NSUserDefaults standardUserDefaults] setObject:sfGH forKey:@"sfGHlun"];
	[[NSUserDefaults standardUserDefaults] setObject:sbGH forKey:@"sbGHlun"];
	
	SDGlobalShortcutsController *shortcutsController = [SDGlobalShortcutsController sharedShortcutsController];
	[shortcutsController addShortcutFromDefaultsKey:@"ppGHlun"
										withControl:nil
											 target:self
										   selector:@selector(pauseMe)];
	[shortcutsController addShortcutFromDefaultsKey:@"sfGHlun"
										withControl:nil
											 target:self
										   selector:@selector(skipFwrd)];
	[shortcutsController addShortcutFromDefaultsKey:@"sbGHlun"
										withControl:nil
											 target:self
										   selector:@selector(skipBack)];
}

@end
