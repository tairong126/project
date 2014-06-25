//
//  BoxView.h
//  Grid
//
//  Created by LinO_dska on 25.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Line;
@class Lines;
@class LineArm;
@interface BoxView : UIView
@property (nonatomic) BOOL active;
@property (nonatomic) BOOL show;
@property (strong) UIColor *bgColor;
@property (strong) UIColor *edgeColor;
@property (strong) UIImage *tileTexture;
@property CGPoint ltc;
@property CGPoint rtc;
@property CGPoint lbc;
@property CGPoint rbc;
@property LineArm *ltcla; // (Left top corner LineArm)
@property Line *ltcl; // (Left top corner Line)
@property Line *rtcl; // (Right top corner Line)
@property Line *lbcl; // (Left bottom corner Line)
@property Line *rbcl; // (Right bottom corner Line)
@property float tileAlpha; // TILE DRAWS ONLY IF ALPHA > 0
@property Lines *lines;
@property (nonatomic) CGPoint position;
- (id)initWithFrame:(CGRect)frame edgeColor:(UIColor*)edgeColor tiledBackgroundAlpha:(float)tiledBackgroundAlpha bgColor:(UIColor*)bgColor lines:(Lines*)lines arm:(LineArm*)arm;
-(void)offset:(CGPoint)offset;
-(void)offsetInView:(CGPoint)offset;
-(void)moveStartLine:(CGPoint)position;
-(void)moveEndLine:(CGPoint)position;
-(void)moveStartLineArm:(CGPoint)position;
-(void)moveEndLineArm:(CGPoint)position;
-(void)remove;
@end
