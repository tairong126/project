//
//  ToolView.m
//  Grid
//
//  Created by Dmitry Kozlov on 08/05/14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "ToolView.h"
#import "Tool.h"
#import "Core.h"
#import "ProgressBar.h"
#import "InterfaceUtil.h"

@implementation ToolView
-(id)initWithCore:(Core*)core tool:(Tool*)tool {
    self = [super init];
    if(self) {
        UIColor *whiteColor = [UIColor whiteColor];
        UIColor *grayColor = [UIColor lightGrayColor];
        CGPoint center = CGPointMake(core.center, core.center);
        self.name = createLabel(rectToCenter(CGRectMake(0, 0, 200, 14), CGPointMake(center.x,center.y-30)), [UIFont fontWithName:@"HelveticaNeue" size:12], whiteColor, tool.name);
        self.percentage = createLabel(rectToCenter(CGRectMake(0, 0, 100, 54), center), [UIFont fontWithName:@"HelveticaNeue-Light" size:36], whiteColor, [NSString stringWithFormat:@"%d%%",tool.progress]);
        self.current = createLabel(CGRectMake(center.x-80, center.y+26, 80, 18), [UIFont fontWithName:@"HelveticaNeue" size:16], grayColor, [NSString stringWithFormat:@"%d",tool.current]);
        self.max = createLabel(CGRectMake(center.x, center.y+30, 80, 14), [UIFont fontWithName:@"HelveticaNeue" size:12], grayColor, [NSString stringWithFormat:@"/%d",tool.max]);
        
        self.name.textAlignment = NSTextAlignmentCenter;
        self.percentage.textAlignment = NSTextAlignmentCenter;
        self.current.textAlignment = NSTextAlignmentRight;
        self.max.textAlignment = NSTextAlignmentLeft;
        
        self.progressBar = [[ProgressBar alloc]initWithFrame:rectToCenter(CGRectMake(0, 0, 170, 170), center) type:1 width:5 color:[UIColor whiteColor] bgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2f] strokeColor:nil];
        self.progressBar.value = (float)tool.progress/100.0f;
        
        [core.view addSubview:self.name];
        [core.view addSubview:self.percentage];
        [core.view addSubview:self.current];
        [core.view addSubview:self.max];
        [core.view addSubview:self.progressBar];
    }
    return self;
}
@end
