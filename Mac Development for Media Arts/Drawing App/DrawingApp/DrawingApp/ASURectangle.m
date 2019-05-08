//
//  ASURectangle.m
//  DrawingApp
//
//  Created by Loren Olson on 11/2/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import "ASURectangle.h"

@implementation ASURectangle
- (void)render:(CGContextRef)context
{
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, self.location.x, self.location.y);
    CGContextRotateCTM(context, self.angle);
    
    // draw the rectangle here...
    CGContextSetRGBFillColor(context, self.fillR, self.fillG, self.fillB, self.fillA);
    CGRect r = CGRectMake(-self.size.width/2.0, -self.size.height/2.0, self.size.width, self.size.height);
    CGContextFillRect(context, r);
    
    CGContextSetRGBStrokeColor(context, self.strokeR, self.strokeG, self.strokeB, self.strokeA);
    CGContextStrokeRect(context, r);
    
    if (self.isSelected) {
        // If the rectangle is selected, do a red stroke
        CGContextSetLineWidth(context, 5.0);
        CGContextSetRGBStrokeColor(context, 1.0, 0.1, 0.1, 0.8);
        CGContextStrokeRect(context, r);
    }
    
    
    CGContextRestoreGState(context);
}

@end
