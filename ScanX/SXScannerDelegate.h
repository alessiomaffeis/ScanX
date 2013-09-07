//
//  SXScannerDelegate.h
//  ScanX
//
//  Created by Alessio Maffeis on 05/06/13.
//  Copyright (c) 2013 Alessio Maffeis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SXScannerDelegate <NSObject>

- (void) scanHasFinished;
- (void) evaluationHasFinished;
- (void) remainingScansDidChange;
- (void) remainingEvaluationsDidChange;

@end
