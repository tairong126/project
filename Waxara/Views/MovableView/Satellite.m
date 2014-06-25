//
//  Satellite.m
//  Grid
//
//  Created by LinO_dska on 16.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "Satellite.h"
#import "InterfaceUtil.h"
@implementation Satellite
-(id)initWithAngle:(float)angle position:(CGPoint)position center:(CGPoint)center icons:(NSArray*)icons icon:(int)icon {
    self = [super init];
    if(self) {
        _orbit = ORBIT;
        
        self.view = [[UIView alloc]initWithFrame:CGRectMake(0,0,ICONSIZE,ICONSIZE)];
        
        UIImage *ic = [[icons objectAtIndex:icon]objectAtIndex:0];
        
        self.button = [[UIImageView alloc]initWithImage:ic];
        self.buttonCache = [[UIImageView alloc]initWithFrame:self.button.frame];
        
        [self.view addSubview:self.button];
        
        self.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f);
        
        _angle = angle;
        _center = center;
        self.icon = icon;
        self.icons = icons;
        self.position = position;
        self.active = YES;
    }
    return self;
}

-(void)tick { // animation ticks
    self.ticks --;
    if(self.animationType == satTimerIconAnimation) {
        self.buttonCache.alpha += .2f;
        self.button.alpha -= .2f;
    }
    if(self.ticks <=0) {
        self.animation = NO;
        if(self.animationType == satTimerIconAnimation) {
            self.button.image = self.buttonCache.image;
            self.button.alpha = 1.0f;
            [self.buttonCache removeFromSuperview];
        }
    }
}

-(void)setAnimation:(BOOL)animation {
    if(animation != _animation) {
        _animation = animation;
        if(animation) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.050 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        }
        else {
            [self.timer invalidate];
        }
    }
}

-(void)setType:(int)type {
    if(type != _type && !self.animation) {
        _type = type;
        self.animation = YES;
        self.animationType = satTimerIconAnimation;
        self.ticks = 5;
        self.buttonCache.image = [[self.icons objectAtIndex:self.icon]objectAtIndex:type];
        self.buttonCache.alpha = .0f;
        [self.view addSubview:self.buttonCache];
    }
}

-(BOOL)touchDown:(CGPoint)pos {
    if(self.active) {
        if(findDistanse(self.position, pos)<20) {
            return YES;
        }
    }
    return NO;
}

-(void)setAngle:(int)angle {
    if(angle != _angle) {
        _angle = angle;
        self.position = CGPointMake(self.orbit*cosx[angle], self.orbit*sinx[angle]);
    }
}

-(void)setPosition:(CGPoint)position {
    _position = position;
    self.view.frame = rectToCenter(self.view.frame,position);
    
}

-(void)setCenter:(CGPoint)center {
    _center = center;
    self.button.frame = rectToCenter(self.button.frame, center);
    self.buttonCache.frame = self.button.frame;
}

@end
