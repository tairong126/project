//
//  SearchCommand.h
//  Grid
//
//  Created by Dmitry Kozlov on 12/05/14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchCommand : NSObject
@property NSString *text;
@property int page;
@property int start;
@property int length;
@property BOOL valid;
@property int index;


@end
