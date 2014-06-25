//
//  Core.h
//  Grid
//
//  Created by LinO_dska on 16.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoxView.h"

#define TASKMAXLETTERS 140

@class MainMotherVC;
@class Line;
@class LineArm;
@class ProgressBar;
@class Profile;
@class ProfileView;
@class Company;
@class CompanyView;
@class Tool;
@class ToolView;

@class CallView;


@interface Core : NSObject

//button notifications
@property (nonatomic) int angle;

@property (nonatomic) CGPoint position;
@property CGPoint cachePos;
@property (nonatomic) BOOL show;

@property (readonly) int size;
@property (readonly) int center;
@property (readonly) float orbitSize;

@property NSArray *icons;

@property Profile *profile;
@property ProfileView *profileView;
@property Company *company;
@property CompanyView *companyView;
@property Tool *tool;
@property ToolView *toolView;

//DATA PART
@property NSMutableArray *satellites;

//VIEW PART
@property UIView *view;
@property UIImageView *orbit;

//task
@property (nonatomic) BOOL showTaskTextField;
@property (nonatomic) int taskLetters;
@property UITextField *taskTextField;
@property UILabel *taskLettersCounter;
@property UILabel *taskLabel;

//stats
@property LineArm *infoBoxLineArm;
@property (nonatomic) BOOL showInfoBox;
@property BoxView *infoBox;
@property ProgressBar *infoTotProgress;
@property UILabel *infoTotLabel;
@property UILabel *infoTotNumber;
@property ProgressBar *infoPerfProgress;
@property UILabel *infoPerfLabel;
@property UILabel *infoPerfNumber;

@property CallView *callView;

@property MainMotherVC *owner;

//UNUSIBLE
// moving
@property (nonatomic) BOOL randomMoving;
@property float vx;
@property float vy;
@property float speed;
@property int mtime;

// rotating
@property BOOL rotating;
@property int rspeed;
@property int rtime;

-(void)move;
-(void)moveTo:(CGPoint)point speed:(float)speed;

//Init
-(id)initWithIcons:(NSArray*)icons cVar:(int)var;
-(id)initWithCompany:(Company*)company  icons:(NSArray*)icons;
-(id)initWithProfile:(Profile*)profile  icons:(NSArray*)icons owner:(MainMotherVC*)owner;
-(id)initWithTool   :(Tool*)tool        icons:(NSArray*)icons;

-(int)touchDown:(CGPoint)pos;
-(void)remove;

@end