//
//  ToolView.h
//  Grid
//
//  Created by Dmitry Kozlov on 08/05/14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProgressBar;
@class Core;
@class Tool;
@interface ToolView : NSObject
@property UILabel *name;
@property UILabel *percentage;
@property ProgressBar *progressBar;
@property UILabel *current;
@property UILabel *max;
-(id)initWithCore:(Core*)core tool:(Tool*)tool;
@end
