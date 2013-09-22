//
//  SXEvaluation.m
//  ScanX
//
//  Created by Alessio Maffeis on 31/05/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import "SXEvaluation.h"

@implementation SXEvaluation {
    DDMathEvaluator *_evaluator;
}

- (id) initWithName:(NSString *) name andExpression:(NSString *) expression {
    
    self = [super init];
    if (self) {
        [name retain];
        [expression retain];
        _name = name;
        _expression = expression;
        _evaluator = [DDMathEvaluator sharedMathEvaluator];
    }
    return self;
}

- (void) evaluateItem:(NSString *) itemId {
    
    NSDictionary *metrics = [_delegate metricsForItem:itemId];
    
    NSNumber *value = [_evaluator evaluateString:_expression withSubstitutions:metrics];
    [_delegate storeResult:value forItem:itemId withName:_name];
}

-(void) dealloc {
    
    [_name release];
    [_expression release];
    [super dealloc];
}

@end
