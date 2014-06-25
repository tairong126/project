//
//  SettingVC.m
//  Waxara
//
//  Created by Passion on 6/17/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "SettingVC.h"
#import "WATextField.h"
#import "InterfaceUtil.h"
#import "Profile.h"
#import "Constant.h"
#import "MainMotherVC.h"



#define TABCOUNT 3

#define BASE_SUSPEND 702
#define OFFSET_SUSPEND 34
#define TEXT_LFFT_PADDING 20
#define HEIGHT_BOTTOM_BAR 68

#define TAG_SCROLL_PERSONAL 1

@interface SettingVC ()

@end

@implementation SettingVC

#pragma mark - View Life Cycle
+ (SettingVC*) settingViewWithProfile:(Profile*) profile superVC: (UIViewController*) vcSuper
{
    return [[SettingVC alloc] initWithProfile: profile superVC:vcSuper];
}

- (id) initWithProfile: (Profile*) profile superVC: (UIViewController*) vcSuper
{
    self = [super initWithNibName:@"SettingVC" bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        self.infoUser = profile;
        self.superVC = vcSuper;
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
    
    self.nSelectedTab = TagPersonal;
    [self initComponents];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utility
- (void) initComponents
{
    //put scroll bar
    scrollBarPersonal = [WAScrollBar scrollBarWithFrame:CGRectMake(2, self.viewTopBar.frame.origin.y + self.viewTopBar.frame.size.height, 15, self.viewBottomBar.frame.origin.y - (self.viewTopBar.frame.origin.y + self.viewTopBar.frame.size.height))];
    
    scrollBarPersonal.delegate = self;
    scrollBarPersonal.tag = TAG_SCROLL_PERSONAL;
    
    [self.view addSubview:scrollBarPersonal.view];
    
    //ScrollView delegate
    self.scrollViewPersonal.delegate = self;
    self.scrollViewPersonal.tag = TAG_SCROLL_PERSONAL;
    
    
    //For Suspend
    self.btnSuspend.frame = CGRectMake(TEXT_LFFT_PADDING, BASE_SUSPEND + OFFSET_SUSPEND, self.btnSuspend.frame.size.width, self.btnSuspend.frame.size.height);
    
    self.fHeightSVPersonal = self.btnSuspend.frame.origin.y + self.btnSuspend.frame.size.height + (OFFSET_SUSPEND - 4) + HEIGHT_BOTTOM_BAR;
    
    self.scrollViewPersonal.contentSize = CGSizeMake(self.viewPersonal.frame.size.width, self.fHeightSVPersonal);
    
    //For Login
    [self.tfEmail createChecker:TextFieldCheckerTypeEmail data:nil minLength:0];
    [self.tfEmail setPlaceholderWithText:@"E-mail" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfEmail.tag = TextFieldTagEmail;
    
    [self.tfPassword createChecker:TextFieldCheckerTypeDefault data:nil minLength:6];
    [self.tfPassword setPlaceholderWithText:@"Password" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfPassword.tag = TextFieldTagPassword;

    [self.tfName createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfName setPlaceholderWithText:@"Name" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfName.tag = TextFieldTagPassword;
    
    [self.tfSurname createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfSurname setPlaceholderWithText:@"Surname" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfSurname.tag = TextFieldTagSurname;

    [self.tfDateBirth createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfDateBirth setPlaceholderWithText:@"Date of birth" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfDateBirth.tag = TextFieldTagDateBirth;

    [self.tfNationality createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfNationality setPlaceholderWithText:@"Nationality" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfNationality.tag = TextFieldTagNationality;

    [self.tfAddress1 createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfAddress1 setPlaceholderWithText:@"Address line 1" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfAddress1.tag = TextFieldTagAddress1;

    [self.tfAddress2 createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfAddress2 setPlaceholderWithText:@"Name" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfAddress2.tag = TextFieldTagAddress2;

    [self.tfCity createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfCity setPlaceholderWithText:@"City/Town" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfCity.tag = TextFieldTagCity;

    [self.tfZip createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfZip setPlaceholderWithText:@"Zip/Postcode" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfZip.tag = TextFieldTagZip;

    [self.tfCountry createChecker:TextFieldCheckerTypeDefault data:nil minLength:0];
    [self.tfCountry setPlaceholderWithText:@"Country" font:[UIFont fontWithName:@"HelveticaNeue-Light" size:12] color:MAIN_BLUE_COLOR];
    self.tfCountry.tag = TextFieldTagPassword;


    //initialize the textfields
    self.tfName.text = self.infoUser.name;
    self.tfPassword.text = self.infoUser.password;
    self.tfEmail.text = self.infoUser.email;
    self.tfSurname.text = self.infoUser.surname;
    self.tfDateBirth.text = self.infoUser.dateOfBirth;
    self.tfNationality.text = self.infoUser.nationality;
    self.tfAddress1.text = self.infoUser.addressLine1;
    self.tfAddress2.text = self.infoUser.addressLine2;
    self.tfCity.text = self.infoUser.city;
    self.tfZip.text = self.infoUser.zip;
    self.tfCountry.text = self.infoUser.country;
    
}

- (void) setNSelectedTab:(int)nSelectedTab
{
    _nSelectedTab = nSelectedTab;
    
    [self selectTab:self.nSelectedTab];
}

- (void) selectTab: (int) nSelectedTab
{
    for (int i = TagPersonal; i <= TagMoney; i++)
    {
        UIButton* btnTab = (UIButton*)[self.viewTopBar viewWithTag:i];
        UIView* viewSub = [self.viewContent viewWithTag:i];
        
        if (i == nSelectedTab)
        {
            [btnTab setTitleColor:BLUECOLOR forState:UIControlStateNormal];
            [self.viewContent bringSubviewToFront:viewSub];
            viewSub.hidden = NO;
        }
        else
        {
            [btnTab setTitleColor:WHITECOLOR forState:UIControlStateNormal];
            viewSub.hidden = YES;
        }
    }
}

- (void) checkTextField: (UITextField*) textField
{
    switch (textField.tag) {
        case TextFieldTagEmail:
        {
            [self.tfEmail check];
            if(self.tfEmail.checkStatus != TextFieldCheckStatusError) [self.tfEmail resignFirstResponder];
            
            break;
        }
        case TextFieldTagPassword:
        {
            [self.tfPassword check];
            if(self.tfPassword.checkStatus != TextFieldCheckStatusError) [self.tfPassword resignFirstResponder];
            
            break;
        }
        case TextFieldTagName:
        {
            [self.tfName check];
            if(self.tfName.checkStatus != TextFieldCheckStatusError) [self.tfName resignFirstResponder];
            
            break;
        }
        case TextFieldTagSurname:
        {
            [self.tfSurname check];
            if(self.tfSurname.checkStatus != TextFieldCheckStatusError) [self.tfSurname resignFirstResponder];
            
            break;
        }
        case TextFieldTagDateBirth:
        {
            [self.tfDateBirth check];

            if(self.tfDateBirth.checkStatus != TextFieldCheckStatusError) [self.tfDateBirth resignFirstResponder];
            
            break;
        }
        case TextFieldTagNationality:
        {
            [self.tfNationality check];
            if(self.tfNationality.checkStatus != TextFieldCheckStatusError) [self.tfNationality resignFirstResponder];
            
            break;
        }
        case TextFieldTagAddress1:
        {
            [self.tfAddress1 check];
            if(self.tfAddress1.checkStatus != TextFieldCheckStatusError) [self.tfAddress1 resignFirstResponder];
            
            break;
        }
        case TextFieldTagAddress2:
        {
            [self.tfAddress2 check];
            if(self.tfAddress2.checkStatus != TextFieldCheckStatusError) [self.tfAddress2 resignFirstResponder];
            
            break;
        }
        case TextFieldTagCity:
        {
            [self.tfCity check];
            if(self.tfCity.checkStatus != TextFieldCheckStatusError) [self.tfCity resignFirstResponder];
            
            break;
        }
        case TextFieldTagZip:
        {
            [self.tfAddress1 check];
            if(self.tfAddress1.checkStatus != TextFieldCheckStatusError) [self.tfAddress1 resignFirstResponder];
            
            break;
        }
        case TextFieldTagCoutry:
        {
            [self.tfCountry check];
            if(self.tfCountry.checkStatus != TextFieldCheckStatusError) [self.tfCountry resignFirstResponder];
            
            break;
        }
            
        default:
            break;
    }
}


#pragma mark - User Interaction
- (IBAction)LogOff:(UIButton*)sender
{
    NSLog(@"Log off");
    
    [(MainMotherVC*) self.superVC logOut];
}

- (IBAction)checkClicked:(id)sender {
}

- (IBAction)suspendAccount:(id)sender {
}

- (IBAction)tabClicked:(UIButton*)sender
{
    [self selectTab:sender.tag];
}

#pragma mark - UITextField Delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ((textField == self.tfZip) || (textField == self.tfCountry))
    {
        self.scrollViewPersonal.contentSize = CGSizeMake(self.viewPersonal.frame.size.width, self.fHeightSVPersonal);
    }
    else
    {
        self.scrollViewPersonal.contentSize = CGSizeMake(self.viewPersonal.frame.size.width, self.fHeightSVPersonal + 140);
        
    }
    
    [self processVisibleArea:textField inView:self.scrollViewPersonal];
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField { // Event on click "return" button
    [self checkTextField:textField];
    return YES;
}

-(void)keyboardHide:(NSNotification *)notification {
    [super keyboardHide:notification];
    
    self.scrollViewPersonal.contentSize = CGSizeMake(self.viewPersonal.frame.size.width, self.fHeightSVPersonal);
}

#pragma mark - WAScrollBar Delegate
-(void) scrollBarDidScroll: (WAScrollBar*) scrollBar toRatio: (float) fRatio
{
    int nTag = scrollBar.tag;
    
    if (nTag == TAG_SCROLL_PERSONAL)
    {
        float fYPos = (self.scrollViewPersonal.contentSize.height - self.scrollViewPersonal.frame.size.height) * fRatio;
        
        self.scrollViewPersonal.contentOffset = CGPointMake(0, fYPos);
    }
}


#pragma mark - ScrollView Delegate


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    float fYPos = targetContentOffset->y;
    
    float fRatio = 0.0f;
    
    if (scrollView.tag == TAG_SCROLL_PERSONAL)
    {
        fRatio = fYPos / (self.scrollViewPersonal.contentSize.height - self.scrollViewPersonal.frame.size.height);
        
        scrollBarPersonal.fRatio = fRatio;
    }
    
}


@end
