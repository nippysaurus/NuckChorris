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
    NSMutableArray *result = [[NSMutableArray alloc] init];

    NSArray * fact_numbers = [FactManager sharedInstance].fact_numbers;
    
    for (NSNumber *favoriteNumber in self.favorites)
    {
        for (int i = 0; i < [fact_numbers count]; ++i)
        {
            
            NSString *fact_number = [fact_numbers objectAtIndex:i];// THIS IS A STRING !
            NSNumber *fact_number_num = nil;
            
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            fact_number_num = [f numberFromString:fact_number];
            [f release];
            
            if ([fact_number_num isEqualToNumber:favoriteNumber] == YES)
            {
                [result addObject:[NSNumber numberWithInt:i]];
            }
        }
    }

    return [NSArray arrayWithArray:result];
}

- (BOOL)factIdIsFavorite:(NSInteger)thisFactId
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    //NSNumber * myNumber = [f numberFromString:@"42"];
    
    // first need to find the "number" for this fact id
    NSString *factNumberString = [[FactManager sharedInstance].fact_numbers objectAtIndex:thisFactId];
    NSNumber *factNumber = [f numberFromString:factNumberString];

    [f release];
    
    //NSNumber *thisFactIdNumber = [NSNumber numberWithInt:thisFactId];
    
    for (NSNumber *number in self.favorites)
        if ([factNumber isEqualToNumber:number] == YES)
            return YES;
    
    return NO;
}

- (BOOL)toggleFavoriteForFactId:(NSInteger)thisFactId
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    //NSNumber * myNumber = [f numberFromString:@"42"];
    
    // first need to find the "number" for this fact id
    NSString *factNumberString = [[FactManager sharedInstance].fact_numbers objectAtIndex:thisFactId];
    NSNumber *factNumber = [f numberFromString:factNumberString];
    
    [f release];
    
    BOOL isFavourite = [self factIdIsFavorite:thisFactId];
    
    if (isFavourite == YES)
        // remove from array
        //[self.favorites removeObject:[NSNumber numberWithInt:thisFactId]];
        [self.favorites removeObject:factNumber];
    else
        // add to array
        //[self.favorites addObject:[NSNumber numberWithInt:thisFactId]];
        [self.favorites addObject:factNumber];
    
    [[NSUserDefaults standardUserDefaults] setValue:self.favorites forKey:@"Favorites"];
    
    return !isFavourite;
}

@end