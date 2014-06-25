//
//  Constant.h
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//
//  Todo Here:
//
//      Define the constants what will be used in this project
//
//

#ifndef Waxara_Constant_h
#define Waxara_Constant_h

#pragma mark - User Defaults Identifiers


#pragma mark - App Constants
#define WIDTH_SCROLLBAR 15

#pragma mark - Color Constants

#define MAIN_BLUE_COLOR [UIColor colorWithRed:18.0f / 255.0f green:213.0f / 255.0f blue:228.0f / 255.0f alpha:1.0f]

typedef enum {
    TextFieldTagDefault = 0,
    TextFieldTagEmail,
    TextFieldTagPassword,
    TextFieldTagRegistrationEmail,
    TextFieldTagRegistrationPassword,
    TextFieldTagRegistrationConfirmPassword,
    TextFieldTagRegistrationName,
    TextFieldTagRegistrationSurname,
    TextFieldTagRegistrationCountry,
    TextFieldTagName,
    TextFieldTagSurname,
    TextFieldTagDateBirth,
    TextFieldTagNationality,
    TextFieldTagAddress1,
    TextFieldTagAddress2,
    TextFieldTagCity,
    TextFieldTagZip,
    TextFieldTagCoutry
} TextFieldTag;

#pragma mark - UserDefault Keys
#define KEY_LOGGED_IN @"login"
#define KEY_PROFILE @"profile"



#endif
