//
//  AppData.m
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "AppData.h"
#import "Constant.h"
#import "SearchData.h"

@implementation AppData

static AppData* sharedInstance;

+ (AppData*) sharedAppData
{
    if (sharedInstance == nil) {
        sharedInstance = [[AppData alloc] init];
    }
    
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self) {
        //Custom Initialization
        [self initSearchContent];
    }
    
    return self;
}

#pragma mark - initialize
- (void) initSearchContent
{
    self.arrSearchContent = [[NSMutableArray alloc] init];
    
    NSMutableArray* arrAspects = [[NSMutableArray alloc] initWithObjects:@"Search", @"Message", @"Open", @"Close", @"Call", @"Contract", @"Hire", @"Fire", @"Report", @"Department", @"Company", @"Tool", @"Stop", @"Pay", @"Log Off", nil];
    
    NSMutableArray* subAspects = [[NSMutableArray alloc] initWithObjects:@"Sales",@"Marketing",@"HR",@"Stock & Supply",@"Budgeting",@"Financial",@"Legal",@"Logistics", nil];
    
    for (int i = 0; i < arrAspects.count; i++)
    {
        SearchData* data = [[SearchData alloc] init];
        
        data.searchAspect = [arrAspects objectAtIndex:i];
        data.arrSubData = subAspects;
        
        [self.arrSearchContent addObject:data];
    }
    
}

#pragma mark - Utility
- (void) saveAppSetting
{
    [[NSUserDefaults standardUserDefaults] setBool:[AppData sharedAppData].bLoggedIn forKey:KEY_LOGGED_IN];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
