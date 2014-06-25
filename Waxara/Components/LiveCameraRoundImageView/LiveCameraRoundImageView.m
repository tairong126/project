//
//  LiveCameraRoundImageView.m
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "LiveCameraRoundImageView.h"

@implementation LiveCameraRoundImageView

#pragma mark - View Life Cycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self initCameraView];
    }
    return self;
}

- (id) init
{
    if (self = [super init])
    {
        [self initCameraView];
    }
    
    return self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self initCameraView];
    }
    return self;
    
}

#pragma mark - UI Init
- (void) initCameraView
{
    //Make round image view
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat radius = self.layer.bounds.size.width / 2;
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.userInteractionEnabled=YES;
    
    //Init Captured Image View
    self.imageViewCaptured = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    
    self.imageViewCaptured.backgroundColor = [UIColor clearColor];
    self.imageViewCaptured.contentMode = UIViewContentModeScaleToFill;
    
    //Add captured image view
    [self addSubview:self.imageViewCaptured];
    
    [self setCaptureViewTransform];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void) setCaptureViewTransform
{
    UIDevice *currentDevice = [UIDevice currentDevice];
    if ([currentDevice.model rangeOfString:@"Simulator"].location != NSNotFound)
    {
        // running in Simulator
        
        return;
    }
    
    
    //adjust image orientation based on device orientation
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft)
    {
        NSLog(@"landscape left image");
        
        self.transform = CGAffineTransformMakeRotation(DegreesToRadians(-90));
        
    }
    
    if (deviceOrientation == UIDeviceOrientationFaceUp)
    {
        NSLog(@"Faceup image");
        
        self.transform = CGAffineTransformMakeRotation(DegreesToRadians(-90));
    }
    
    if (deviceOrientation == UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"landscape right");
        
        self.transform = CGAffineTransformMakeRotation(DegreesToRadians(90));
        
    }
    
    if (deviceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        NSLog(@"upside down");
        self.transform = CGAffineTransformMakeRotation(DegreesToRadians(180));
        
    }
    
    if (deviceOrientation == UIDeviceOrientationPortrait)
    {
        NSLog(@"upside upright");
        self.transform = CGAffineTransformMakeRotation(DegreesToRadians(0));
    }

}

#pragma mark - Utility
- (void) setImage: (UIImage*) image
{
    self.imageViewCaptured.image = image;
}

- (UIImage*) getImage
{
    return self.imageViewCaptured.image;
}



#pragma mark - Streaming Utility
- (void) startLiveStreaming
{
    if (self.bStreaming || self.bCaptured)
    {
        return;
    }
    
    
    
    self.bStreaming = YES;
    
    self.sessionStreaming = [[AVCaptureSession alloc] init];
	self.sessionStreaming.sessionPreset = AVCaptureSessionPresetPhoto;
    
	AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.sessionStreaming];
    [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
	captureVideoPreviewLayer.frame = self.bounds;
	[self.layer addSublayer:captureVideoPreviewLayer];
    
    UIView *view = self;
    CALayer *viewLayer = [view layer];
    [viewLayer setMasksToBounds:YES];
    
    CGRect bounds = [view bounds];
    [captureVideoPreviewLayer setFrame:bounds];
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *frontCamera = nil;
    AVCaptureDevice *backCamera = nil;
    
    for (AVCaptureDevice *device in devices)
    {
        NSLog(@"Device name: %@", [device localizedName]);
        if ([device position] == AVCaptureDevicePositionBack)
        {
            NSLog(@"Device position : back");
            backCamera = device;
        }
        else
        {
            NSLog(@"Device position : front");
            frontCamera = device;
        }
    }
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:frontCamera error:&error];
    if (!input) {
        NSLog(@"ERROR: trying to open camera: %@", error);
    }
    
    if (input)
    {
        [self.sessionStreaming addInput:input];

        self.outputStillImage = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [self.outputStillImage setOutputSettings:outputSettings];
        
        [self.sessionStreaming addOutput:self.outputStillImage];
        
        [self.sessionStreaming startRunning];
    }
    else
    {
        self.imageViewCaptured.image = [UIImage imageNamed:@"Profile Photo"];
        self.bCaptured = YES;
        self.bStreaming = NO;
    }
    
    
}

- (void) stopLiveStreaming
{
    if (!self.bStreaming)
    {
        return;
    }
    
    self.bStreaming = NO;
    
    [self.sessionStreaming stopRunning];
}

- (void) captureLiveCamera
{
    if (self.bCaptured)
    {
        return;
    }
    
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.outputStillImage.connections) {
        
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        
        if (videoConnection) {
            break;
        }
    }
    
    
    
    NSLog(@"about to request a capture from: %@", self.outputStillImage);
    
    
    [self.outputStillImage captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        if (imageSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            
            [self stopLiveStreaming];
            
            [self processImage:[UIImage imageWithData:imageData]];
            

            
            self.bCaptured = YES;
        }
    }];
    


}


- (void) processImage:(UIImage *)image
{ //process captured image, crop, resize and rotate
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    { //Device is ipad
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(768, 1022));
        [image drawInRect: CGRectMake(0, 0, 768, 1022)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGRect cropRect = CGRectMake(0, 130, 768, 768);
        CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        //or use the UIImage wherever you like
        
        UIImage* flippedImage = [UIImage imageWithCGImage:imageRef];
        
        if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight))
        {
            flippedImage = [self imageRotatedByDegrees:90 image:flippedImage];
        }

        
        [self.imageViewCaptured setImage:flippedImage];

        CGImageRelease(imageRef);
        
    }
    else
    { //Device is iphone
        // Resize image
        NSLog(@"image size: %f * %f", image.size.width, image.size.height);
        
        CGFloat scale = image.size.width / [[UIScreen mainScreen] bounds].size.width;
        
        CGFloat newWidth = image.size.width / scale;
        CGFloat newHeight = image.size.height / scale;
        
        NSLog(@"new image size: %f * %f", newWidth, newHeight);
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
        [image drawInRect: CGRectMake(0, 0, newWidth, newHeight)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGFloat nImageWidth = (newHeight > newWidth) ? newWidth: newHeight;
        
        CGRect cropRect = CGRectMake((newWidth - nImageWidth) / 2.0f, (newHeight - nImageWidth) / 2.0f, nImageWidth, nImageWidth);

        CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        
        UIImage* flippedImage = [UIImage imageWithCGImage:[[UIImage imageWithCGImage:imageRef] CGImage]
                                                    scale:[UIImage imageWithCGImage:imageRef].scale orientation: UIImageOrientationUpMirrored];
        
        if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight))
        {
            flippedImage = [self imageRotatedByDegrees:90 image:flippedImage];
        }
        
        [self.imageViewCaptured setImage:flippedImage];
        
        CGImageRelease(imageRef);
    }
    
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees image: (UIImage*) image
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

@end
