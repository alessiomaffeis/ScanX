//
//  SXEvaluation.h
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DDMathParser.h"

@interface SXEvaluation : NSObject

@property (strong) NSString *expression;
@property (readonly) NSNumber *value;

- (id) initWithExpression:(NSString *) expression;
- (NSNumber *) evaluate;

@end
