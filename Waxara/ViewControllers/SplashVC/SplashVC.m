//
//  SplashVC.m
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "SplashVC.h"

#import "MBProgressHUD.h"
#import "LoginVC.h"
#import "AppData.h"
#import "MainMotherVC.h"
#import "Profile.h"

#define STEPCOUNT 5

@interface SplashVC ()
@property NSMutableArray* arrStatus;

@end

@implementation SplashVC

#pragma mark - View Life Cycle
+ (SplashVC*) splashVC
{
    return [[self alloc] initWithNibName:@"SplashVC" bundle:[NSBundle mainBundle]];
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initComponents];

//    [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = @"Loading...";
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //change status
    [self.arrStatus replaceObjectAtIndex:0 withObject:@"Connecting to server"];
    [self setStatus];
    
    //Do something
    [self performSelector:@selector(connectServer) withObject:nil afterDelay:.5f];
}

#pragma mark - Utility
- (void) initComponents
{
    self.arrStatus = [NSMutableArray arrayWithArray:@[@"", @"", @"", @"", @""]];
    
    [self setStatus];
}

- (void) setStatus
{
    int nlblStepCount = self.lblStepCollection.count;

//    [UIView beginAnimations: nil context: nil];
//    [UIView setAnimationDuration: 0.5f];
//
//    self.viewStatus.alpha = 0.0f;
//    [UIView commitAnimations];

    //init status labels
    for (int i = 0; i < nlblStepCount; i++)
    {
        UILabel* lblStep = [self.lblStepCollection objectAtIndex:i];
        lblStep.text = [self.arrStatus objectAtIndex:i];
    }

//    [UIView beginAnimations: nil context: nil];
//    [UIView setAnimationDuration: 0.5f];
//    self.viewStatus.alpha = 1.0f;
//    
//    [UIView commitAnimations];
    
    
    
}



- (void) showNextPage
{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    if ([AppData sharedAppData].bLoggedIn)
    {
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
        
        [self.navigationController pushViewController:motherVC animated:YES];
    }
    else
    {
        //Show Login VC
        LoginVC* loginVC = [LoginVC loginVC];
        
        [self.navigationController pushViewController:loginVC animated:NO];
    }
    
}

#pragma mark - Server Interaction
- (void) connectServer
{
    //Connect with Server
    
    
    //after it, go to next step
    [self.arrStatus replaceObjectAtIndex:0 withObject:@"Searching Updates..."];
    [self.arrStatus replaceObjectAtIndex:1 withObject:@"Connecting to server OK"];
    [self setStatus];

    [self performSelector:@selector(searchUpdate) withObject:nil afterDelay:.5f];

}

- (void) searchUpdate
{
    //Update Search
    
    //after it, go to next step
    [self.arrStatus replaceObjectAtIndex:0 withObject:@"Connecting database..."];
    [self.arrStatus replaceObjectAtIndex:1 withObject:@"Searching updates OK"];
    [self.arrStatus replaceObjectAtIndex:2 withObject:@"Connecting to server OK"];
    [self setStatus];

    [self performSelector:@selector(connectDatabase) withObject:nil afterDelay:.5f];
    
}

- (void) connectDatabase
{
    //Connect Database
    
    //after it, go to next step
    [self.arrStatus replaceObjectAtIndex:0 withObject:@"Initializing processes..."];
    [self.arrStatus replaceObjectAtIndex:1 withObject:@"Connecting database OK"];
    [self.arrStatus replaceObjectAtIndex:2 withObject:@"Searching updates OK"];
    [self.arrStatus replaceObjectAtIndex:3 withObject:@"Connecting to server OK"];
    [self setStatus];

    [self performSelector:@selector(initProcess) withObject:nil afterDelay:.5f];
}

- (void) initProcess
{
    //Init process
    
    //after it, go to next step
    [self.arrStatus replaceObjectAtIndex:0 withObject:@"System running..."];
    [self.arrStatus replaceObjectAtIndex:1 withObject:@"Initializing processes OK"];
    [self.arrStatus replaceObjectAtIndex:2 withObject:@"Connecting database OK"];
    [self.arrStatus replaceObjectAtIndex:3 withObject:@"Searching updates OK"];
    [self.arrStatus replaceObjectAtIndex:4 withObject:@"Connecting to server OK"];
    [self setStatus];

    [self performSelector:@selector(runSystem) withObject:nil afterDelay:.5f];
}

- (void) runSystem
{
    //Run system
    
    //after it, go to next step
    [self performSelector:@selector(showNextPage) withObject:nil afterDelay:.5f];
    
}



@end
