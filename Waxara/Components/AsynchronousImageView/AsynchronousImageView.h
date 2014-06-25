//
//  AsynchronousImageView.h
//  GLOSS
//
//  Created by Jameel Khan on 9/30/11
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



/*
 Need to add a default image
 
 */


@class AsynchronousImageView;
@protocol AsynchronousImageViewDelegate <NSObject>

-(void)asychronousImageViewTapped:(AsynchronousImageView *)imageView; 

@end


@interface AsynchronousImageView : UIView 
{
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *originalUrlString;
    UIViewContentMode contentMode;
    
}
@property (nonatomic, retain) id<AsynchronousImageViewDelegate> delegate;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *defaultImage;
@property (nonatomic, retain) NSString *originalUrlString;
@property (nonatomic) UIViewContentMode ContentMode;


- (void)loadImageFromURLString:(NSString *)theUrlString;

@end