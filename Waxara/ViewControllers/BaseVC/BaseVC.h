//
//  BaseVC.h
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

#pragma mark - Keyboard Utility
- (void) processVisibleArea: (UITextField*) textField inView: (UIView*) viewSuper;

@end
