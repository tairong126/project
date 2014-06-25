//
//  AppDelegate.m
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "AppDelegate.h"

#import "SplashVC.h"
#import "LoginVC.h"

#import "Constant.h"
#import "AppData.h"

@implementation AppDelegate

#pragma mark - Life Cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Set RootViewController
    [self setRootVC];
    [self getSetting];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Utility
- (void) setRootVC
{
    SplashVC* splashVC = [SplashVC splashVC];
    
    if (!self.navMain) {
        self.navMain = [[UINavigationController alloc] initWithRootViewController:splashVC];
        
        self.navMain.navigationBarHidden = YES;
    }
    
    self.window.rootViewController = self.navMain;
}

- (void) showLoginVC
{
    LoginVC* loginVC = [LoginVC loginVC];
    
    self.navMain = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
    self.navMain.navigationBarHidden = YES;
    self.window.rootViewController = self.navMain;
}

- (void) getSetting
{
    //Get status of logged in
    [AppData sharedAppData].bLoggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_LOGGED_IN];
    
}

@end
