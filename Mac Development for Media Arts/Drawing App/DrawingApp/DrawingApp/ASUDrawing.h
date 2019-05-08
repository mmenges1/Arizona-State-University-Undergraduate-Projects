//
//  ASUDrawing.h
//  DrawingApp
//
//  Created by Loren Olson on 11/4/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASUShape.h"

@interface ASUDrawing : NSObject


@property (nonatomic) NSMutableArray * shapes;
@property (nonatomic, assign) float backgroundR;
@property (nonatomic, assign) float backgroundG;
@property (nonatomic, assign) float backgroundB;
@property (nonatomic, assign) float backgroundA;
@property (nonatomic, assign) BOOL rot;


- (void)render:(CGContextRef)context;
- (ASUShape *)findFirstHit:(CGPoint)point;
- (void)clearSelection;
- (void)deleteSelection;

@end
