//
//  AsynchronousImageViewExt.m
//  MiLifeMap
//
//  Created by Jameel Khan on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsynchronousImageViewExt.h"



#define TICK_IMAGE      @"tick.png"
#define BORDER_IMAGE    @"icon_size.png"
#define WIDTH   10
#define HEIGHT  10



@implementation AsynchronousImageView (Extension) 



-(void)showTick{
    
    UIImageView *tickImageView= [[[UIImageView alloc] initWithImage:[UIImage imageNamed:TICK_IMAGE]] autorelease];
    tickImageView.frame= CGRectMake(self.bounds.size.width-WIDTH, 0, WIDTH, HEIGHT);
    tickImageView.contentMode= UIViewContentModeScaleAspectFit;
    tickImageView.tag= 222;
    [self addSubview:tickImageView];
    
    
}
-(void)hideTick{
    
    UIImageView *tickImageView= (UIImageView *)[self viewWithTag:222];
    [tickImageView removeFromSuperview];
    
}

-(void)addBorder{
    
    UIImageView *boderImageView= [[[UIImageView alloc] initWithImage:[UIImage imageNamed:BORDER_IMAGE]] autorelease];
    boderImageView.frame= self.bounds;
    boderImageView.contentMode= UIViewContentModeScaleToFill;
    boderImageView.tag= 223;
    [self addSubview:boderImageView];
    
    
}

@end
