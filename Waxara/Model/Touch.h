//
//  Touch.h
//  Grid
//
//  Created by LinO_dska on 22.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Core;
@class BoxView;
@class TableView;
@class Graph;
@interface Touch : NSObject
@property UITouch *owner;
@property float px;
@property float py;
@property Core *selectedCore;
@property int coreValue;
@property BoxView *selectedBox;
@property BOOL removeCore;
@property TableView *selectedTableView;
@property Graph *selectedGraph;
@end
