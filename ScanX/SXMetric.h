//
//  SXMetric.h
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SXMetric : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *info;

- (id) initWithName: (NSString *) name andInfo: (NSString *) info;

@end
