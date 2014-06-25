//
//  Lines.m
//  Grid
//
//  Created by LinO_dska on 25.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "Lines.h"
#import "Line.h"
#import "LinePack.h"
#import "LineArm.h"
#import "InterfaceUtil.h"

@implementation Lines

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.lines = [NSMutableArray new];
        self.linePacks = [NSMutableArray new];
        self.arms = [NSMutableArray new];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [BLUECOLOR colorWithAlphaComponent:0.2];
    CGContextClearRect(context, rect);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetFillColorWithColor(context, BLUECOLOR.CGColor);
    for(Line *line in self.lines) {
        if(line.active) {
            CGContextMoveToPoint(context, line.start.x, line.start.y);
            CGContextAddLineToPoint(context, line.end.x, line.end.y);
            CGContextDrawPath(context, kCGPathStroke);
        }
    }
    for(LineArm *arm in self.arms) {
        if(arm.active) {
            CGContextMoveToPoint(context, arm.start.x, arm.start.y);
            CGContextAddLineToPoint(context, arm.middle.x, arm.middle.y);
            CGContextAddLineToPoint(context, arm.end.x, arm.end.y);
            CGContextAddLineToPoint(context, arm.middle2.x, arm.middle2.y);
            CGContextAddLineToPoint(context, arm.start.x, arm.start.y);
            CGContextAddLineToPoint(context, arm.middle3.x, arm.middle3.y);
            CGContextAddLineToPoint(context, arm.end.x, arm.end.y);
            CGContextDrawPath(context, kCGPathStroke);
            CGContextFillRect(context, CGRectMake(arm.middle.x, arm.middle.y, 1, 1));
            CGContextFillRect(context, CGRectMake(arm.middle2.x, arm.middle2.y, 1, 1));
            CGContextFillRect(context, CGRectMake(arm.middle3.x, arm.middle3.y, 1, 1));
        }
    }
}

@end
