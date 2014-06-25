//
//  WAScrollBar.h
//  Waxara
//
//  Created by Passion on 6/22/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WAScrollBarDelegate;

@interface WAScrollBar : UIViewController<UIScrollViewDelegate>

#pragma mark - Sub Views
@property (weak, nonatomic) IBOutlet UIView *viewInner;
@property (weak, nonatomic) IBOutlet UIImageView *ivScroll;

#pragma mark - property
@property (nonatomic) int tag;

#pragma mark - delegate
@property(nonatomic,weak)id <WAScrollBarDelegate> delegate;

#pragma mark - Scroll Event
@property BOOL bScrollStart;
@property CGPoint pointTouch;

@property (nonatomic) float fRatio;

+ (WAScrollBar*) scrollBarWithFrame: (CGRect) rectScrollBar;
- (id) initWithFrame: (CGRect) rectScrollBar;

@end

@protocol WAScrollBarDelegate <NSObject>

@optional

-(void) scrollBarDidScroll: (WAScrollBar*) scrollBar toRatio: (float) fRatio;


@end




