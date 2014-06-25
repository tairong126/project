//
//  MainMotherVC.h
//  Waxara
//
//  Created by Passion on 6/16/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//


#import "BaseVC.h"
#import "SettingVC.h"
#import <AVFoundation/AVFoundation.h>

@class Profile;
@class SearchView;
@class CircularUIImageView;
@class Core;
@class Lines;


@interface MainMotherVC : BaseVC<UITextFieldDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    SettingVC* vcSetting;
}

#pragma mark - Sub Views
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIView *viewInner;
@property (weak, nonatomic) IBOutlet UIView *barBottom;
@property (weak, nonatomic) IBOutlet UIView *viewCommand;

#pragma mark - User Profile
@property (nonatomic, strong) Profile* profileUser;

#pragma mark - Bottom Bar Items
@property (weak, nonatomic) IBOutlet CircularUIImageView *ivUserPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalMoney;
@property (weak, nonatomic) IBOutlet SearchView *searchField;

#pragma mark - Audio and Microphone
//Microphone
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong) NSTimer *meterTimer;
@property BOOL meterMicrophone;
@property (nonatomic) float dbLevel;
//Audio
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property BOOL repeatAudio;
@property BOOL meterAudio;
@property float outputVolume;

#pragma mark - Movable View
@property Lines *lines;
@property NSMutableArray *boxes;
@property NSMutableArray *cores;
@property NSArray *icons;

@property NSMutableArray* touches;

#pragma mark - Status
@property BOOL bShowSetting;

#pragma mark - User interactions
- (IBAction)showDesk:(id)sender;
- (IBAction)showMessages:(id)sender;
- (IBAction)showCalendar:(id)sender;
- (IBAction)showNews:(id)sender;
- (IBAction)showSetting:(id)sender;
- (IBAction)showBusinessReg:(id)sender;
- (IBAction)showProfile:(id)sender;
-(void) showCoreWithToolName:(NSString *)name;


#pragma mark - Audio and Microphone
//Microphone functions
-(void)startRecording;
-(void)stopRecording;

-(void)startAudioMetering;
-(void)stopAudioMetering;

//Audio functions
-(void)playRecorded;
-(void)stopAudio; // stops audio and recording
-(void)stopPlaying; // stops audio
-(void)playLocalSound:(NSString*)name type:(NSString*)type volume:(float)volume repeat:(BOOL)repeat;



- (void) logOut;

#pragma mark - Init VC
- (id) initWithProfile: (Profile*) profileUser;
+ (MainMotherVC*) motherVCWithProfile: (Profile*) profileUser;

@end
