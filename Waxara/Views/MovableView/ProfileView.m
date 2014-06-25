//
//  ProfileView.m
//  Grid
//
//  Created by LinO_dska on 21.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "ProfileView.h"
#import "Profile.h"
#import "Core.h"
#import "InterfaceUtil.h"
#import "VoiceMeterView.h"
#import "ProgressBar.h"
#import "CircularUIImageView.h"

@implementation ProfileView
-(id)initWithCore:(Core*)core profile:(Profile*)profile {
    self = [super init];
    if(self) {
        UIFont *hn_l13 =[UIFont fontWithName:@"HelveticaNeue-Light" size:13];
        UIFont *hn_b17 =[UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        UIColor *whiteColor = [UIColor whiteColor];
        
        CGPoint center = CGPointMake(core.center, core.center);
        self.image = [[CircularUIImageView alloc]initWithImage:profile.image];
        self.image.frame = rectToCenter(self.image.frame, center);
        self.name = createLabel(CGRectMake(center.x+110, center.y-75, 100, 20), hn_b17, whiteColor, [NSString stringWithFormat:@"%@ %@",profile.name,profile.surname]);
        self.post = createLabel(CGRectMake(center.x+110, center.y-50, 100, 20), hn_l13, whiteColor, profile.position);
        self.performance = createLabel(CGRectMake(center.x+110, center.y+23, 150, 20), hn_l13, whiteColor, [NSString stringWithFormat:@"%d%% PERFORMANCE",profile.tot]);
        self.performancePB = [[ProgressBar alloc]initWithFrame:rectToCenter(CGRectMake(0, 0, 180, 180), center) type:1 width:6 color:[UIColor whiteColor] bgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2f] strokeColor:nil];
        self.performancePB.value = (float)profile.tot/100.0f;
        
        [core.view addSubview:self.performancePB];
        [core.view addSubview:self.image];
        [core.view addSubview:self.name];
        [core.view addSubview:self.post];
        [core.view addSubview:self.performance];
        
        
    }
    return self;
}


@end
