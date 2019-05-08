//
//  AppDelegate.m
//  DrawingApp
//
//  Created by Loren Olson on 10/28/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import "AppDelegate.h"
#import "ASUGraphicsView.h"
#import "ASUDrawing.h"
#import "ASURectangle.h"
#import "ASUEllipse.h"


typedef enum : NSUInteger {
    ToolModeSelect,
    ToolModeRectangle,
    ToolModeEllipse,
    ToolModeDelete,
    ToolModeRotate,
    ToolModeFill
} ToolMode;

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic) ASUDrawing * drawing;
@property (weak) IBOutlet ASUGraphicsView *graphicsView;

@property (nonatomic, assign) CGPoint mouseDownLocation;
@property (nonatomic, assign) CGPoint mouseLocation;
@property (nonatomic) ASUShape * dragShape;

@property (nonatomic, assign) NSUInteger toolMode;

@property (weak) IBOutlet NSTextField *rotat;
@property (weak) IBOutlet NSTextField *fillRed;
@property (weak) IBOutlet NSTextField *fillGreen;
@property (weak) IBOutlet NSTextField *fillBlue;
@property (weak) IBOutlet NSTextField *fillAlpha;


@end

@implementation AppDelegate

- (IBAction)select:(id)sender {
    NSLog(@"select");
    self.toolMode = ToolModeSelect;
}
- (IBAction)rectangle:(id)sender {
    NSLog(@"rectangle");
    self.toolMode = ToolModeRectangle;
}
- (IBAction)ellipse:(id)sender {
    NSLog(@"ellipse");
    self.toolMode = ToolModeEllipse;
}
- (IBAction)delete:(id)sender {
    NSLog(@"delete");
    self.toolMode = ToolModeDelete;
}
- (IBAction)rotate:(id)sender {
    NSLog(@"rotate");
    self.toolMode = ToolModeRotate;
}
- (IBAction)fillRed:(id)sender {
    NSLog(@"Red");
    self.toolMode = ToolModeFill;
}
- (IBAction)fillGreen:(id)sender {
    NSLog(@"Green");
    self.toolMode = ToolModeFill;
}
- (IBAction)fillBlue:(id)sender {
    NSLog(@"Blue");
    self.toolMode = ToolModeFill;
}
- (IBAction)fillAlpha:(id)sender {
    NSLog(@"Alpha");
    self.toolMode = ToolModeFill;
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSLog(@"make the drawing object");
    self.drawing = [[ASUDrawing alloc] init];
    self.graphicsView.drawing = self.drawing;
    self.graphicsView.controller = self;
    [self.graphicsView setNeedsDisplay:YES];
    self.dragShape = nil;
    self.toolMode = ToolModeRectangle;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)mouseDown:(NSEvent *)theEvent atPoint:(CGPoint)point
{
    self.mouseDownLocation = point;
    self.mouseLocation = point;
    self.dragShape = nil;
}

- (void)mouseDragged:(NSEvent *)theEvent atPoint:(CGPoint)point
{
    self.mouseLocation = point;
    
    if (self.toolMode == ToolModeRectangle) {
        CGPoint center = CGPointMake(self.mouseDownLocation.x + (point.x - self.mouseDownLocation.x)/2.0, self.mouseDownLocation.y + (point.y - self.mouseDownLocation.y)/2.0);
        float sx = fabs(point.x - self.mouseDownLocation.x);
        float sy = fabs(point.y - self.mouseDownLocation.y);
        CGSize size = CGSizeMake( sx, sy );
        if (self.dragShape == nil) {
            self.dragShape = [[ASURectangle alloc] initAtPoint:center withSize:size];
            [self.drawing.shapes addObject:self.dragShape];
        }
        else {
            self.dragShape.location = center;
            self.dragShape.size = size;
        }
    }
    if (self.toolMode == ToolModeEllipse) {
        CGPoint center = CGPointMake(self.mouseDownLocation.x + (point.x - self.mouseDownLocation.x)/2.0, self.mouseDownLocation.y + (point.y - self.mouseDownLocation.y)/2.0);
        float sx = fabs(point.x - self.mouseDownLocation.x);
        float sy = fabs(point.y - self.mouseDownLocation.y);
        CGSize size = CGSizeMake( sx, sy );
        if (self.dragShape == nil) {
            self.dragShape = [[ASUEllipse alloc] initAtPoint:center withSize:size];
            [self.drawing.shapes addObject:self.dragShape];
        }
        else {
            self.dragShape.location = center;
            self.dragShape.size = size;
        }
    }
}

- (void)mouseUp:(NSEvent *)theEvent atPoint:(CGPoint)point
{
    if ((theEvent.modifierFlags & NSShiftKeyMask) == 0) {
        [self.drawing clearSelection];
    }
    if (self.toolMode == ToolModeSelect) {
        ASUShape * shape = [self.drawing findFirstHit:point];
        if (shape != nil) {
            shape.isSelected = YES;
            NSLog(@"Selected shape \"%@\"", shape.name);
        }
        else {
            NSLog(@"No hit for selection.");
        }
    }
    
    if (self.toolMode == ToolModeDelete) {
        ASUShape * shape = [self.drawing findFirstHit:point];
        if (shape != nil) {
            shape.isSelected = YES;
            NSLog(@"Selected shape \"%@\"", shape.name);
        }
        else {
            NSLog(@"No hit for selection.");
        }
        [self.drawing deleteSelection];
    }
    if (self.toolMode == ToolModeRotate) {
        ASUShape * shape = [self.drawing findFirstHit:point];
        if (shape != nil) {
            shape.isSelected = YES;
            NSLog(@"Selected shape \"%@\"", shape.name);
        }
        else {
            NSLog(@"No hit for selection.");
        }
        shape.angle = [_rotat floatValue];
    }
    if (self.toolMode == ToolModeFill) {
        ASUShape * shape = [self.drawing findFirstHit:point];
        shape.fillA = 1.0;
        if (shape != nil) {
            shape.isSelected = YES;
            NSLog(@"Selected shape \"%@\"", shape.name);
        }
        else {
            NSLog(@"No hit for selection.");
        }
        shape.fillR = [_fillRed floatValue];
        shape.fillG = [_fillGreen floatValue];
        shape.fillB = [_fillBlue floatValue];
        shape.fillA = [_fillAlpha floatValue];
    }
}
@end
