//
//  LineArm.m
//  Grid
//
//  Created by LinO_dska on 02.06.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "LineArm.h"
#import "InterfaceUtil.h"

@implementation LineArm
-(void)setStart:(CGPoint)start {
    float dx = start.x - _start.x;
    float dy = start.y - _start.y;
    _middle = CGPointMake(_middle.x+dx, _middle.y+dy);
    _middle2 = CGPointMake(_middle2.x+dx, _middle2.y+dy);
    _middle3 = CGPointMake(_middle3.x+dx, _middle3.y+dy);
    _start = start;
}
-(void)setEnd:(CGPoint)end {
    CGPoint direction = findDirection(_start, end);
    //float distance = findDistanse(_start, end) / 2.0f;
    float distance = 0;
    _middle = CGPointMake(end.x - direction.x * distance, end.y + direction.y * distance - (end.y - _start.y)/1.5f);
    _middle2 = CGPointMake(_middle.x-direction.x*20, _middle.y-direction.y*20);
    _middle3 = CGPointMake(_middle.x+direction.x*20, _middle.y+direction.y*20);
    _end = end;
}
@end
