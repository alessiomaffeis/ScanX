//
//  SXScanner.m
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import "SXScanner.h"

@implementation SXScanner {
    
    NSOperationQueue *_queue;
}

-(id) initWithItems:(NSArray *)items {
    
    [super init];
    
    if (self) {
        _items = [[NSMutableArray alloc] initWithArray:items];
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}

- (void) startScanning {
    
}

- (void) stopScanning {
    
}

-(void) dealloc {
    
    [_queue release];
    [_items release];
    [super dealloc];
}


// SXModuleDelegate methods:

- (void) storeValue:(NSNumber *) val forMetric:(NSString *) metric {
    
}



@end
