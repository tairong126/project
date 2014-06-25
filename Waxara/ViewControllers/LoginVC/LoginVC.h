//
//  LoginVC.h
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "BaseVC.h"

#import "LiveCameraRoundImageView.h"
#import "WATextField.h"

#import "Constant.h"

@class Lines;
@class BorderView;
@class LineArm;

#define PROFILE_INFO 1
#define REGISTER_INFO 2

@interface LoginVC : BaseVC<UITextFieldDelegate>

@property Lines *lines;

//Login TextField
@property (weak, nonatomic) IBOutlet WATextField *tfEmail;
@property (weak, nonatomic) IBOutlet WATextField *tfPassword;

//Register TextField
@property (weak, nonatomic) IBOutlet WATextField *tfRegEmail;
@property (weak, nonatomic) IBOutlet WATextField *tfRegPassword;
@property (weak, nonatomic) IBOutlet WATextField *tfRegConfirm;
@property (weak, nonatomic) IBOutlet WATextField *tfRegName;
@property (weak, nonatomic) IBOutlet WATextField *tfRegSurname;

//Sub Views
@property (weak, nonatomic) IBOutlet UIView *viewLogin;
@property (weak, nonatomic) IBOutlet UIView *viewRegister;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UIView *viewProfile;

@property (weak, nonatomic) IBOutlet LiveCameraRoundImageView *ivLiveUser;
@property (weak, nonatomic) IBOutlet LiveCameraRoundImageView *ivLIveUserRegister;
@property (weak, nonatomic) IBOutlet BorderView *viewRegisterInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@property UIImageView* ivControl;


@property (strong, nonatomic) LineArm* armForCapture; //Connection with profile and capture button



//Touch related
@property int nDraggingView;
@property BOOL bDragging;
@property CGPoint pointTouch;

- (IBAction)logIn:(id)sender;
- (IBAction)createAccount:(id)sender;

+ (LoginVC*) loginVC;

- (IBAction)captureProfileImage:(id)sender;
@end
