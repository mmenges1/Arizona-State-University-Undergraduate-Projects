//
//  AppDelegate.h
//  DrawingApp
//
//  Created by Loren Olson on 10/28/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>


- (void)mouseDown:(NSEvent *)theEvent atPoint:(CGPoint)point;
- (void)mouseDragged:(NSEvent *)theEvent atPoint:(CGPoint)point;
- (void)mouseUp:(NSEvent *)theEvent atPoint:(CGPoint)point;


@end

