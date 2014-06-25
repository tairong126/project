//
//  BaseSubVC.h
//  Waxara
//
//  Created by Passion on 6/17/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSubVC : UIViewController

@property UIViewController* superVC;

#pragma mark - Keyboard Utility
- (void) processVisibleArea: (UITextField*) textField inView: (UIView*) viewSuper;

-(void)keyboardHide:(NSNotification *)notification;

@end
