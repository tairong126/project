//
//  CallView.m
//  Grid
//
//  Created by Dmitry Kozlov on 19/05/14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "CallView.h"
#import "InterfaceUtil.h"
#import "VoiceMeterView.h"

@implementation CallView
-(id)initWithSuperview:(UIView*)superView {
    self = [super init];
    if(self) {
        self.superView = superView;
        UIFont *hn_10 =[UIFont fontWithName:@"HelveticaNeue" size:10];
        UIFont *hn_l20 =[UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        UIColor *whiteColor = [UIColor whiteColor];
        self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.voiceMeterView = [[VoiceMeterView alloc]initWithFrame:rectToCenter(CGRectMake(0, 0, 400, 400), CGPointMake(0, 0))];
        self.recordingImage = [[UIImageView alloc]initWithFrame:CGRectMake(-300, 0, 30, 30)];
        self.recordingImage.image = drawCircle(CGSizeMake(30, 30), nil, REDCOLOR, 0);
        self.recordingLabel = createLabel(CGRectMake(-260, 10, 100, 12), hn_10, whiteColor, @"RECORDING...");
        self.recordingTime = createLabel(CGRectMake(-300, -30, 100, 24), hn_l20, whiteColor, @"00:00:00");
        self.recordingTimeTicks = createLabel(CGRectMake(-220, -20, 100, 12), hn_10, whiteColor, @"000");
        [self.view addSubview:self.voiceMeterView];
        [self.view addSubview:self.recordingImage];
        [self.view addSubview:self.recordingLabel];
        [self.view addSubview:self.recordingTime];
        [self.view addSubview:self.recordingTimeTicks];
    }
    return self;
}
-(void)updateCallTimer {
    self.recordingTicks += 43;
}
-(void)updateSeconds {
    self.recordingSeconds++;
}
-(void)setRecordingTicks:(int)recordingTicks {
    if(recordingTicks>=1000) {
        recordingTicks -= 1000;
    }
    _recordingTicks = recordingTicks;
    [self updateRecordingTickLabel];
    
}
-(void)setRecordingSeconds:(int)recordingSeconds {
    if(recordingSeconds>60) {
        recordingSeconds -= 60;
        self.recordingMinutes++;
    }
    _recordingSeconds = recordingSeconds;
    [self updateRecordingLabel];
}
-(void)setRecordingMinutes:(int)recordingMinutes {
    if(recordingMinutes>=60) {
        recordingMinutes -= 60;
        self.recordingHours++;
    }
    _recordingMinutes = recordingMinutes;
    [self updateRecordingLabel];
}
-(void)setRecordingHours:(int)recordingHours {
    
    [self updateRecordingLabel];
}
-(void)updateRecordingTickLabel {
    NSString *text;
    if(self.recordingTicks<10) text = [NSString stringWithFormat:@"00%d",self.recordingTicks];
    else if(self.recordingTicks<100) text = [NSString stringWithFormat:@"0%d",self.recordingTicks];
    else text = [NSString stringWithFormat:@"%d",self.recordingTicks];
    self.recordingTimeTicks.text = text;
}
-(void)updateRecordingLabel {
    self.recordingTime.text = [NSString stringWithFormat:@"%@:%@:%@",[self numberToString00:self.recordingHours],[self numberToString00:self.recordingMinutes],[self numberToString00:self.recordingSeconds]];
}
-(NSString *)numberToString00:(int)number {
    NSString *string = number < 10 ? [NSString stringWithFormat:@"0%d",number] : [NSString stringWithFormat:@"%d",number];
    return string;
}
-(void)startRecording {
    self.tickTimer = [NSTimer scheduledTimerWithTimeInterval:0.043 target:self selector:@selector(updateCallTimer) userInfo:nil repeats:YES];
    self.secondTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateSeconds) userInfo:nil repeats:YES];
}
-(void)stopRecording {
    [self.tickTimer invalidate];
    [self.secondTimer invalidate];
    self.recordingTicks = 0;
    _recordingSeconds = 0;
    _recordingMinutes = 0;
    self.recordingHours = 0;
}
-(void)setShow:(BOOL)show {
    if(_show != show) {
        _show = show;
        if(show) {
            [self.superView addSubview:self.view];
            self.voiceMeterView.inputActive = YES;
            [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 self.view.alpha = 1;
                             }
                             completion:nil];
            self.voiceMeterView.show = YES;
        }
        else {
            self.voiceMeterView.show = NO;
            [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 self.view.alpha = 0;
                             }
                             completion:^ (BOOL finished){
                                 if (finished) {
                                     [self.view removeFromSuperview];
                                 }
                             }];
        }
    }
}
@end
