//
//  SXScanner.h
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SXModule.h"
#import "SXScannerDelegate.h"   
#import "SXEvaluation.h"




@interface SXScanner : NSObject <SXModuleDelegate, SXEvaluationDelegate>

@property (assign) id <SXScannerDelegate> delegate;

@property (readonly) NSMutableDictionary *items;
@property (readonly) NSMutableDictionary *modules;
@property (readonly) NSMutableDictionary *evaluations;
@property (readonly) NSMutableDictionary *computedMetrics;
@property (readonly) NSMutableDictionary *computedEvaluations;

@property (readonly) NSUInteger remainingItems;
@property (readonly) NSUInteger remainingEvaluations;

@property (readonly) BOOL isScanning;
@property (readonly) BOOL isEvaluating;
@property (readonly) BOOL hasPerformedScan;
@property (readonly) BOOL hasPerformedEvaluation;

- (id) initWithItems:(NSDictionary *) items;
- (BOOL) addItem:(id) item withId:(NSString *) iId;
- (BOOL) addItems:(NSDictionary *) items;
- (BOOL) addModule:(id <SXModule>) module withId:(NSString *) mId;
- (BOOL) addEvaluation:(SXEvaluation *) evaluation withId:(NSString *) eId;

- (BOOL) startScanning;
- (void) stopScanning;
- (BOOL) startEvaluating;
- (void) stopEvaluating;

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context;

@end
