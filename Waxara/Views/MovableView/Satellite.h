//
//  Satellite.h
//  Grid
//
//  Created by LinO_dska on 16.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ORBIT 130.0f
#define ICONWIDTH 22
#define ICONHEIGHT 1
#define ICONSIZE 50
#define ICONREALSIZE 22
#define ORBITSIZE 264

typedef enum {
    satTimerIconAnimation,
} satTimer;
typedef enum {
    satIconNothing = -1,
    satIconSecurity,
    satIconProfile,
    satIconContacts,
    satIconMessages,
    satIconProducts,
    satIconMore,
    satIconTeam,
    satIconConfirm,
    satIconCall,
    satIconLocation,
    satIconQuestionnaire,
    satIconSettings,
    satIconMail,
    satIconTask,
    satIconConnect,
    satIconSearch,
    satIconInfo,
    satIconList, //!!!!
    satIconPayment, //!!!
    satIconTools, //!!!!!!!
    satIconStats,
    satIconInvestments,
    satIconEdit,
    satIconTrash,
    satIconAdd,
    satIconGrid
} satButtonType;
typedef enum {
    satIconTypeDefault = 0,
    satIconTypeOpened,
    satIconTypeNotification,
    satIconTypeRed,
} satIconType;

@interface Satellite : NSObject

@property NSArray *icons;

@property UIView *view;
@property UIImageView *button;
@property UIImageView *buttonCache;
@property (nonatomic) BOOL animation;
@property int icon;
@property (nonatomic) int type;
@property (nonatomic) int angle;
@property (readonly) float orbit;
@property (nonatomic) CGPoint position;
@property (nonatomic) CGPoint center;
@property BOOL active;
@property NSTimer *timer;
@property int ticks;
@property satTimer animationType;
-(id)initWithAngle:(float)angle position:(CGPoint)position center:(CGPoint)center icons:(NSArray*)icons icon:(int)icon;
-(BOOL)touchDown:(CGPoint)pos;
@end
