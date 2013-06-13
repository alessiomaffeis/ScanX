//
//  SXMetric.m
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import "SXMetric.h"

@implementation SXMetric

- (id) initWithName: (NSString *) name andInfo: (NSString *) info {
    
    [super init];
    
    if (self) {
        _name = name;
        _info = info;
    }
    
    return self;
}

@end
