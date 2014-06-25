//
//  ProgressBar.h
//  Grid
//
//  Created by LinO_dska on 22.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressBar : UIView
@property (nonatomic) float value;
@property int type;
@property UIColor *color;
@property UIColor *bgColor;
@property UIColor *strokeColor;
@property int width;

- (id)initWithFrame:(CGRect)frame type:(int)type width:(int)width color:(UIColor*)color bgColor:(UIColor*)bgColor strokeColor:(UIColor*)strokeColor;
@end
