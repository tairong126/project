//
//  AppData.h
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//
//  Todo Here:
//
//      Define variables and functions when will be used in runtime
//


#import <Foundation/Foundation.h>


@class Profile;
@interface AppData : NSObject

@property (nonatomic) BOOL bLoggedIn;


@property (nonatomic, strong) Profile* profileUser;
@property (nonatomic, strong) NSMutableArray* arrSearchContent;

//AppData SingleTon
+ (AppData*) sharedAppData;

- (void) saveAppSetting;



@end
