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
    NSArray * _fact_strings;
    NSArray * _fact_numbers;
}

@property (nonatomic, retain) NSArray * fact_strings;
@property (nonatomic, retain) NSArray * fact_numbers;

+ (FactManager*)sharedInstance;

- (NSArray*)factsFromData;
- (NSString*)factFromDataWithId:(NSInteger)id;
- (NSString*)substituteName;
- (void)setSubstituteName:(NSString*)thisName;

@end