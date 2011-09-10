//
//  FactManager.m
//  NuckChorris
//
//  Created by Michael Dawson on 10/09/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "FactManager.h"

@implementation FactManager

@synthesize data = _data;

#pragma mark - MEMORY MANAGEMENT

- (id)init
{
    self = [super init];
    if (self)
    {
        NSString *factsPlistPath = [[NSBundle mainBundle] pathForResource:@"Facts" ofType:@"plist"];
        self.data = [[NSMutableDictionary alloc] initWithContentsOfFile:factsPlistPath];
    }
    return self;
}

+ (FactManager*)sharedInstance
{
	static FactManager *instance = nil;
	if (instance == nil)
	{
		@synchronized(self)
        {
			if (instance == nil)
            {
				instance = [[FactManager alloc] init];
            }
        }
	}
    return instance;
}

- (void)dealloc
{
    self.data = nil;

    [super dealloc];
}

#pragma mark - OTHER

- (NSArray*)factsFromData
{
    return (NSArray*)[self.data objectForKey:@"Facts"];
}

- (NSString*)factFromDataWithId:(NSInteger)id
{
    NSArray *factsArray = [self factsFromData];
    
    NSString *factText = [factsArray objectAtIndex:id];
    
    NSString *name = [self substituteName];
    
    NSString *newFact = [NSString stringWithFormat:factText, name];
    
    return newFact;
}

- (NSString*)substituteName
{
    NSString *substituteNameFromUserDefaults = [[NSUserDefaults standardUserDefaults] stringForKey:@"SubstituteName"];
    
    if (substituteNameFromUserDefaults == nil)
    {
        return @"Nuck Chorris";
    }
    
    return substituteNameFromUserDefaults;
}

- (void)setSubstituteName:(NSString*)thisName
{
    //NSLog(@"updating substitute name to \"%@\"", thisName);
    
    [[NSUserDefaults standardUserDefaults] setValue:thisName forKey:@"SubstituteName"];
    //[self->data setValue:thisName forKey:@"SubstituteName"];
    
    //[self saveDataFile];
}


@end