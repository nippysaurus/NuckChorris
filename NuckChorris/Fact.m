//
//  Fact.m
//  NuckChorris
//
//  Created by Michael Dawson on 10/09/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "Fact.h"

@implementation Fact

@synthesize number = _number;
@synthesize string = _string;

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        // Initialization code here.
//    }
//    
//    return self;
//}

- (void)dealloc
{
    self.number = nil;
    self.string = nil;
    
    [super dealloc];
}

@end