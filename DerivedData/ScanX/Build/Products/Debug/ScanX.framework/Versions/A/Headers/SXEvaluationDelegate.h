//
//  SXEvaluationDelegate.h
//  ScanX
//
//  Created by Alessio Maffeis on 13/06/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SXEvaluationDelegate <NSObject>

- (void) storeResult:(NSNumber *) result forItem:(NSString *) itemId withName:(NSString *) name;
- (NSDictionary *) metricsForItem:(NSString*) itemId;

@end
