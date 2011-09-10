//
//  FavoriteManager.m
//  NuckChorris
//
//  Created by Michael Dawson on 10/09/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "FavoriteManager.h"

@implementation FavoriteManager

@synthesize favorites = _favorites;

#pragma mark - MEMORY MANAGEMENT

- (id)init
{
    self = [super init];
    if (self)
    {
        self.favorites = [[NSUserDefaults standardUserDefaults] mutableArrayValueForKey:@"Favorites"];
    }
    return self;
}

+ (FavoriteManager*)sharedInstance
{
	static FavoriteManager *instance = nil;
	if (instance == nil)
	{
		@synchronized(self)
        {
			if (instance == nil)
            {
				instance = [[FavoriteManager alloc] init];
            }
        }
	}
    return instance;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Data Management \ Favorites

- (NSArray*)favoritesFromData
{
    return [NSArray arrayWithArray:self.favorites];
}

- (BOOL)factIdIsFavorite:(NSInteger)thisFactId
{
    NSNumber *thisFactIdNumber = [NSNumber numberWithInt:thisFactId];
    
    for (NSNumber *number in self.favorites)
        if ([thisFactIdNumber isEqualToNumber:number] == YES)
            return YES;
    
    return NO;
}

- (BOOL)toggleFavoriteForFactId:(NSInteger)thisFactId
{    
    BOOL isFavourite = [self factIdIsFavorite:thisFactId];
    
    if (isFavourite == YES)
        // remove from array
        [self.favorites removeObject:[NSNumber numberWithInt:thisFactId]];
    else
        // add to array
        [self.favorites addObject:[NSNumber numberWithInt:thisFactId]];
    
    [[NSUserDefaults standardUserDefaults] setValue:self.favorites forKey:@"Favorites"];
    
    return !isFavourite;
}

@end