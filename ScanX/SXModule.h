//
//  SXModule.h
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SXModuleDelegate <NSObject>

@property (readonly) NSMutableArray *items;
- (void) storeValue:(NSNumber *) val forMetric:(NSString *) metric;

@end


@protocol SXModule <NSObject>

@property (assign) id <SXModuleDelegate> delegate;
@property (readonly) NSString *name;
@property (readonly) NSString *prefix;
@property (readonly) NSArray *metrics;

- (void) operation;

@end



