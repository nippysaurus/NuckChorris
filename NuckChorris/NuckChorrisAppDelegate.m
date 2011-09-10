//
//  NuckChorrisAppDelegate.m
//  NuckChorris
//
//  Created by Michael Dawson on 26/06/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "NuckChorrisAppDelegate.h"

@interface NuckChorrisAppDelegate ()

@end

@implementation NuckChorrisAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

@synthesize randomViewNeedsUpdate = _randomViewNeedsUpdate;
@synthesize listViewNeedsUpdate = _listViewNeedsUpdate;
@synthesize favorteViewNeedsUpdate = _favorteViewNeedsUpdate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.randomViewNeedsUpdate = NO;
    self.listViewNeedsUpdate = NO;
    self.favorteViewNeedsUpdate = NO;
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [SHK setRootViewController:self.tabBarController];
    
    return YES;
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];

    [super dealloc];
}

#pragma mark - Data Management

@end