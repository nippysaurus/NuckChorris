//
//  NuckChorrisAppDelegate.m
//  NuckChorris
//
//  Created by Michael Dawson on 26/06/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "NuckChorrisAppDelegate.h"

//#import "NuckChorrisViewController.h"

@interface NuckChorrisAppDelegate ()

//-(NSArray*)factsFromPlist;

@end

@implementation NuckChorrisAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

@synthesize randomViewNeedsUpdate = _randomViewNeedsUpdate;
@synthesize listViewNeedsUpdate = _listViewNeedsUpdate;
@synthesize favorteViewNeedsUpdate = _favorteViewNeedsUpdate;

//@synthesize nameChanged = _nameChanged;
//@synthesize favoritesChanged = _favoritesChanged;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadDataFile];
    
//    self.nameChanged = [NSDate date];
//    self.favoritesChanged = [NSDate date];

    self.randomViewNeedsUpdate = NO;
    self.listViewNeedsUpdate = NO;
    self.favorteViewNeedsUpdate = NO;
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [SHK setRootViewController:self.tabBarController];
    
    return YES;
}

//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    /*
//     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//     */
//}
//
//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    /*
//     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
//     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//     */
//}
//
//- (void)applicationWillEnterForeground:(UIApplication *)application
//{
//    /*
//     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//     */
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    /*
//     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//     */
//}
//
//- (void)applicationWillTerminate:(UIApplication *)application
//{
//    /*
//     Called when the application is about to terminate.
//     Save data if appropriate.
//     See also applicationDidEnterBackground:.
//     */
//}

- (void)dealloc
{
    [_window release];
    //[_viewController release];
    //[_facts release];
    [_tabBarController release];
    [super dealloc];
}

#pragma mark - Data Management

- (void)loadDataFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
        
    // determine path for "Data.plist" from Document directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *docPath = [docDir stringByAppendingPathComponent:@"Data.plist"];
    
    // move to document directory if not there already
    if ([fileManager fileExistsAtPath:docPath] == NO)
    {
        NSLog(@"moving data.plist to document directory");
        
        // bundled file path
        NSString *factsPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        
        NSError *error;
        
        BOOL success = [fileManager copyItemAtPath:factsPath toPath:docPath error:&error];
        
        if (success == NO)
            @throw [NSException exceptionWithName:@"ConfigurationException" reason:@"could not copy data to document directory" userInfo:nil];
    }
    
    NSLog(@"loading data.plist from document directory");
    
    self->data = [[NSMutableDictionary alloc] initWithContentsOfFile:docPath];
}

- (void)saveDataFile
{
    NSLog(@"saving changes to file");
    
    // determine path for "Data.plist" from Document directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *docPath = [docDir stringByAppendingPathComponent:@"Data.plist"];
    
    // write data
    [self->data writeToFile:docPath atomically:NO];
}

#pragma mark - Data Management \ Facts

- (NSArray*)factsFromData
{
    return (NSArray*)[self->data objectForKey:@"Facts"];
}

- (NSString*)factFromDataWithId:(NSInteger)id
{
    NSArray *factsArray = [self factsFromData];
    
    NSString *factText = [factsArray objectAtIndex:id];
    
    NSString *name = [self nameFromData];
    
    NSString *newFact = [NSString stringWithFormat:factText, name];
    
    return newFact;
}

#pragma mark - Data Management \ Favorites

- (NSArray*)favoritesFromData
{
    return (NSArray*)[self->data objectForKey:@"Favourites"];
}

- (BOOL)factIdIsFavorite:(NSInteger)thisFactId
{
    NSNumber *thisFactIdNumber = [NSNumber numberWithInt:thisFactId];

    for (NSNumber *number in [self favoritesFromData])
        if ([thisFactIdNumber isEqualToNumber:number] == YES)
            return YES;
    
    return NO;
}

- (BOOL)toggleFavoriteForFactId:(NSInteger)thisFactId
{    
    BOOL isFavourite = [self factIdIsFavorite:thisFactId];
    
    NSMutableArray *mutable = [NSMutableArray arrayWithArray:[self favoritesFromData]];
    
    if (isFavourite == YES)
        // remove from array
        [mutable removeObject:[NSNumber numberWithInt:thisFactId]];
    else
        // add to array
        [mutable addObject:[NSNumber numberWithInt:thisFactId]];
    
    [self->data setValue:[NSArray arrayWithArray:mutable] forKey:@"Favourites"];
 
    [self saveDataFile];
    
    return !isFavourite;
}

#pragma mark - Data Management \ Name

- (NSString*)nameFromData
{
    return (NSString*)[self->data objectForKey:@"SubstituteName"];
}

- (void)setNameFromData:(NSString*)thisName
{
    NSLog(@"updating substitute name to \"%@\"", thisName);
    
    [self->data setValue:thisName forKey:@"SubstituteName"];
    
    [self saveDataFile];
}

@end