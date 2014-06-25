//
//  SettingVC.h
//  Waxara
//
//  Created by Passion on 6/17/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "BaseSubVC.h"
#import "WAScrollBar.h"

@class WATextField;
@class Profile;


typedef enum : NSUInteger {
    TagPersonal = 1001,
    TagPrivacy,
    TagMoney,
} TabTag;

@interface SettingVC : BaseSubVC<WAScrollBarDelegate, UIScrollViewDelegate>
{
    WAScrollBar* scrollBarPersonal;
}

#pragma mark - Sub Views
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UIView *viewPersonal;
@property (weak, nonatomic) IBOutlet UIView *viewPrivacy;
@property (weak, nonatomic) IBOutlet UIView *viewMoney;
@property (weak, nonatomic) IBOutlet UIView *viewTopBar;
@property (weak, nonatomic) IBOutlet UIView *viewBottomBar;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewPersonal;


#pragma mark - Personal View
@property (weak, nonatomic) IBOutlet WATextField *tfEmail;
@property (weak, nonatomic) IBOutlet WATextField *tfPassword;
@property (weak, nonatomic) IBOutlet WATextField *tfName;
@property (weak, nonatomic) IBOutlet WATextField *tfSurname;
@property (weak, nonatomic) IBOutlet WATextField *tfDateBirth;
@property (weak, nonatomic) IBOutlet WATextField *tfNationality;
@property (weak, nonatomic) IBOutlet WATextField *tfAddress1;
@property (weak, nonatomic) IBOutlet WATextField *tfAddress2;
@property (weak, nonatomic) IBOutlet WATextField *tfCity;
@property (weak, nonatomic) IBOutlet WATextField *tfZip;
@property (weak, nonatomic) IBOutlet WATextField *tfCountry;

@property (weak, nonatomic) IBOutlet UIButton *btnLogOff;
@property (weak, nonatomic) IBOutlet UIButton *btnSuspend;
#pragma mark - Status
@property (nonatomic)int nSelectedTab;
@property float fHeightSVPersonal;


#pragma mark - Data
@property (nonatomic, strong) Profile* infoUser;

#pragma mark - User Interaction
- (IBAction)LogOff:(UIButton*)sender;
- (IBAction)checkClicked:(id)sender;
- (IBAction)suspendAccount:(id)sender;

- (IBAction)tabClicked:(UIButton*)sender;

#pragma mark - Init
+ (SettingVC*) settingViewWithProfile:(Profile*) profile superVC: (UIViewController*) vcSuper;

@end
