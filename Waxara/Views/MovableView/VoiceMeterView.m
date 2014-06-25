//
//  VoiceMeterView.m
//  Grid
//
//  Created by LinO_dska on 15.05.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "VoiceMeterView.h"
#import "InterfaceUtil.h"
#import "MainMotherVC.h"

@implementation VoiceMeterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.blinking = 1.0f;
    }
    return self;
}

-(void)tick {
    if(self.blinkingSwitcher) self.blinking += 0.05f;
    else self.blinking -= 0.05f;
    self.inputVolume = self.owner.dbLevel;
    self.outputVolume = self.owner.outputVolume;
    [self setNeedsDisplay];
}

-(void)setBlinking:(float)blinking {
    _blinking = blinking;
    if(blinking<0.2) self.blinkingSwitcher = YES;
    if(blinking>0.9) self.blinkingSwitcher = NO;
}

-(void)setShow:(BOOL)show {
    if(_show != show) {
        _show = show;
        if(show) self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        else [self.timer invalidate];
    }
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    float u = rect.size.width/2-30;
    float center = rect.size.width/2.0f;
    UIColor *color = BLUECOLOR;
    if(self.outputActive) CGContextSetStrokeColorWithColor(context, [color colorWithAlphaComponent:0.4].CGColor);
    else CGContextSetStrokeColorWithColor(context, [color colorWithAlphaComponent:self.blinking].CGColor);
    CGContextSetLineWidth(context, 1);
    //CGContextSetShadowWithColor(context, CGSizeMake(0,0), 3, color.CGColor);
    
    int size = 72;
    CGPoint lines[size+1];
    float dm = 5;
    float xym = 10;
    float mul = 1.7f;
    float minVolume = 10;
    int volume = self.outputVolume;
    for(int j=0;j<4;j++) {
        if(j==3) {
            if(self.inputActive) CGContextSetStrokeColorWithColor(context, [color colorWithAlphaComponent:0.4].CGColor);
            else CGContextSetStrokeColorWithColor(context, [color colorWithAlphaComponent:self.blinking].CGColor);
            CGContextSetLineWidth(context, .5f);
            dm *= mul;
            xym *= mul;
            u /= mul;
            minVolume = 16;
            volume = self.inputVolume;
        }
        for(int i=0;i<size;i++) {
            int angle = normalizeAngle360((float)i/(float)size*360.0f);
            float d = u;
            float x = center;
            float y = center;
            if(volume>minVolume) {
                d += rdm(-volume/dm, volume/dm);
                x += rdm(-volume/xym, volume/xym);
                y += rdm(-volume/xym, volume/xym);
            }
            else {
                d += rdm(-1, 1);
                x += rdm(-1, 1);
                y += rdm(-1, 1);
            }
            x+=cosx[angle]*d;
            y+=sinx[angle]*d;
            lines[i] = CGPointMake(x, y);
        }
        lines[size] = lines[0];
        
        CGContextAddLines(context, lines, sizeof(lines)/sizeof(lines[0]));
        
        CGContextDrawPath(context, kCGPathStroke);
    }
}
/*
-(void)dealloc {
    self.show = NO;
    [self.timer release], self.timer = nil;
    [super dealloc];
}
*/
@end
