//
//  ASUDrawing.m
//  DrawingApp
//
//  Created by Loren Olson on 11/4/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import "ASUDrawing.h"

@implementation ASUDrawing

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shapes = [NSMutableArray array];
        _backgroundR = 0.5;
        _backgroundG = 0.5;
        _backgroundB = 0.5;
        _backgroundA = 1.0;
        
    }
    return self;
}

- (void)render:(CGContextRef)context
{
    for (ASUShape * shape in self.shapes) {
        [shape render:context];
    }
}

- (ASUShape *)findFirstHit:(CGPoint)point
{
    for (ASUShape * shape in self.shapes) {
        if ([shape hit:point]) {
            return shape;
        }
    }
    return nil;
}

- (void)clearSelection
{
    for (ASUShape * shape in self.shapes) {
        shape.isSelected = NO;
    }
}
- (void)deleteSelection
{
    for (ASUShape * shape in self.shapes) {
        if (shape.isSelected)
        {
            [self.shapes removeObject:shape];
        }
    }
}
@end
