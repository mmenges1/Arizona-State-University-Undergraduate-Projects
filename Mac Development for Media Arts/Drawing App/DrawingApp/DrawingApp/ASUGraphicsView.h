//
//  ASUGraphicsView.h
//  DrawingApp
//
//  Created by Loren Olson on 10/28/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ASUDrawing.h"
#import "AppDelegate.h"

@interface ASUGraphicsView : NSView


@property (nonatomic) ASUDrawing * drawing;
@property (nonatomic) AppDelegate * controller;

@end
