//
//  LiveCameraRoundImageView.h
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define DegreesToRadians(x) ((x) * M_PI / 180.0f)

@interface LiveCameraRoundImageView : UIView


@property (nonatomic, strong) UIImageView* imageViewCaptured;
@property (nonatomic, retain) AVCaptureStillImageOutput* outputStillImage;
@property (nonatomic, retain) AVCaptureSession *sessionStreaming;


@property (nonatomic) BOOL bStreaming;
@property (nonatomic) BOOL bCaptured;

//Return captured uiimage
- (void) captureLiveCamera;

- (void) setImage: (UIImage*) image;
- (UIImage*) getImage;

//Start and Stop streaming
- (void) startLiveStreaming;
- (void) stopLiveStreaming;

- (void) setCaptureViewTransform;

@end
