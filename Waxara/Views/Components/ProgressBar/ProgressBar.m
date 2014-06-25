//
//  ProgressBar.m
//  Grid
//
//  Created by LinO_dska on 22.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "ProgressBar.h"
#import "InterfaceUtil.h"

@implementation ProgressBar

- (id)initWithFrame:(CGRect)frame type:(int)type width:(int)width color:(UIColor*)color bgColor:(UIColor*)bgColor strokeColor:(UIColor*)strokeColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.width = width;
        self.type = type;
        self.color = color;
        self.bgColor = bgColor;
        self.strokeColor = strokeColor;
    }
    return self;
}

-(void)setValue:(float)value {
    _value = value;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(self.type == 1) {
        float center = rect.size.width/2.0f;
        CGContextSetLineWidth(context, self.width);
        
        if(self.bgColor) {
            CGContextSetStrokeColorWithColor(context, self.bgColor.CGColor);
            CGContextAddArc(context, center, center, center-self.width, 0, M_PI*2, 0);
            CGContextDrawPath(context, kCGPathStroke);
        }
        
        if(self.color) {
            CGContextSetStrokeColorWithColor(context, self.color.CGColor);
            CGContextAddArc(context, center, center, center-self.width, 0, M_PI*2*self.value, 0);
            CGContextDrawPath(context, kCGPathStroke);
        }
        if(self.strokeColor) {
            CGContextSetLineWidth(context, 2);
            CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
            CGContextAddArc(context, center, center, center-self.width/2, 0, M_PI*2*self.value, 0);
            CGContextAddArc(context, center, center, center-self.width/2-self.width, M_PI*2*self.value, 0, 1);
            CGContextAddLineToPoint(context, center*2-self.width/2+1, center);
            CGContextDrawPath(context, kCGPathStroke);
        }
        
    }
}

@end
