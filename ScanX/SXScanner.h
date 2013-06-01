//
//  SXScanner.h
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SXModule.h"
#import "SXEvaluation.h"

@interface SXScanner : NSObject <SXModuleDelegate>

@property (readonly) NSMutableArray *items;
@property (readonly) NSInteger currentItem;
@property (readonly) NSMutableDictionary *modules;
@property (readonly) NSMutableDictionary *evaluations;

- (id) initWithItems:(NSArray *) items;
- (void) startScanning;
- (void) stopScanning;
- (void) addModule:(id <SXModule>) module withId:(NSString *) mId;
- (void) addEvaluation:(SXEvaluation *) evaluation withId:(NSString *) eId;

@end
