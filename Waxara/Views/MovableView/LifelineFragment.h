//
//  LifelineFragment.h
//  Grid
//
//  Created by LinO_dska on 16.06.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    LifelineFragmentTypeEducation,
    LifelineFragmentTypeWork,
} LifelineFragmentType;
@interface LifelineFragment : NSObject
@property LifelineFragmentType type;

@property NSString *name;
@property NSString *position;
@property NSString *personToVerify;

@property int startYear;
@property int startMonth;
@property int endYear;
@property int endMonth;
@end
