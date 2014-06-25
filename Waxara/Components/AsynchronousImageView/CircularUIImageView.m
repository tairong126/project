//
//  RoundedUIImageView.m
//  WinSomeThing
//
//  Created by Jameel Khan on 14/11/2012.
//  Copyright (c) 2012 Mobile Media Partners. All rights reserved.
//

#import "CircularUIImageView.h"


@implementation CircularUIImageView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    CGFloat radius = self.layer.bounds.size.width / 2;
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.userInteractionEnabled=YES;
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        CGFloat radius = self.layer.bounds.size.width / 2;
        
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled=YES;
        
        
        
    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (self) {
        
        CGFloat radius = self.layer.bounds.size.width / 2;
        
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled=YES;
        
        
        
    }

}

@end
