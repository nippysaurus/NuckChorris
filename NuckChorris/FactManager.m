//
//  FactManager.m
//  NuckChorris
//
//  Created by Michael Dawson on 10/09/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "FactManager.h"

@implementation FactManager

@synthesize fact_strings = _fact_strings;
@synthesize fact_numbers = _fact_numbers;

#pragma mark - MEMORY MANAGEMENT

- (id)init
{
    self = [super init];
    if (self)
    {
        NSString *factsPlistPath = [[NSBundle mainBundle] pathForResource:@"Facts" ofType:@"plist"];

        NSDictionary * plist = [[NSMutableDictionary alloc] initWithContentsOfFile:factsPlistPath];
        NSArray *facts = [plist objectForKey:@"Facts"];
        
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        NSMutableArray *strings = [[NSMutableArray alloc] init];
        
        for (NSDictionary *nsd in facts)
        {
            NSString *number = [nsd objectForKey:@"number"];
            NSString *string = [nsd objectForKey:@"string"];
            
            [numbers addObject:number];
            [strings addObject:string];
        }
        
        self.fact_numbers = numbers;
        self.fact_strings = strings;
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
    self.fact_strings = nil;
    self.fact_numbers = nil;

    [super dealloc];
}

#pragma mark - OTHER

- (NSArray*)factsFromData
{
    //return (NSArray*)[self.data objectForKey:@"Facts"];
    return [NSArray arrayWithArray:self.fact_strings];
}

- (NSString*)factFromDataWithId:(NSInteger)id
{
    //NSArray *factsArray = [self factsFromData];
    
    NSString *factText = [self.fact_strings objectAtIndex:id];
    
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