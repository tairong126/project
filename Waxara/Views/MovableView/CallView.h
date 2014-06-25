//
//  CallView.h
//  Grid
//
//  Created by Dmitry Kozlov on 19/05/14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VoiceMeterView;
@interface CallView : NSObject
@property UIView *superView;
@property UIView *view;
@property (nonatomic) BOOL show;
@property VoiceMeterView *voiceMeterView;
@property UIImageView *recordingImage;
@property UILabel *recordingLabel;
@property UILabel *recordingTime;
@property UILabel *recordingTimeTicks;
@property (nonatomic) int recordingTicks;
@property (nonatomic) int recordingSeconds;
@property (nonatomic) int recordingMinutes;
@property (nonatomic) int recordingHours;
@property NSTimer *secondTimer;
@property NSTimer *tickTimer;
-(id)initWithSuperview:(UIView*)superView;
-(void)startRecording;
-(void)stopRecording;

@end
