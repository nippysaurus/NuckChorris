//
//  FavoriteManager.h
//  NuckChorris
//
//  Created by Michael Dawson on 10/09/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteManager : NSObject
{
    NSMutableArray * _favorites;
}

@property (nonatomic, retain) NSMutableArray * favorites;

+ (FavoriteManager*)sharedInstance;

- (NSArray*)favoritesFromData;
- (BOOL)factIdIsFavorite:(NSInteger)thisFactId;
- (BOOL)toggleFavoriteForFactId:(NSInteger)thisFactId;

@end