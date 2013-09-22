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
    
    self = [super init];
    if (self) {
        _items = [[NSMutableDictionary alloc] init];
        _modules = [[NSMutableDictionary alloc] init];
        _evaluations = [[NSMutableDictionary alloc] init];
        _computedMetrics = [[NSMutableDictionary alloc] init];
        _computedEvaluations = [[NSMutableDictionary alloc] init];
        _scanQueue = [[NSOperationQueue alloc] init];
        _evalQueue = [[NSOperationQueue alloc] init];

    }
    
    return self;
}

- (id) initWithItems:(NSDictionary *)items {
    
    self = [super init];
    
    if (self) {
        _items = [[NSMutableDictionary alloc] init];
        _modules = [[NSMutableDictionary alloc] init];
        _evaluations = [[NSMutableDictionary alloc] init];
        _computedMetrics = [[NSMutableDictionary alloc] init];
        _computedEvaluations = [[NSMutableDictionary alloc] init];
        _scanQueue = [[NSOperationQueue alloc] init];
        _evalQueue = [[NSOperationQueue alloc] init];
        
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
    
    module.delegate = self;
    [_modules setObject:module forKey:mId];
    return YES;
}

- (BOOL) addEvaluation:(SXEvaluation *) evaluation withId:(NSString *) eId {
    
    if(_isEvaluating || _hasPerformedEvaluation)
        return NO;
    
    evaluation.delegate = self;
    [_evaluations setObject:evaluation forKey:eId];
    return YES;
}

- (BOOL) startScanning {
    
    if(_isScanning || _hasPerformedScan)
        return NO;
    
    _isScanning = YES;
    
    [_scanQueue addObserver:self forKeyPath:@"operationCount" options:NSKeyValueObservingOptionNew context:NULL];
    
    id item;
    id <SXModule> module;
    
    
    for (NSString *modId in _modules)
    {
        module = [_modules objectForKey:modId];
        
        for (NSString *itemId in _items)
        {
            item = [_items objectForKey:itemId];
        
            [_scanQueue addOperation:[[[NSInvocationOperation alloc] initWithTarget:module selector:@selector(analyze:) object:[NSArray arrayWithObjects:itemId, item, nil]] autorelease]];
        }
    }
    
    [_scanQueue waitUntilAllOperationsAreFinished];
    [_delegate scanHasFinished];
    
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
    SXEvaluation *evaluation;
    
    for (NSString *evalId in _evaluations)
    {
        for (NSString *itemId in _items)
        {
            evaluation = [_evaluations objectForKey:evalId];
            [_evalQueue addOperation:[[[NSInvocationOperation alloc]initWithTarget:evaluation selector:@selector(evaluateItem:) object:itemId] autorelease]];
        }
    }
    
    [_evalQueue waitUntilAllOperationsAreFinished];
    [_delegate evaluationHasFinished];

    return YES;
}

- (void) stopEvaluating {
    if (_isEvaluating)
        [_evalQueue cancelAllOperations];
    _isEvaluating = NO;
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if (object == _scanQueue) {
                
        if ([keyPath isEqual:@"operationCount"]) {

            _remainingScans = _scanQueue.operationCount;
            [_delegate remainingScansDidChange];
        }
    }
    else if (object == _evalQueue) {
        
        if ([keyPath isEqual:@"operationCount"]) {
            
            _remainingEvaluations = _evalQueue.operationCount;
            [_delegate remainingEvaluationsDidChange];
        }
    }
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
    
    @synchronized(_computedMetrics) {
        
        NSMutableDictionary *itemMetrics = [_computedMetrics objectForKey:itemId];
    
        if (itemMetrics == nil) {
            itemMetrics = [NSMutableDictionary dictionaryWithDictionary:metrics];
            [_computedMetrics setObject:itemMetrics forKey:itemId];
        }
        else {
            [itemMetrics addEntriesFromDictionary:metrics];
        }
    }
}


// SXEvaluationDelegate methods:

- (NSDictionary *) metricsForItem:(NSString*) itemId {

    return [_computedMetrics objectForKey:itemId];
}

- (void) storeResult:(NSNumber *) result forItem:(NSString *) itemId withName:(NSString *) name {
    
    @synchronized(_computedEvaluations) {
        
        NSMutableDictionary *itemEvals = [_computedEvaluations objectForKey:itemId];
        
        if (itemEvals == nil) {
            id res = result == nil ? [NSNull null] : result;
            itemEvals = [NSMutableDictionary dictionaryWithObject:res forKey:name];
            [_computedEvaluations setObject:itemEvals forKey:itemId];
        }
        else {
            [itemEvals setObject:result forKey:name];
        }
    }
}

@end
