//
//  BorderView.h
//  Waxara
//
//  Created by Passion on 6/15/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//
//  ToDo Here:
//      show background, show corners, set alpha, set arms
//

#import <UIKit/UIKit.h>
@class Line;
@class Lines;
@class LineArm;

#define ARM_LT 1
#define ARM_RB 2



@interface BorderView : UIView

@property (nonatomic) BOOL active;
@property (nonatomic) BOOL show;

@property (strong) UIColor *bgColor;
@property (strong) UIColor *edgeColor;
@property (strong) UIImage *tileTexture;
@property float tileAlpha; // TILE DRAWS ONLY IF ALPHA > 0

@property CGPoint ltc;
@property CGPoint rtc;
@property CGPoint lbc;
@property CGPoint rbc;

@property int edgeSize; // length of colored border
@property int edgeGlow; //size of glow
@property int edgeBorder; //
@property int rectBorder; //inner length for inner tile view

@property LineArm *ltcla; // (Left top corner LineArm)
@property LineArm *rbcla; // (Left bottom corner LineArm)

@property BOOL bMoveableRBEnd;
@property BOOL bMoveableLTStart;

@property Line *ltcl; // (Left top corner Line)
@property Line *rtcl; // (Right top corner Line)
@property Line *lbcl; // (Left bottom corner Line)
@property Line *rbcl; // (Right bottom corner Line)

@property (nonatomic, strong) Lines *lines;

@property (nonatomic) CGPoint position;

- (id)initWithFrame:(CGRect)frame edgeColor:(UIColor*)edgeColor tiledBackgroundAlpha:(float)tiledBackgroundAlpha bgColor:(UIColor*)bgColor lines:(Lines*)lines armLeftTop:(LineArm*)armLT armRightBottom: (LineArm*) armRB;
- (void) setWithEdgeColor:(UIColor*)edgeColor image: (UIImage*) imageBG tiledBackgroundAlpha:(float)tiledBackgroundAlpha bgColor:(UIColor*)bgColor armLeftTop:(LineArm*)armLT armRightBottom: (LineArm*) armRB;


-(void)offset:(CGPoint)offset;
-(void)offsetInView:(CGPoint)offset;
-(void)moveStartLine:(CGPoint)position;
-(void)moveEndLine:(CGPoint)position;
-(void)moveStartLineArm:(CGPoint)position armType: (int) nArmType;
-(void)moveEndLineArm:(CGPoint)position armType: (int) nArmType specific: (BOOL) bSpecific;
-(void)remove;


@end
