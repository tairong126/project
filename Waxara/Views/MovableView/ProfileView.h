//
//  ProfileView.h
//  Grid
//
//  Created by LinO_dska on 21.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProgressBar;
@class CircularUIImageView;
@class Core;
@class Profile;
@class VoiceMeterView;
@interface ProfileView : NSObject
@property UIImageView *image;
@property UILabel *name;
@property UILabel *post;
@property UILabel *performance;
@property ProgressBar *performancePB;


-(id)initWithCore:(Core*)core profile:(Profile*)profile;

@end
