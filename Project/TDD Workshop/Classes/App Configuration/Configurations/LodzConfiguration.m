//  
//  Copyright (c) 2014 Mobile Warsaw All rights reserved.
//  


#import "LodzConfiguration.h"


@implementation LodzConfiguration
@synthesize parseApplicationId, parseClientId;

#pragma mark - Object life cycle

- (id)init {
    self = [super init];
    if (self) {
        self.parseApplicationId = @"5oTRM9ZzRulVw47Ls6u2hKz3h4PoFPc8GSNpM8mu";
        self.parseClientId = @"EAd3kEESWSUHBc7OJafFZ6ByulGKsfqgpXMYGneR";
    }
    return self;
}

@end
