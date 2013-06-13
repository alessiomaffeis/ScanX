//
//  SXEvaluation.h
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SXEvaluationDelegate.h"
#import "DDMathParser.h"

@interface SXEvaluation : NSObject

@property (assign) id<SXEvaluationDelegate> delegate;
@property (readonly) NSString *name;
@property (strong) NSString *expression;

- (id) initWithName:(NSString *) name andExpression:(NSString *) expression;
- (void) evaluateItem:(NSString *) itemId;
@end
