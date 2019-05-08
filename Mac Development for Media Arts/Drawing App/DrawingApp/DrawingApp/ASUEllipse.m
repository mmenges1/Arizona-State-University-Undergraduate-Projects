//
//  ASUEllipse.m
//  DrawingApp
//
//  Created by mmenges1 on 11/10/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import "ASUEllipse.h"

@implementation ASUEllipse

- (void)render:(CGContextRef)context
{
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, self.location.x, self.location.y);
    CGContextRotateCTM(context, self.angle);
    
    // draw the rectangle here...
    CGContextSetRGBFillColor(context, self.fillR, self.fillG, self.fillB, self.fillA);
    CGRect r = CGRectMake(-self.size.width/2.0, -self.size.height/2.0, self.size.width, self.size.height);
    CGContextFillEllipseInRect(context, r);
    
    CGContextSetRGBStrokeColor(context, self.strokeR, self.strokeG, self.strokeB, self.strokeA);
    CGContextStrokeEllipseInRect(context, r);
    
    if (self.isSelected) {
        // If the rectangle is selected, do a red stroke
        CGContextSetLineWidth(context, 5.0);
        CGContextSetRGBStrokeColor(context, 1.0, 0.1, 0.1, 0.8);
        CGContextStrokeEllipseInRect(context, r);
    }
    
    
    CGContextRestoreGState(context);
}

@end
