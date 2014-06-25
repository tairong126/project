//
//  Profile.h
//  Grid
//
//  Created by LinO_dska on 21.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject
@property UIImage *image;

@property NSString *email;
@property NSString *password;
@property NSString *name;
@property NSString *surname;
@property NSString *dateOfBirth;
@property NSString *nationality;
@property NSString *addressLine1;
@property NSString *addressLine2;
@property NSString *city;
@property NSString *zip;
@property NSString *country;

@property NSString *position;

@property BOOL online;
@property int tot;
@property int perf;
@property int money;

@end
