//
//  SXModuleDelegate.h
//  ScanX
//
//  Created by Alessio Maffeis on 05/06/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SXModuleDelegate <NSObject>

- (void) storeMetrics:(NSDictionary *) metrics forItem:(NSString *) itemId;

@end
