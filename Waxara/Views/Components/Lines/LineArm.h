//
//  LineArm.h
//  Grid
//
//  Created by LinO_dska on 02.06.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineArm : NSObject
@property BOOL active;
@property (nonatomic) CGPoint start;
@property (readonly) CGPoint middle;
@property (readonly) CGPoint middle2;
@property (readonly) CGPoint middle3;
@property (nonatomic) CGPoint end;
@property BOOL changed;
@end
