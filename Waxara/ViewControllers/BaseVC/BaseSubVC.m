//
//  BaseSubVC.m
//  Waxara
//
//  Created by Passion on 6/17/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "BaseSubVC.h"
#import "InterfaceUtil.h"

@interface BaseSubVC ()

@end

@implementation BaseSubVC

#pragma mark - View Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.superVC = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNotifications];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification
- (void) setNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
}

#pragma mark - Utility
-(void)keyboardHide:(NSNotification *)notification {
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.3f];
    self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void) processVisibleArea: (UITextField*) textField inView: (UIView*) viewSuper
{
    CGPoint pointTop = [self.view convertPoint:textField.frame.origin fromView:viewSuper];
    
    float fBottom = pointTop.y + textField.frame.size.height * 2 + 10; // 10 is gutter
    
    float fOffsetY = fBottom - (768 - KEYBOARD_HEIGHT);
    
    if (fOffsetY > 0) {
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: 0.3f];
        self.view.frame = CGRectMake(self.view.frame.origin.x, -fOffsetY, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
