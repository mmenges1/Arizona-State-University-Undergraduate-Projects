//
//  ASUShape.h
//  DrawingApp
//
//  Created by Loren Olson on 11/2/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASUShape : NSObject

@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) float angle;
@property (nonatomic, assign) float fillR;
@property (nonatomic, assign) float fillG;
@property (nonatomic, assign) float fillB;
@property (nonatomic, assign) float fillA;
@property (nonatomic, assign) float strokeR;
@property (nonatomic, assign) float strokeG;
@property (nonatomic, assign) float strokeB;
@property (nonatomic, assign) float strokeA;
@property (nonatomic) NSString * name;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initAtPoint:(CGPoint)pt withSize:(CGSize)sz;
- (void)render:(CGContextRef)context;
- (BOOL)hit:(CGPoint)point;

@end
