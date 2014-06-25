//
//  SearchView.h
//  Waxara
//
//  Created by Passion on 6/18/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    searchPageCommands = 0,

} SearchPage;


@class SearchCommand;

@interface SearchView : UIView

// Data
@property BOOL opened;
@property int lines;
@property (nonatomic, strong) UIViewController *vcSuper;

//Views
@property UIView *viewLabels;
@property UITextField *tfSearch;
@property NSArray *arrLabels;

//Data array
@property (nonatomic, strong) NSMutableArray *allData;
@property NSMutableArray *data;
@property (nonatomic) int page;
@property NSMutableArray *sortedData;


@property SearchCommand *currentCommand;
@property NSMutableArray *commands;

@property NSString *prevString;

@property (nonatomic) BOOL search;
@property int highlightedRange;
@property BOOL commandError;
@property int commandsRange;

//Initialize
-(id)initWithFrame:(CGRect)frame background:(UIImage*)background data:(NSMutableArray*)data labels:(int)labels owner:(UIViewController*)owner;
-(void) setWithFrame:(CGRect)frame background:(UIImage*)background nShowCnt:(int)nShowCnt;

#pragma mark - Touch Event
-(BOOL)touchDown:(CGPoint)pos;

#pragma mark - Utility
-(BOOL)checkTextField:(UITextField*)textField;
-(void)returnClick;
-(void)searchFor:(NSString*)text;


@end
