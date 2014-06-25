//
//  VoiceMeterView.h
//  Grid
//
//  Created by LinO_dska on 15.05.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainMotherVC;

@interface VoiceMeterView : UIView

@property int angle;

@property (nonatomic) BOOL show;

@property BOOL outputActive;
@property BOOL inputActive;

@property (nonatomic) float blinking;
@property BOOL blinkingSwitcher;

@property NSTimer *timer;

@property int outputVolume;
@property int inputVolume;

@property MainMotherVC *owner;
@end
