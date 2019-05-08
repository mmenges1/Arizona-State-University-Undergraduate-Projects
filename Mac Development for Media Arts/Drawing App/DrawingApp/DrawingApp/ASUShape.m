//
//  ASUShape.m
//  DrawingApp
//
//  Created by Loren Olson on 11/2/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import "ASUShape.h"

static NSUInteger shapeCounter = 1;

@implementation ASUShape


// pt is the center of the shape.
// sz is the width/height.
- (instancetype)initAtPoint:(CGPoint)pt withSize:(CGSize)sz
{
    self = [super init];
    if (self) {
        _location = CGPointMake(pt.x, pt.y);
        _size = CGSizeMake(sz.width, sz.height);
        _angle = 0.0;
        _fillR = 0.9;
        _fillG = 0.9;
        _fillB = 0.9;
        _fillA = 1.0;
        _strokeR = 0.0;
        _strokeG = 0.0;
        _strokeB = 0.0;
        _strokeA = 1.0;
        _name = [NSString stringWithFormat:@"Shape-%lu", shapeCounter];
        _isSelected = NO;
        shapeCounter++;
    }
    return self;
}


- (void)render:(CGContextRef)context
{
    
}


// return YES if the point lies inside the bounds of the Shape rectangle defined by location and size.
- (BOOL)hit:(CGPoint)point
{
    float w2 = self.size.width/2;
    float h2 = self.size.height/2;
    if (point.x >= (self.location.x - w2) && point.x <= (self.location.x + w2) &&
        point.y >= (self.location.y - h2) && point.y <= (self.location.y + h2)) {
        return YES;
    }
    return NO;
}





@end
