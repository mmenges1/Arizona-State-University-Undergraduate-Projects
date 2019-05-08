//
//  ASUGraphicsView.m
//  DrawingApp
//
//  Created by Loren Olson on 10/28/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import "ASUGraphicsView.h"
#import "ASUDrawing.h"
#import "ASURectangle.h"


@interface ASUGraphicsView ()

@end

@implementation ASUGraphicsView
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if (self.drawing == nil) return;
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, self.drawing.backgroundR, self.drawing.backgroundG, self.drawing.backgroundB, self.drawing.backgroundA);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    [self.drawing render:context];
}



- (void)mouseDown:(NSEvent *)theEvent
{
    CGPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    NSLog(@"mouseDown: <%f, %f>", point.x, point.y);
    
    [self.controller mouseDown:theEvent atPoint:point];
    [self setNeedsDisplay:YES];
    
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    CGPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    NSLog(@"mouseDragged: <%f, %f>", point.x, point.y);
    [self.controller mouseDragged:theEvent atPoint:point];
    
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    CGPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    NSLog(@"mouseUp: <%f, %f>", point.x, point.y);
    
    [self.controller mouseUp:theEvent atPoint:point];
    
    [self setNeedsDisplay:YES];
}

- (void)keyDown:(NSEvent *)theEvent
{
    NSLog(@"keyDown: %@ %d", [theEvent charactersIgnoringModifiers], [theEvent keyCode]);
    
    if ([theEvent keyCode] == 11) {
        NSLog(@"BOOM - 11 is the keycode for the b key");
        NSLog(@"This demonstrates how to handle a keypress in a Custom View.");
    }
    else {
        // If its not a key we are looking for - pass the event on to the superview.
        // This will allow another object in the view hierarchy to perhaps answer to
        // this event. For example, a button hot key.
        [super keyDown:theEvent];
    }
}



- (BOOL)acceptsFirstResponder
{
    return YES;
}

@end
