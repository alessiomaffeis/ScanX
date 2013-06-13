//
//  SXScanner.m
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import "SXScanner.h"

@implementation SXScanner {
    
    NSOperationQueue *_scanQueue;
    NSOperationQueue *_evalQueue;
}

- (id) init {
    
    [super init];
    
    if (self) {
        _items = [[NSMutableDictionary alloc] init];
        _modules = [[NSMutableDictionary alloc] init];
        _evaluations = [[NSMutableDictionary alloc] init];
        _computedMetrics = [[NSMutableDictionary alloc] init];
        _computedEvaluations = [[NSMutableDictionary alloc] init];
        _scanQueue = [[NSOperationQueue alloc] init];
        _scanQueue.maxConcurrentOperationCount = 1;
        _evalQueue = [[NSOperationQueue alloc] init];

    }
    
    return self;
}

- (id) initWithItems:(NSDictionary *)items {
    
    [super init];
    
    if (self) {
        [self init];
        [_items addEntriesFromDictionary:items];
    }
    
    return self;
}

- (BOOL) addItems:(NSDictionary *)items {
    
    if(_isScanning || _hasPerformedScan)
        return NO;

    [_items addEntriesFromDictionary:items ];
    return YES;
}

- (BOOL) addItem:(id)item withId:(NSString *)iId {
    
    if(_isScanning || _hasPerformedScan)
        return NO;
    
    [_items setObject:item forKey:iId];
    return YES;
}

- (BOOL) addModule:(id <SXModule>) module withId:(NSString *) mId {
    
    if(_isScanning || _hasPerformedScan)
        return NO;
    
    [_modules setObject:module forKey:mId];
    return YES;
}

- (BOOL) addEvaluation:(SXEvaluation *) evaluation withId:(NSString *) eId {
    
    if(_isEvaluating || _hasPerformedEvaluation)
        return NO;
    
    [_evaluations setObject:evaluation forKey:eId];
    return YES;
}

- (BOOL) startScanning {
    
    if(_isScanning || _hasPerformedScan)
        return NO;
    
    _isScanning = YES;
    id item;
    id <SXModule> module;
    
    for (NSString* itemId in _items) {
        
        item = [_items objectForKey:itemId];
        
        for (NSString* modId in _modules) {

            module = [_modules objectForKey:modId];
            [_scanQueue addOperation:[[NSInvocationOperation alloc] initWithTarget:module selector:@selector(analyze:) object:item]];
        }
    }
    
    return YES;
}

- (void) stopScanning {
    if (_isScanning)
        [_scanQueue cancelAllOperations];
    _isScanning = NO;
}

- (BOOL) startEvaluating {
    
    if(_isEvaluating || _hasPerformedEvaluation)
        return NO;
    
    _isEvaluating = YES;
    id item;
    SXEvaluation *evaluation;
    
    for (NSString *itemId in _items) {
        
        item = [_items objectForKey:itemId];
        for (NSString *evalId in _evaluations)
        {
            evaluation = [_evaluations objectForKey:evalId];
            [_evalQueue addOperation:[[NSInvocationOperation alloc]initWithTarget:evaluation selector:@selector(evaluate:) object:itemId]];
        }
    }

    return YES;
}

- (void) stopEvaluating {
    if (_isEvaluating)
        [_evalQueue cancelAllOperations];
    _isEvaluating = NO;
}

- (void) dealloc {
    
    [_evalQueue release];
    [_scanQueue release];
    [_items release];
    [_computedEvaluations release];
    [_computedMetrics release];
    [_evaluations release];
    [_modules release];
    
    [super dealloc];
}


// SXModuleDelegate methods:

- (void) storeMetrics:(NSDictionary *) metrics forItem:(NSString *) itemId {
    
    NSMutableDictionary *itemMetrics = [_computedMetrics objectForKey:itemId];
    [itemMetrics addEntriesFromDictionary:metrics];
}


// SXEvaluationDelegate methods:

- (NSDictionary *) metricsForItem:(NSString*) itemId {

    return [_computedMetrics objectForKey:itemId];
}

- (void) storeResult:(NSNumber *) result forItem:(NSString *) itemId withName:(NSString *) name {
    
    NSMutableDictionary *itemEvals = [_computedEvaluations objectForKey:itemId];
    [itemEvals setObject:result forKey:name];
}

@end
