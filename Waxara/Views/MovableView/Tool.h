//
//  Tool.h
//  Grid
//
//  Created by Dmitry Kozlov on 08/05/14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject
@property NSString *name;
@property int progress;
@property int current;
@property int max;
@end
