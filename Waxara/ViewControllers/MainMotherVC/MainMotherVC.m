//
//  MainMotherVC.m
//  Waxara
//
//  Created by Passion on 6/16/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "MainMotherVC.h"

#import "Profile.h"
#import "StringUtil.h"
#import "InterfaceUtil.h"
#import "AppData.h"

#import "AppDelegate.h"
#import "AppData.h"

#import "CircularUIImageView.h"
#import "SearchView.h"

#import "Lines.h"
#import "Core.h"
#import "Touch.h"
#import "Tool.h"

#import "NewsViewController.h"

@interface MainMotherVC ()

@end

@implementation MainMotherVC

#pragma mark - View Life Cycle
+ (MainMotherVC*) motherVCWithProfile: (Profile*) profileUser
{
    return [[MainMotherVC alloc] initWithProfile:profileUser];

}

- (id) initWithProfile: (Profile*) profileUser
{
    self = [super initWithNibName:@"MainMotherVC" bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.profileUser = profileUser;
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initComponents];
    [self initSubViews];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma mark - UI initialize
- (void) initComponents
{
    self.cores = [NSMutableArray new];
    self.boxes = [NSMutableArray new];
    self.touches = [NSMutableArray new];

    self.lines = [[Lines alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    
    [self.viewInner addSubview:self.lines];
    
    [self initIcons];

    [self initBottomBar];
}
-(void)initIcons {
    int glow = 3;
    CGSize size = CGSizeMake(ICONSIZE, ICONSIZE);
    UIImage *whiteIconCircle = drawCircle(CGSizeMake(36, 36), [UIColor whiteColor], nil, 2);
    
    NSArray *iconsFromSprite = cutImage([UIImage imageNamed:@"spritesnew.png"], ICONROWCOUNT, ICONHEIGHTCOUNT);
    NSMutableArray *allIcons = [[NSMutableArray alloc]initWithArray:iconsFromSprite];
    
    // Grid
    UIImage *grid = drawGrid(whiteIconCircle.size, 8,YES,NO);
    [allIcons addObject:grid];
    
    
    NSMutableArray *icons = [NSMutableArray new];
    for(int i=0;i<allIcons.count;i++) {
        UIImage *icon = [allIcons objectAtIndex:i];
        UIImage *image = combineImages([[NSArray alloc]initWithObjects: icon,whiteIconCircle,nil],size);
        UIImage *b = colorImage(image, size, BLUECOLOR, glow);
        UIImage *g = colorImage(image, size, GREENCOLOR, glow);
        UIImage *r = colorImage(image, size, REDCOLOR, glow);
        NSArray *array = [[NSArray alloc]initWithObjects:image,b,g,r, nil];
        [icons addObject:array];
    }
    self.icons = icons;
}



- (void) initBottomBar
{
    self.ivUserPhoto.image = self.profileUser.image;
    self.lblUserName.text = self.profileUser.name;
    self.lblTotalMoney.text = currencyString(self.profileUser.money, @"euro");
    
    self.searchField.allData = [AppData sharedAppData].arrSearchContent;
    self.searchField.vcSuper = self;
}

- (void) initSubViews
{
    //Add Setting View
    vcSetting = [SettingVC settingViewWithProfile:self.profileUser superVC:self];
    vcSetting.view.frame = CGRectMake(1024, 0, vcSetting.view.frame.size.width, vcSetting.view.frame.size.height);
    
    [self.viewInner addSubview:vcSetting.view];
    
}


#pragma mark - User Interaction
- (IBAction)showDesk:(id)sender
{
    NSLog(@"Show Desk Page");
    
}

- (IBAction)showMessages:(id)sender
{
    NSLog(@"Show Message Page");
    
}

- (IBAction)showCalendar:(id)sender
{
    NSLog(@"Show Calendar Page");
    
}

- (IBAction)showNews:(id)sender
{
    NewsViewController * newsController = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:newsController animated:NO];
}

- (IBAction)showSetting:(id)sender
{
    NSLog(@"Show Setting Page");
    
    CGRect rectSettingView;
    
    if (self.bShowSetting)
    {
        [self.viewInner bringSubviewToFront:vcSetting.view];
        
        rectSettingView = CGRectMake(1024, 0, vcSetting.view.frame.size.width, vcSetting.view.frame.size.height);
        
        self.bShowSetting = NO;
    }
    else
    {
        rectSettingView = CGRectMake(1024 - vcSetting.view.frame.size.width, 0, vcSetting.view.frame.size.width, vcSetting.view.frame.size.height);

        self.bShowSetting = YES;
    }
    
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.3f];
    vcSetting.view.frame = rectSettingView;
    [UIView commitAnimations];

    
}

- (IBAction)showBusinessReg:(id)sender
{
    
}

- (IBAction)showProfile:(id)sender
{
    for(Core *core in self.cores) {
        if(core.profile == self.profileUser) {
            [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
                core.view.alpha = 0;
            } completion:^ (BOOL finished){if (finished) {
                [core remove];
            }}];
            return;
        }
    }
    
    Core *profileCore = [[Core alloc]initWithProfile:self.profileUser icons:self.icons owner:self];  // Profile core
    
    profileCore.position = CGPointMake(1024/2,768/2);
    profileCore.show = YES;
    [self.cores addObject:profileCore];
    [self.viewInner addSubview:profileCore.view];
    profileCore.view.alpha = 0;
    [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
        profileCore.view.alpha = 1;
    } completion:nil];

}

#pragma mark Core Functions
-(void)showCoreWithCompany:(Company*)company {
    Core *companyCore = [[Core alloc]initWithCompany:company icons:self.icons];
    companyCore.position = CGPointMake(700,400);
    companyCore.show = YES;
    [self.cores addObject:companyCore];
    [self.view addSubview:companyCore.view];
}


-(void)showCoreWithToolName:(NSString *)name {
    Tool *tool = [Tool new];
    tool.name = name;
    tool.progress = 15;
    tool.current = 15;
    tool.max = 100;
    [self showCoreWithTool:tool];
}

-(void)showCoreWithTool:(Tool*)tool {
    Core *core = [[Core alloc] initWithTool:tool icons:self.icons];
    core.show = YES;
    core.position = CGPointMake(150, 150);
    core.view.alpha = 0;
    [self.cores addObject:core];
    [self.view addSubview:core.view];
    [UIView animateWithDuration:.8f delay:0.0f options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         core.view.alpha = 1;
                     }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }];
}

- (void) logOut
{
    [AppData sharedAppData].bLoggedIn = NO;
    [[AppData sharedAppData] saveAppSetting];
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate showLoginVC];
}
    


#pragma mark - Keyboard Event
-(void)keyboardHide:(NSNotification *)notification {
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.3f];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

-(void)keyboardShow:(NSNotification *)notification {
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.3f];
    self.view.frame = CGRectMake(0, -146, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark - Touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];

    //Init Touch
    Touch*t = [Touch new];
    t.owner = touch;
    [self.touches addObject:t];
    
    CGPoint pos = [touch locationInView:self.view];
    t.px = pos.x;
    t.py = pos.y;


    //Search Field Touch process
    if(self.searchField.opened)
    {
        if([self.searchField touchDown:[touch locationInView:self.searchField.viewLabels]])
        {
            return;
        }
    }
    
    //box event
    for(BoxView *box in self.boxes) { // Boxes
        BOOL boxSelected = NO;
        for(Touch *ot in self.touches) { // Check if box already selected by other touch
            if(box == ot.selectedBox) {
                boxSelected = YES;
                break;
            }
        }
        if(!boxSelected) {
            CGPoint locationInBox = [touch locationInView:box];
            CGRect hitBox;
            hitBox.size = box.frame.size;
            if(CGRectContainsPoint(hitBox, locationInBox)) {
                t.selectedBox = box;
                return;
            }
        }
    }
    for(Core *core in self.cores) { // Cores
        BOOL coreSelected = NO;
        for(Touch *ot in self.touches) { // Check if core already selected by other touch
            if(core == ot.selectedCore) {
                coreSelected = YES;
                break;
            }
        }
        if(!coreSelected) {
            int coreValue = [core touchDown:pos];
            if(coreValue != -2) { // -2: nothing in core selected
                t.selectedCore = core;
                t.coreValue = coreValue;
                return;
            }
        }
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    Touch*t;
    for(Touch*tch in self.touches) {
        if(tch.owner == touch) {
            t = tch;
            break;
        }
    }
    CGPoint pos = [touch locationInView:self.view];
    float dx = pos.x - t.px; // delta
    float dy = pos.y - t.py;

    if(t.selectedCore && t.coreValue == -1) { // if core selected (not icons)
        t.selectedCore.position = CGPointMake(t.selectedCore.position.x+dx, t.selectedCore.position.y+dy); // move core
        float distanceToHide = 50.0f;
        float distanceToBorder = distanceToHide;
        if(t.selectedCore.position.x<50) distanceToBorder = t.selectedCore.position.x;
        else if(t.selectedCore.position.x>1024-distanceToHide) distanceToBorder = 1024 - t.selectedCore.position.x;
        if(t.selectedCore.position.y<50) distanceToBorder = t.selectedCore.position.y;
        else if(t.selectedCore.position.y>768-distanceToHide) distanceToBorder = 768 - t.selectedCore.position.y;
        if(distanceToBorder<distanceToHide/10.0f) {
            distanceToBorder = distanceToHide/10.0f;
        }
        t.removeCore = distanceToBorder < distanceToHide;
        t.selectedCore.view.alpha = distanceToBorder/distanceToHide;
    }
    else if(t.selectedBox) {
        [t.selectedBox offsetInView:CGPointMake(dx, dy)]; // move box
        t.selectedBox.frame = CGRectOffset(t.selectedBox.frame, dx, dy);
    }
    t.px = pos.x;
    t.py = pos.y;
    
    [self.lines setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];

    
    CGPoint pos = [touch locationInView:self.view];
    
    Touch*t;
    for(Touch*tch in self.touches) {
        if(tch.owner == touch) {
            t = tch;
            break;
        }
    }
    if(t.removeCore) {
        Core *core = t.selectedCore;
        [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
            core.view.alpha = 0;
        } completion:^ (BOOL finished){if (finished) {
            [core remove];
        }}];
    }
    
    //CGPoint pos = [touch locationInView:self.view];
    t.selectedBox = nil;
    t.selectedCore = nil;
    t.selectedTableView = nil;
    t.selectedGraph = nil;
    [self.touches removeObject:t];
    
}

#pragma mark - UITextField Delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.searchField checkTextField:textField])
    {
        [self processVisibleArea:textField inView:self.viewCommand];
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField { // Event on click "return" button
    if([textField.placeholder isEqualToString:@"Action"]) {
        [self.searchField returnClick];
        return YES;
    }

    
    return YES;
}

#pragma mark Microphone functions
-(void)initAudio
{
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:nil];
    
    _audioRecorder = [[AVAudioRecorder alloc]
                      initWithURL:soundFileURL
                      settings:recordSettings
                      error:&error];
    
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [_audioRecorder prepareToRecord];
        self.audioRecorder.meteringEnabled = YES;
    }
    self.audioRecorder.delegate = self;
}
- (void)startAudioMetering
{
    self.meterTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateAudioMeter) userInfo:nil repeats:YES];
}

- (void)stopAudioMetering
{
    [self.meterTimer invalidate];
}

- (void)updateAudioMeter
{
    if(self.meterMicrophone) {
        [self.audioRecorder updateMeters];
        self.dbLevel = ([self.audioRecorder averagePowerForChannel:0] + 70)*1.4f;
    }
    if(self.meterAudio) {
        [self.audioPlayer updateMeters];
        self.outputVolume = ([self.audioPlayer averagePowerForChannel:0] + 70)*1.4f;
    }
}

- (void)startRecording {
    if (!_audioRecorder.recording)
    {
        [self startAudioMetering];
        [_audioRecorder record];
    }
}

-(void)playLocalSound:(NSString*)name type:(NSString*)type volume:(float)volume repeat:(BOOL)repeat {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: path];
    
    self.repeatAudio = repeat;
    
    self.audioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:NULL];
    self.audioPlayer.meteringEnabled = YES;
    
    self.audioPlayer.volume = volume;
    
    self.audioPlayer.delegate = self;
    
    [self.audioPlayer prepareToPlay];
    
    [self.audioPlayer play];
    
}

- (void)playRecorded {
    if (!_audioRecorder.recording)
    {
        
        NSError *error;
        
        _audioPlayer = [[AVAudioPlayer alloc]
                        initWithContentsOfURL:_audioRecorder.url
                        error:&error];
        
        _audioPlayer.delegate = self;
        
        if (error) {NSLog(@"Error: %@",[error localizedDescription]);}
        else [_audioPlayer play];
    }
}
-(void)stopRecording {
    if (_audioRecorder.recording)
    {
        [self stopAudioMetering];
        [_audioRecorder stop];
    }
}
-(void)stopPlaying {
    if (_audioPlayer.playing) {
        [_audioPlayer stop];
    }
}

- (void)stopAudio {
    if (_audioRecorder.recording) {
        [self stopAudioMetering];
        [_audioRecorder stop];
    }
    if (_audioPlayer.playing) {
        [_audioPlayer stop];
    }
}





-(void)audioPlayerDidFinishPlaying: (AVAudioPlayer *)player successfully:(BOOL)flag {
    if(flag && self.repeatAudio) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.audioPlayer play];;
        });
    }
}

-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player
                                error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}


@end
