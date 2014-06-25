//
//  Core.m
//  Grid
//
//  Created by LinO_dska on 16.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "Core.h"
#import "InterfaceUtil.h"
#import "Satellite.h"
#import "Lines.h"
#import "Line.h"
#import "LineArm.h"
#import "Company.h"
#import "CompanyView.h"
#import "Profile.h"
#import "ProfileView.h"
#import "Tool.h"
#import "ToolView.h"
#import "VoiceMeterView.h"
#import "CallView.h"
#import "MainMotherVC.h"
#import "ProgressBar.h"

#define SIZE 0

static const CGPoint satpos[8] = {
    {.x = 0,.y = -130},
    {.x = 91,.y = -91},
    {.x = 130,.y = 0},
    {.x = 91,.y = 91},
    {.x = 0,.y = 130},
    
    {.x = -91,.y = 91},
    {.x = -130,.y = 0},
    {.x = -91,.y = -91}
};

static const int cVar[3][8] = {
    {14,19,16,1,4,20,21,-1},
    {14,-1,-1,16,20,3,8,13},
    {-1,-1,13,4,11,satIconGrid,-1,-1}
};

@implementation Core

#pragma mark - Initialization
-(id)initWithIcons:(NSArray*)icons cVar:(int)var {
    self = [super init];
    if (self) {
        self.icons = icons;
        
        self.satellites = [NSMutableArray new];
        _size = SIZE;
        CGPoint center = CGPointMake(SIZE/2, SIZE/2);
        _center = _size/2;
        
        self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE, SIZE)];
        
        UIImage *orbitImage = drawCircle(CGSizeMake(ORBITSIZE, ORBITSIZE), [UIColor whiteColor], nil, 2);
        self.orbit = [[UIImageView alloc]initWithImage:orbitImage];
        self.orbit.alpha = 0.2f;
        self.orbit.frame = rectToCenter(self.orbit.frame, center);
        _orbitSize = self.orbit.frame.size.width;
        
        [self.view addSubview:self.orbit];
        
        for(int i=0;i<8;i++) {
            CGPoint pos = satpos[i];
            if(cVar[var][i] != -1) {
                pos.x+=_center;
                pos.y+=_center;
                Satellite *sat = [[Satellite alloc]initWithAngle:0 position:pos center:self.position icons:icons icon:cVar[var][i]];
                [self.view addSubview:sat.view];
                [self.satellites addObject:sat];
            }
            else {
                Satellite *sat = [Satellite new];
                [self.satellites addObject:sat];
            }
        }
    }
    return self;
}
-(id)initWithCompany:(Company*)company icons:(NSArray*)icons {
    self = [self initWithIcons:icons cVar:0];
    self.company = company;
    self.companyView = [CompanyView new];
    self.companyView.image = [[UIImageView alloc]initWithImage:company.image];
    self.companyView.image.frame = rectToCenter(self.companyView.image.frame, CGPointMake(self.center, self.center));
    
    CGRect nameRect = CGRectMake(self.center+170, self.center-10, 200, 20);
    self.companyView.name = [[UILabel alloc]initWithFrame:nameRect];
    self.companyView.name.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    self.companyView.name.textColor = [UIColor whiteColor];
    self.companyView.name.backgroundColor = [UIColor clearColor];
    self.companyView.name.text = company.name;
    
    [self.view addSubview:self.companyView.name];
    [self.view addSubview:self.companyView.image];
    return self;
}
-(id)initWithProfile:(Profile*)profile icons:(NSArray*)icons owner:(MainMotherVC*)owner {
    self = [self initWithIcons:icons cVar:1];
    // Some fonts
    UIFont *hn_l10 =[UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    UIFont *hn_l13 =[UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    UIFont *hn_l26 =[UIFont fontWithName:@"HelveticaNeue-Light" size:26];
    UIFont *hn_9 =[UIFont fontWithName:@"HelveticaNeue" size:9];
    UIFont *hn_17 =[UIFont fontWithName:@"HelveticaNeue" size:17];
    
    UIColor *whiteColor = [UIColor whiteColor];
    UIColor *whiteColor_4 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4f];
    
    self.owner = owner;
    self.profile = profile;
    CGPoint center = CGPointMake(self.center, self.center);
    
    
    self.profileView = [[ProfileView alloc]initWithCore:self profile:profile];
    self.callView = [[CallView alloc]initWithSuperview:self.view];
    self.callView.voiceMeterView.owner = owner;
    
    // Task view
    UIImage *taskTextFieldImage = [UIImage imageNamed:@"TaskBackground"];
    self.taskTextField = createTextField(CGRectMake(self.center-418, self.center-198, taskTextFieldImage.size.width, taskTextFieldImage.size.height), hn_17, whiteColor, taskTextFieldImage, YES, UIReturnKeyDone, UITextFieldViewModeAlways, 10);
    self.taskTextField.delegate = owner;
    self.taskLettersCounter = createLabel(CGRectMake(self.center-170, self.center-210,50,12), hn_l10, whiteColor, [NSString stringWithFormat:@"0/%d",TASKMAXLETTERS]);
    self.taskLettersCounter.textAlignment = NSTextAlignmentRight;
    self.taskLabel = createLabel(CGRectMake(self.center-418, self.center-168,50,11), hn_9, whiteColor, @"NEW TASK");
    self.taskTextField.alpha = .0f;
    self.taskLettersCounter.alpha = .0f;
    self.taskLabel.alpha = .0f;
    
    LineArm *infoBoxArm = [LineArm new];
    self.infoBox = [[BoxView alloc]initWithFrame:CGRectMake(center.x-203, center.y+196, 300, 146) edgeColor:BLUECOLOR tiledBackgroundAlpha:.2f bgColor:nil lines:owner.lines arm:infoBoxArm];
    
    self.infoTotLabel = createLabel(CGRectMake(60, 84, 30, 15), hn_l13, whiteColor, @"TOT");
    self.infoTotNumber = createLabel(CGRectMake(50, 54, 60, 28), hn_l26, whiteColor, [NSString stringWithFormat:@"%d%%",profile.tot]);
    self.infoTotProgress = [[ProgressBar alloc]initWithFrame:rectToCenter(CGRectMake(0, 0, 100, 100), CGPointMake(71, 72)) type:1 width:10 color:whiteColor_4 bgColor:nil strokeColor:BLUECOLOR];
    self.infoTotProgress.value = (float)profile.tot/100.0f;
    self.infoPerfLabel = createLabel(CGRectMake(203, 84, 40, 15), hn_l13, whiteColor, @"PERF");
    self.infoPerfNumber = createLabel(CGRectMake(197, 54, 60, 28), hn_l26, whiteColor, [NSString stringWithFormat:@"%d%%",profile.perf]);
    self.infoPerfProgress = [[ProgressBar alloc]initWithFrame:rectToCenter(CGRectMake(0, 0, 100, 100), CGPointMake(218, 72)) type:1 width:10 color:whiteColor_4 bgColor:nil strokeColor:BLUECOLOR];
    self.infoPerfProgress.value = (float)profile.perf/100.0f;
    
    [self.infoBox addSubview:self.infoPerfLabel];
    [self.infoBox addSubview:self.infoPerfNumber];
    [self.infoBox addSubview:self.infoPerfProgress];
    [self.infoBox addSubview:self.infoTotLabel];
    [self.infoBox addSubview:self.infoTotNumber];
    [self.infoBox addSubview:self.infoTotProgress];
    
    self.infoBox.alpha = .0f;
    [self.infoBox moveStartLineArm:CGPointMake(self.position.x+satpos[3].x, self.position.y+satpos[3].y+17)];
    [self.infoBox moveEndLineArm:CGPointMake(self.view.frame.origin.x+self.infoBox.frame.origin.x-center.x, self.view.frame.origin.y+self.infoBox.frame.origin.y-center.y)];
    
    [owner.boxes addObject:self.infoBox];
    
    return self;
}
-(id)initWithTool:(Tool*)tool icons:(NSArray*)icons {
    self = [self initWithIcons:icons cVar:2];
    self.tool = tool;
    self.toolView = [[ToolView alloc]initWithCore:self tool:tool];
    return self;
}

#pragma mark - Get and Set
-(void)setAngle:(int)angle { // setting orbit angle and moving satellites (Unusible function)
    _angle = angle;
    for(Satellite *sat in self.satellites) {
        if(sat.active) {
            angle = normalizeAngle360(angle-45);
            sat.angle = angle;
        }
    }
}

-(void)setPosition:(CGPoint)position { // Change position by center of view
    CGPoint offset = CGPointMake(position.x-_position.x, position.y-_position.y);
    _position = position;
    position = CGPointMake((int)position.x, (int)position.y);
    self.view.frame = rectToCenter(self.view.frame, position);
    [self.infoBox offset:offset];
}

-(void)setRandomMoving:(BOOL)randomMoving { // moves orbit randomly (Unusible function)
    if(randomMoving != _randomMoving) {
        _randomMoving = randomMoving;
        [self rotate];
    }
}

-(void)setShowTaskTextField:(BOOL)showTaskTextField {
    if(_showTaskTextField != showTaskTextField) {
        _showTaskTextField = showTaskTextField;
        if(showTaskTextField) {
            [self.taskTextField becomeFirstResponder];
            if(self.position.y>300) {
                self.cachePos = self.position;
                [self moveTo:CGPointMake(self.position.x, 300) speed:20];
            }
            [self.view addSubview:self.taskTextField];
            [self.view addSubview:self.taskLettersCounter];
            [self.view addSubview:self.taskLabel];
            [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 self.taskTextField.alpha = 1;
                                 self.taskLettersCounter.alpha = 1;
                                 self.taskLabel.alpha = 1;
                             }
                             completion:nil];
        }
        else {
            [self.taskTextField resignFirstResponder];
            [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 self.taskTextField.alpha = 0;
                                 self.taskLettersCounter.alpha = 0;
                                 self.taskLabel.alpha = 0;
                             }
                             completion:^ (BOOL finished){
                                 if (finished) {
                                     [self.taskTextField removeFromSuperview];
                                     [self.taskLettersCounter removeFromSuperview];
                                     [self.taskLabel removeFromSuperview];
                                 }
                             }];
        }
    }
}

-(void)setShowInfoBox:(BOOL)showStatsBox {
    if(_showInfoBox != showStatsBox) {
        _showInfoBox = showStatsBox;
        if(showStatsBox) {
            self.infoBox.active = YES;
            [self.view addSubview:self.infoBox];
            [self.owner.lines setNeedsDisplay];
            [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
                self.infoBox.alpha = 1;
            } completion:nil];
        }
        else {
            self.infoBox.active = NO;
            [self.owner.lines setNeedsDisplay];
            [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
                self.infoBox.alpha = 0;
            } completion:^ (BOOL finished){if (finished) {
                [self.infoBox removeFromSuperview];
            }}];
        }
    }
}

-(void)setTaskLetters:(int)taskLetters { // shows task typed letters
    _taskLetters = taskLetters;
    self.taskLettersCounter.text = [NSString stringWithFormat:@"%d/%d",taskLetters,TASKMAXLETTERS];
}

#pragma mark - Touch Event
-(int)touchDown:(CGPoint)pos {
    int i = 0;
    CGPoint inPos = CGPointMake(pos.x-self.position.x+self.center, pos.y-self.position.y+self.center);
    for(Satellite *satellite in self.satellites) {
        if([satellite touchDown:inPos]) {
            satellite.type = 1-(BOOL)satellite.type; // simple switcher
            switch (satellite.icon) { // events on clicking icons
                case satIconTask:
                    if(satellite.type == satIconTypeDefault) {
                        self.showTaskTextField = NO;
                    }
                    else if(satellite.type == satIconTypeOpened) {
                        self.showTaskTextField = YES;
                    }
                    break;
                case satIconInfo:
                    if(satellite.type == satIconTypeDefault) {
                        self.showInfoBox = NO;
                    }
                    else if(satellite.type == satIconTypeOpened) {
                        self.showInfoBox = YES;
                    }
                    break;
                case satIconCall: // SHOWS VOICE METER
                    if(self.profileView) {
                        if(satellite.type == satIconTypeDefault) {
                            self.callView.show = NO;
                            [self.callView stopRecording];
                            [self.owner stopRecording];
                            [self.owner stopAudioMetering];
                            self.owner.repeatAudio = NO;
                            [self.owner stopAudio];
                        }
                        else if(satellite.type == satIconTypeOpened) {
                            self.callView.show = YES;
                            [self.callView startRecording];
                            [self.owner playLocalSound:@"Call" type:@"mp3" volume:0.5f repeat:YES];
                            [self.owner startRecording];
                            [self.owner startAudioMetering];
                            self.owner.meterMicrophone = YES;
                        }
                    }
                    break;
                case satIconMessages:
                    
                    if(satellite.type == satIconTypeDefault) {
                        
                    }
                    else if(satellite.type == satIconTypeOpened) {
                        
                    }
                    break;
                default:
                    break;
            }
            return i;
        }
        i++;
    }
    if(findDistanse(self.position, pos)<ORBIT) {
        return -1; // if touch only in orbit
    }
    return -2; // if nothing
}


#pragma mark - Utility
-(void)rotate { // rotate orbit to random angle (unusible function)
    self.vx = cosx[rdm(0, 359)];
    self.vy = sinx[rdm(0, 359)];
    self.speed = rdm(10, 20)/100.0f;
    self.mtime = rdm(120, 300);
}

-(void)moveTo:(CGPoint)point speed:(float)speed { // smoothly moving orbit to position (unusible function)
    CGPoint vec = findDirection(self.position, point);
    float distance = findDistanse(self.position, point);
    int time = findTimeToPoint(0, distance, speed);
    self.mtime = time+speed/2.0f;
    self.vx = vec.x;
    self.vy = vec.y;
    self.speed = speed;
}


-(void)remove {
    [self.view removeFromSuperview];
    [self.owner.cores removeObject:self];
    if(self.infoBox) {
        [self.infoBox remove];
        [self.owner.boxes removeObject:self.infoBox];
        self.infoBox = nil;
        [self.owner.lines setNeedsDisplay];
    }
}

-(void)move {
    /*
     if(self.rotating) {
     self.angle += self.rspeed;
     self.rtime --;
     
     if(self.rtime<=0) {
     self.rtime = rdm(60, 120);
     self.rspeed = rdm(5, 15);
     }
     else if(self.rtime<self.rspeed) {
     self.rspeed = self.rtime;
     }
     }
     if(self.mtime) {
     self.mtime--;
     if(self.mtime==0) {
     if(self.randomMoving) {
     [self rotate];
     }
     }
     
     else if(self.mtime<self.speed) {
     self.speed = self.mtime;
     }
     self.position = CGPointMake(self.position.x+self.vx*self.speed, self.position.y+self.vy*self.speed);
     }
     */
}

@end
