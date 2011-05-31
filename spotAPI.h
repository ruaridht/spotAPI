//
//  spotAPI.h
//  spotAPI
//
//  Created by Ruaridh Thomson on 09/09/2010.
//  Copyright 2010 Life Up North. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "something.h"
#import "GrowlApplicationBridgeDelegate-Protocol.h"

@interface SPGrowlDelegate : NSObject <GrowlApplicationBridgeDelegate> {}
+ (void)initialize;
+ (id)sharedInstance;
- (id)registrationDictionaryForGrowl;
- (void)notificationWithTrackInfo:(struct TrackInfo *)arg1;
- (void)growlNotificationWasClicked:(id)arg1;
@end


@interface spotAPI : NSObject {
	NSTimer *updateTimer;
	
	NSString *nowPlaying;
	NSString *prevPlayed;
	
	
	int _selectedPID;
	int _lastAttachedPID;
	
	CGEventSourceRef theSource;
	
	//SpotifyController *controller;
}

+ (void)load;
+ (spotAPI*) sharedInstance;

- (void)swizzleGrowl;
- (void)enableShortcuts;
- (void)pauseMe;
- (void)skipFwrd;
- (void)skipBack;

@end
