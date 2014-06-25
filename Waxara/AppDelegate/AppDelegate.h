//
//  AppDelegate.h
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//Navigation Controller
@property (strong, nonatomic) UINavigationController* navMain;


- (void) showLoginVC;
@end
