//
//  AppDelegate.m
//  GCControllerTester
//
//  Created by Scott Lembcke on 11/29/13.
//  Copyright (c) 2013 Howling Moon Software. All rights reserved.
//

#import "AppDelegate.h"
#import "TesterController.h"

#import <GameController/GameController.h>


@implementation AppDelegate {
	UIWindow *_window;
	
	UIViewController *_connect;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	_connect = [[UIViewController alloc] initWithNibName:@"Connect" bundle:nil];
	
	_window.rootViewController = _connect;
	[_window makeKeyAndVisible];
	
	[[NSNotificationCenter defaultCenter] addObserverForName:GCControllerDidConnectNotification object:nil queue:nil
		usingBlock:^(NSNotification *notification){
			_window.rootViewController = [[TesterController alloc] initWithController:notification.object];
		}
	];
	
	[[NSNotificationCenter defaultCenter] addObserverForName:GCControllerDidDisconnectNotification object:nil queue:nil
		usingBlock:^(NSNotification *notification){
			_window.rootViewController = _connect;
		}
	];
	
	return YES;
}

@end
