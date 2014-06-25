//
//  BorderView.m
//  Waxara
//
//  Created by Passion on 6/15/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "BorderView.h"
#import "Line.h"
#import "Lines.h"
#import "LineArm.h"
#import "InterfaceUtil.h"

#import "UIImage-JTColor.h"

@implementation BorderView

#pragma mark - Overrides

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if ((self = [super initWithCoder:aDecoder]))
    {
        // Initialization code
        [self setWithEdgeColor:BLUECOLOR image: nil tiledBackgroundAlpha:.2f bgColor:nil armLeftTop:[LineArm new] armRightBottom:[LineArm new]];
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame edgeColor:(UIColor*)edgeColor tiledBackgroundAlpha:(float)tiledBackgroundAlpha bgColor:(UIColor*)bgColor lines:(Lines*)lines armLeftTop:(LineArm*)armLT armRightBottom: (LineArm*) armRB
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lines = lines;
        self.edgeColor = edgeColor;
        if(tiledBackgroundAlpha) {
            self.tileTexture = [UIImage imageNamed:@"BoxTile"];
            self.tileAlpha = tiledBackgroundAlpha;
        }
        self.bgColor = bgColor;
        self.backgroundColor = [UIColor clearColor];
        int edgeBorder = 10;
        self.ltc = CGPointMake(edgeBorder,edgeBorder);
        self.rtc = CGPointMake(frame.size.width-edgeBorder,edgeBorder);
        self.lbc = CGPointMake(edgeBorder,frame.size.height-edgeBorder);
        self.rbc = CGPointMake(frame.size.width-edgeBorder,frame.size.height-edgeBorder);

        if(self.lines) {
            if (armRB || armLT) {
                if(armLT) {
                    [lines.arms addObject:armLT];
                    self.ltcla = armLT;
                }
                if (armRB){
                    [lines.arms addObject:armRB];
                    self.rbcla = armRB;
                }
                
            }
            else {
                self.ltcl = [Line new];
                self.rtcl = [Line new];
                self.lbcl = [Line new];
                self.rbcl = [Line new];
                [lines.lines addObject:self.ltcl];
                [lines.lines addObject:self.rtcl];
                [lines.lines addObject:self.lbcl];
                [lines.lines addObject:self.rbcl];
            }
        }
        _show = YES;
    }
    return self;
}

#pragma mark - Interface Initialize
- (void) setWithEdgeColor:(UIColor*)edgeColor image: (UIImage*) imageBG tiledBackgroundAlpha:(float)tiledBackgroundAlpha bgColor:(UIColor*)bgColor armLeftTop:(LineArm*)armLT armRightBottom: (LineArm*) armRB
{
    self.edgeColor = edgeColor;
    
    if (imageBG)
    {
        self.tileTexture = imageBG;
    }
    else
    {
        self.tileTexture = [UIImage imageWithColor:[UIColor blackColor]];
    }
    
    if(tiledBackgroundAlpha)
    {
        self.tileAlpha = tiledBackgroundAlpha;
    }

    
    self.bgColor = bgColor;
    self.backgroundColor = [UIColor clearColor];
    int edgeBorder = 5;
    self.ltc = CGPointMake(edgeBorder,edgeBorder);
    self.rtc = CGPointMake(self.frame.size.width-edgeBorder,edgeBorder);
    self.lbc = CGPointMake(edgeBorder, self.frame.size.height-edgeBorder);
    self.rbc = CGPointMake(self.frame.size.width-edgeBorder, self.frame.size.height-edgeBorder);

    if (armRB || armLT) {
        if(armLT) {
            self.ltcla = armLT;
        }
        if (armRB){
            
            self.rbcla = armRB;
        }
        
    }

    _show = YES;
    

}

#pragma mark - Move methods

-(void)offsetInView:(CGPoint)offset {
    if(self.ltcla) {
        self.ltcla.end = CGPointMake(self.ltcla.end.x+offset.x, self.ltcla.end.y+offset.y);
    }
    
    if (self.rbcla) {
        self.rbcla.start = CGPointMake(self.rbcla.start.x+offset.x, self.rbcla.start.y + offset.y);
    }
    
    if(self.ltcl) {
        self.ltcl.end = CGPointMake(self.ltcl.end.x+offset.x, self.ltcl.end.y+offset.y);
        self.rtcl.end = CGPointMake(self.rtcl.end.x+offset.x, self.rtcl.end.y+offset.y);
        self.lbcl.end = CGPointMake(self.lbcl.end.x+offset.x, self.lbcl.end.y+offset.y);
        self.rbcl.end = CGPointMake(self.rbcl.end.x+offset.x, self.rbcl.end.y+offset.y);
    }
}

-(void)offset:(CGPoint)offset {
    if(self.ltcla) {
        if (self.bMoveableLTStart) {
            self.ltcla.start = CGPointMake(self.ltcla.start.x+offset.x, self.ltcla.start.y+offset.y);
        }

        self.ltcla.end = CGPointMake(self.ltcla.end.x+offset.x, self.ltcla.end.y+offset.y);
    }
    
    if (self.rbcla) {
        self.rbcla.start = CGPointMake(self.rbcla.start.x+offset.x, self.rbcla.start.y+offset.y);
        
        if (self.bMoveableRBEnd) {
            self.rbcla.end = CGPointMake(self.rbcla.end.x+offset.x, self.rbcla.end.y+offset.y);
        }
    }
    
    if(self.ltcl) {
        self.ltcl.start = CGPointMake(self.ltcl.start.x+offset.x, self.ltcl.start.y+offset.y);
        self.rtcl.start = CGPointMake(self.rtcl.start.x+offset.x, self.rtcl.start.y+offset.y);
        self.lbcl.start = CGPointMake(self.lbcl.start.x+offset.x, self.lbcl.start.y+offset.y);
        self.rbcl.start = CGPointMake(self.rbcl.start.x+offset.x, self.rbcl.start.y+offset.y);
        self.ltcl.end = CGPointMake(self.ltcl.end.x+offset.x, self.ltcl.end.y+offset.y);
        self.rtcl.end = CGPointMake(self.rtcl.end.x+offset.x, self.rtcl.end.y+offset.y);
        self.lbcl.end = CGPointMake(self.lbcl.end.x+offset.x, self.lbcl.end.y+offset.y);
        self.rbcl.end = CGPointMake(self.rbcl.end.x+offset.x, self.rbcl.end.y+offset.y);
    }
}

-(void)moveStartLine:(CGPoint)position {
    self.ltcl.start = position;
    self.rtcl.start = position;
    self.lbcl.start = position;
    self.rbcl.start = position;
}

-(void)moveEndLine:(CGPoint)position {
    self.ltcl.end = CGPointMake(position.x+self.ltc.x, position.y+self.ltc.y);
    self.rtcl.end = CGPointMake(position.x+self.rtc.x, position.y+self.rtc.y);
    self.lbcl.end = CGPointMake(position.x+self.lbc.x, position.y+self.lbc.y);
    self.rbcl.end = CGPointMake(position.x+self.rbc.x, position.y+self.rbc.y);
}
-(void)moveStartLineArm:(CGPoint)position armType: (int) nArmType {
    if (nArmType == ARM_LT) {
        self.ltcla.start = position;
    }
    else if (nArmType == ARM_RB) {
        self.rbcla.start = position;
    }
}

-(void)moveEndLineArm:(CGPoint)position armType: (int) nArmType  specific: (BOOL) bSpecific {
    
    float fOffsetX = (bSpecific) ? 0:self.ltc.x;
    float fOffsetY = (bSpecific) ? 0:self.ltc.y;

    if (nArmType == ARM_LT) {
        self.ltcla.end  = CGPointMake(position.x+fOffsetX, position.y+fOffsetY);
    }
    else if (nArmType == ARM_RB) {
        self.rbcla.end  = CGPointMake(position.x+fOffsetX, position.y+fOffsetY);
    }
    
    
}

-(void)setActive:(BOOL)active {
    _active = active;
    if(self.ltcla) {
        self.ltcla.active = active;
    }
    
    if (self.rbcla) {
        self.rbcla.active = active;
    }
    
    if(self.ltcl) {
        self.ltcl.active = active;
        self.rtcl.active = active;
        self.lbcl.active = active;
        self.rbcl.active = active;
    }
}

- (void) setLines:(Lines *)lines
{
    _lines = lines;
    

    if (self.ltcla) {
        [self.lines.arms addObject:self.ltcla];
    }
    if (self.rbcla) {
        [self.lines.arms addObject:self.rbcla];
    }


}

-(void)remove {
    if(self.ltcla) {
        [self.lines.arms removeObject:self.ltcla];
    }
    if(self.ltcl) {
        [self.lines.lines removeObject:self.ltcl];
        [self.lines.lines removeObject:self.rtcl];
        [self.lines.lines removeObject:self.lbcl];
        [self.lines.lines removeObject:self.rbcl];
        self.ltcl = nil;
        self.rtcl = nil;
        self.lbcl = nil;
        self.rbcl = nil;
    }
}

-(void)setShow:(BOOL)show {
    if(_show != show) {
        _show = show;
        if(show) {
            [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
                self.alpha = 1;
            } completion:nil];
        }
        else {
            [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
                self.alpha = 0;
            } completion:^ (BOOL finished){if (finished) {
                
            }}];
        }
    }
}

#pragma mark - drawing
- (void)drawRect:(CGRect)rect
{
    
    
    self.edgeSize = 10; // length of colored border
    self.edgeGlow = 4; //size of glow
    self.edgeBorder = 3; //
    self.rectBorder = 7; //inner length for inner tile view
    self.ltc = CGPointMake(self.edgeBorder,self.edgeBorder);
    self.rtc = CGPointMake(self.frame.size.width - self.edgeBorder, self.edgeBorder);
    self.lbc = CGPointMake(self.edgeBorder,self.frame.size.height-self.edgeBorder);
    self.rbc = CGPointMake(self.frame.size.width - self.edgeBorder,self.frame.size.height - self.edgeBorder);
    CGRect bgRect = CGRectMake(rect.origin.x + self.rectBorder, rect.origin.y+ self.rectBorder, rect.size.width - self.rectBorder*2, rect.size.height- self.rectBorder*2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(self.bgColor) {
        CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
        CGContextAddRect(context, bgRect);
        CGContextDrawPath(context, kCGPathFill);
    }
    if(self.tileAlpha) {
        
        CGImageRef texture = self.tileTexture.CGImage;
        UIGraphicsBeginImageContext(bgRect.size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetAlpha(ctx, self.tileAlpha);
        CGContextDrawTiledImage(ctx, CGRectMake(0, 0, self.tileTexture.size.width, self.tileTexture.size.height), texture);
        UIImage*tile = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGContextDrawImage(context, bgRect, tile.CGImage);
        
        
    }
    if(self.edgeColor) {
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, self.edgeColor.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0,0), self.edgeGlow, self.edgeColor.CGColor);
        CGContextSetShouldAntialias(context, NO);
        CGPoint llt[3] = {
            {.x = self.ltc.x+self.edgeSize   ,.y = self.ltc.y},
            {.x = self.ltc.x            ,.y = self.ltc.y},
            {.x = self.ltc.x            ,.y = self.ltc.y+self.edgeSize},
        };
        CGContextAddLines(context, llt, 3);
        CGContextDrawPath(context, kCGPathStroke);
        CGPoint lrt[3] = {
            {.x = self.rtc.x-self.edgeSize   ,.y = self.rtc.y},
            {.x = self.rtc.x            ,.y = self.rtc.y},
            {.x = self.rtc.x            ,.y = self.rtc.y+self.edgeSize},
        };
        CGContextAddLines(context, lrt, 3);
        CGContextDrawPath(context, kCGPathStroke);
        CGPoint llb[3] = {
            {.x = self.lbc.x+self.edgeSize   ,.y = self.lbc.y},
            {.x = self.lbc.x            ,.y = self.lbc.y},
            {.x = self.lbc.x            ,.y = self.lbc.y-self.edgeSize},
        };
        CGContextAddLines(context, llb, 3);
        CGContextDrawPath(context, kCGPathStroke);
        CGPoint lrb[3] = {
            {.x = self.rbc.x-self.edgeSize   ,.y = self.rbc.y},
            {.x = self.rbc.x            ,.y = self.rbc.y},
            {.x = self.rbc.x            ,.y = self.rbc.y-self.edgeSize},
        };
        CGContextAddLines(context, lrb, 3);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
