//
//  SXModule.h
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXModuleDelegate.h"
#import "SXMetric.h"


@protocol SXModule <NSObject>

@property (assign) id <SXModuleDelegate> delegate;
@property (readonly) NSString *name;
@property (readonly) NSString *prefix;
@property (readonly) NSArray *metrics;

- (void) analyze:(id) item;

@end



