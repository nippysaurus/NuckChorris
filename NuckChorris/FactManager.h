//
//  FactManager.h
//  NuckChorris
//
//  Created by Michael Dawson on 10/09/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactManager : NSObject
{
    NSMutableDictionary * _data;
}

@property (nonatomic, retain) NSMutableDictionary * data;

+ (FactManager*)sharedInstance;

- (NSArray*)factsFromData;
- (NSString*)factFromDataWithId:(NSInteger)id;
- (NSString*)substituteName;
- (void)setSubstituteName:(NSString*)thisName;

@end