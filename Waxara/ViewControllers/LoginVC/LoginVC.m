//
//  LoginVC.m
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "LoginVC.h"
#import "MainMotherVC.h"

#import "Constant.h"
#import "BorderView.h"
#import "Lines.h"
#import "LineArm.h"

#import "AppData.h"

#import "InterfaceUtil.h"
#import "Profile.h"


@interface LoginVC ()

@end

@implementation LoginVC

#pragma mark - View Life Cycle

+ (LoginVC*) loginVC
{
    return [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:[NSBundle mainBundle]];
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
    [self setNotifications];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Initialization
    [self processCameraStreaming:YES];
    

    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self processCameraStreaming:NO];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self.ivLiveUser setCaptureViewTransform];
    [self.ivLIveUserRegister setCaptureViewTransform];
}

#pragma mark - Utility
- (void) processCameraStreaming: (BOOL) bStart
{
    if (bStart) {
        if (self.viewLogin.hidden) {
            [self.ivLIveUserRegister startLiveStreaming];
            [self.ivLiveUser stopLiveStreaming];
        }
        else
        {
            [self.ivLIveUserRegister stopLiveStreaming];
            [self.ivLiveUser startLiveStreaming];
        }
    }
    else
    {
        [self.ivLIveUserRegister stopLiveStreaming];
        [self.ivLiveUser stopLiveStreaming];
    }
}

- (void) showSubView: (UIView*) viewWillShow hide: (UIView*) viewWillHide
{
    viewWillShow.alpha = 0.0f;
    viewWillShow.hidden = NO;
    
    [viewWillShow bringSubviewToFront:viewWillShow];
    
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
        viewWillHide.alpha = 0.0f;

    } completion:^(BOOL finished) {
        viewWillHide.hidden = YES;
//        [self processCameraStreaming:YES];
        
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
            
            viewWillShow.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
        }];

        
        
        

    }];

    viewWillShow.hidden = NO;
    viewWillHide.hidden = YES;
    [self processCameraStreaming:YES];
    

}

- (void) setNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
}

- (void) initComponents
{
    //Add circle to profile view
    self.ivControl = [[UIImageView alloc] initWithFrame:CGRectMake(self.viewProfile.frame.origin.x + self.viewProfile.frame.size.width / 2 - 18, self.viewProfile.frame.origin.y + self.viewProfile.frame.size.height - 18, 36, 36)];
    [self.viewRegister addSubview:self.ivControl];
    self.ivControl.userInteractionEnabled = YES;
    
    self.ivControl.contentMode = UIViewContentModeScaleToFill;
    self.ivControl.image = drawCircle(CGSizeMake(36, 36), BLUECOLOR, [UIColor clearColor], 2);
    
    ///////////////////   Set Checker   ///////////////////////////
    
    //For Login
    [self.tfEmail createChecker:TextFieldCheckerTypeEmail data:nil minLength:0];
    [self.tfEmail setPlaceholderWithText:@"E-mail" font:[UIFont fontWithName:@"HelveticaNeue" size:12] color:MAIN_BLUE_COLOR];
    self.tfEmail.tag = TextFieldTagEmail;
    
    [self.tfPassword createChecker:TextFieldCheckerTypeDefault data:nil minLength:6];
    [self.tfPassword setPlaceholderWithText:@"Password" font:[UIFont fontWithName:@"HelveticaNeue" size:12] color:MAIN_BLUE_COLOR];
    self.tfPassword.tag = TextFieldTagPassword;
    
    //For Register
    [self.tfRegEmail createChecker:TextFieldCheckerTypeEmail data:nil minLength:0];
    [self.tfRegEmail setPlaceholderWithText:@"E-mail" font:[UIFont fontWithName:@"HelveticaNeue" size:12] color:MAIN_BLUE_COLOR];
    self.tfRegEmail.tag = TextFieldTagRegistrationEmail;
    
    [self.tfRegPassword createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfRegPassword setPlaceholderWithText:@"Password" font:[UIFont fontWithName:@"HelveticaNeue" size:12] color:MAIN_BLUE_COLOR];
    self.tfRegPassword.tag = TextFieldTagRegistrationPassword;

    [self.tfRegConfirm createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfRegConfirm setPlaceholderWithText:@"Confirm password" font:[UIFont fontWithName:@"HelveticaNeue" size:12] color:MAIN_BLUE_COLOR];
    self.tfRegConfirm.tag = TextFieldTagRegistrationConfirmPassword;
    
    [self.tfRegName createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfRegName setPlaceholderWithText:@"Name" font:[UIFont fontWithName:@"HelveticaNeue" size:12] color:MAIN_BLUE_COLOR];
    self.tfRegName.tag = TextFieldTagRegistrationName;
    
    [self.tfRegSurname createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfRegSurname setPlaceholderWithText:@"Surname" font:[UIFont fontWithName:@"HelveticaNeue" size:12] color:MAIN_BLUE_COLOR];
    self.tfRegSurname.tag = TextFieldTagRegistrationSurname;
    

    //Show or hide sub views
    
    self.viewLogin.hidden = NO;
    self.viewRegister.hidden = YES;
    
    [self.viewLogin bringSubviewToFront:self.view];
    
    //set RegisterInfo view components
    self.lines = [[Lines alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];


    [self.viewRegisterInfo moveStartLineArm:CGPointMake(self.viewProfile.frame.origin.x + self.viewProfile.frame.size.width / 2, self.viewProfile.frame.origin.y + self.viewProfile.frame.size.height + 18) armType: ARM_LT];
    [self.viewRegisterInfo moveEndLineArm:CGPointMake(self.viewRegisterInfo.frame.origin.x, self.viewRegisterInfo.frame.origin.y) armType:ARM_LT specific:NO];

    [self.viewRegisterInfo moveStartLineArm:CGPointMake(self.viewRegisterInfo.frame.origin.x + self.viewRegisterInfo.frame.size.width, self.viewRegisterInfo.frame.origin.y + self.viewRegisterInfo.frame.size.height) armType: ARM_RB];
    [self.viewRegisterInfo moveEndLineArm:CGPointMake(512, self.btnRegister.frame.origin.y) armType:ARM_RB specific:YES];

    
    self.viewRegisterInfo.active = YES;
    self.viewRegisterInfo.lines = self.lines;
    self.viewRegisterInfo.bMoveableRBEnd = NO;
    self.viewRegisterInfo.bMoveableLTStart = YES;
    
    //Add line Arm for capture button
    self.armForCapture = [LineArm new];
    self.armForCapture.start = CGPointMake(578, 152);
    self.armForCapture.end = CGPointMake(970, 384);
    self.armForCapture.active = YES;
    
    [self.lines.arms addObject:self.armForCapture];
    
    [self.viewLine addSubview:self.lines];
    
    
    //Re draw
    [self.lines setNeedsDisplay];

}



- (void) checkTextField: (UITextField*) textField
{
    switch (textField.tag) {
        case TextFieldTagEmail:
        {
            [self.tfEmail check];
            if(self.tfEmail.checkStatus != TextFieldCheckStatusError) [self.tfPassword becomeFirstResponder];

            break;
        }
        case TextFieldTagPassword:
        {
            [self.tfPassword check];
            if(self.tfPassword.checkStatus != TextFieldCheckStatusError) [self.tfPassword resignFirstResponder];
            
            break;
        }
        case TextFieldTagRegistrationEmail:
        {
            [self.tfRegEmail check];
            if(self.tfRegEmail.checkStatus != TextFieldCheckStatusError) [self.tfRegPassword becomeFirstResponder];
            
            break;
        }
        case TextFieldTagRegistrationPassword:
        {
            [self.tfRegPassword check];
            if(self.tfRegPassword.checkStatus != TextFieldCheckStatusError) [self.tfRegConfirm becomeFirstResponder];
            
            break;
        }
        case TextFieldTagRegistrationConfirmPassword:
        {
            if([self.tfRegConfirm.text isEqualToString:self.tfRegPassword.text]) {
                self.tfRegConfirm.checkStatus = TextFieldCheckStatusMatch;
            }
            else {
                self.tfRegConfirm.checkStatus = TextFieldCheckStatusError;
            }

            if(self.tfRegConfirm.checkStatus != TextFieldCheckStatusError) [self.tfRegName becomeFirstResponder];
            
            break;
        }
        case TextFieldTagRegistrationName:
        {
            [self.tfRegName check];
            if(self.tfRegName.checkStatus != TextFieldCheckStatusError) [self.tfRegSurname becomeFirstResponder];
            
            break;
        }
        case TextFieldTagRegistrationSurname:
        {
            [self.tfRegSurname check];
            if(self.tfRegSurname.checkStatus != TextFieldCheckStatusError) [self.tfRegSurname resignFirstResponder];
            
            break;
        }


            
        
            
        default:
            break;
    }
}

#pragma mark - User Interaction
- (IBAction)captureProfileImage:(id)sender
{
    [self.ivLIveUserRegister captureLiveCamera];
}

- (IBAction)logIn:(id)sender
{
    [AppData sharedAppData].bLoggedIn = YES;
    [[AppData sharedAppData] saveAppSetting];
    
    //Get profile(Temp)
    Profile* userProfile = [[Profile alloc] init];
    
    //Init Profile of User
    userProfile.name = @"Kamil";
    userProfile.money = 1409879823;
    userProfile.image = [UIImage imageNamed:@"Profile Photo"];
    userProfile.email = @"someone@example.com";
    userProfile.password = @"qwerty";
    userProfile.surname = @"Smith";
    userProfile.dateOfBirth = @"18.06.1980";
    userProfile.nationality = @"American";
    userProfile.addressLine1 = @"some address 1";
    userProfile.addressLine2 = @"some address 2";
    userProfile.city = @"Manchester";
    userProfile.zip = @"0300000";
    userProfile.country = @"United Kingdom";
    userProfile.position = @"CEO";
    userProfile.tot = 89;
    userProfile.perf = 74;
    
    MainMotherVC* motherVC = [MainMotherVC motherVCWithProfile:userProfile];
    
    [self.navigationController pushViewController:motherVC animated:NO];
}

- (IBAction)createAccount:(id)sender
{
    [self showSubView:self.viewRegister hide:self.viewLogin];
}

- (IBAction)showLoginPage:(id)sender
{
    [self showSubView:self.viewLogin hide:self.viewRegister];
}

- (IBAction)showForgottenPage:(id)sender
{
    
}

#pragma mark - UITextField Delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self processVisibleArea:textField];
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField { // Event on click "return" button
    if((textField.tag == TextFieldTagEmail) || (textField.tag == TextFieldTagPassword)
       || (textField.tag == TextFieldTagRegistrationEmail) || (textField.tag == TextFieldTagRegistrationPassword) || (textField.tag == TextFieldTagRegistrationConfirmPassword) || (textField.tag == TextFieldTagRegistrationName) || (textField.tag == TextFieldTagRegistrationSurname))
    {
        [self checkTextField:textField];
        return YES;
    }

    [textField resignFirstResponder];
    
    return YES;
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

- (void) processVisibleArea: (UITextField*) textField
{
    if ((textField == self.tfEmail) || (textField == self.tfEmail))
    {
        [self keyboardShow:nil];
    }
    else
    {
        CGPoint pointTop = [self.viewRegister convertPoint:self.viewRegisterInfo.frame.origin fromView:self.view];
        
        float fBottom = pointTop.y + 360;
        
        if (fBottom > 768) {
            self.viewRegisterInfo.frame = CGRectOffset(self.viewRegisterInfo.frame, 0, 768 - fBottom);
            [self.viewRegisterInfo offsetInView:CGPointMake(0, 768 - fBottom)];
            

            fBottom = 768;
        }

        if (pointTop.x < 0) {
            self.viewRegisterInfo.frame = CGRectOffset(self.viewRegisterInfo.frame, -pointTop.x, 0);
            [self.viewRegisterInfo offsetInView:CGPointMake(-pointTop.x, 0)];
            
        }
        else if (pointTop.x + self.viewRegisterInfo.frame.size.width > 1024)
        {
            self.viewRegisterInfo.frame = CGRectOffset(self.viewRegisterInfo.frame, 1024 - (pointTop.x + self.viewRegisterInfo.frame.size.width), 0);
            [self.viewRegisterInfo offsetInView:CGPointMake(1024 - (pointTop.x + self.viewRegisterInfo.frame.size.width), 0)];
            
        }
        
        [self.lines setNeedsDisplay];

        float fOffsetY = fBottom - (768 - KEYBOARD_HEIGHT);
        
        if (fOffsetY > 0) {
            [UIView beginAnimations: nil context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: 0.3f];
            self.view.frame = CGRectMake(0, -fOffsetY, self.view.frame.size.width, self.view.frame.size.height);
            [UIView commitAnimations];
        }
    }
}

#pragma mark - Touch Event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.viewRegister.hidden) return;
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint posTouchBegan = [touch locationInView:self.view];
    

    
    if ((CGRectContainsPoint(self.viewProfile.frame, posTouchBegan)) || (CGRectContainsPoint(self.ivControl.frame, posTouchBegan))) {
        
        self.bDragging = YES;
        self.nDraggingView = PROFILE_INFO;
        self.pointTouch = posTouchBegan;
    }
    else if (CGRectContainsPoint(self.viewRegisterInfo.frame, posTouchBegan))
    {
        self.bDragging = YES;
        self.pointTouch = posTouchBegan;
        self.nDraggingView = REGISTER_INFO;
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.bDragging) return;

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchMoved = [touch locationInView:self.view];
    
    // delta x, y
    float dx = touchMoved.x - self.pointTouch.x;
    float dy = touchMoved.y - self.pointTouch.y;

    self.pointTouch = touchMoved;
    
    switch (self.nDraggingView) {
        case PROFILE_INFO:
        {
            self.viewProfile.frame = CGRectOffset(self.viewProfile.frame, dx, dy);
            self.viewRegisterInfo.frame = CGRectOffset(self.viewRegisterInfo.frame, dx, dy);
            self.ivControl.frame = CGRectOffset(self.ivControl.frame, dx, dy);
            
            [self.viewRegisterInfo offset:CGPointMake(dx, dy)];
            
            self.armForCapture.start = CGPointMake(self.armForCapture.start.x + dx, self.armForCapture.start.y + dy);
            
            [self.lines setNeedsDisplay];

            break;
        }
        case REGISTER_INFO:
        {
            self.viewRegisterInfo.frame = CGRectOffset(self.viewRegisterInfo.frame, dx, dy);
            [self.viewRegisterInfo offsetInView:CGPointMake(dx, dy)];
            
            [self.lines setNeedsDisplay];
            break;
        }

        default:
            break;
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.bDragging = NO;
    self.nDraggingView = 0;
}


@end
