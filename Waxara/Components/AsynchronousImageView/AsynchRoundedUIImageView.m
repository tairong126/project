//
//  RoundedUIImageView.m
//  WinSomeThing
//
//  Created by Jameel Khan on 14/11/2012.
//  Copyright (c) 2012 Mobile Media Partners. All rights reserved.
//

#import "AsynchRoundedUIImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageCache.h"



@interface AsynchRoundedUIImageView()


@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSString *originalUrlString;
@property (nonatomic)         BOOL alreadyLoading;




-(void)showSpinner;
-(void)hiderSpinner;


@end


@implementation AsynchRoundedUIImageView
@synthesize connection;
@synthesize data;
@synthesize originalUrlString;
@synthesize delegate;
@synthesize makeBlurred;



-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
    }
    return self;
}

- (void)updateCornerRadius:(int)radius{
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.userInteractionEnabled=YES;
    
}

- (void)loadImageFromURLString:(NSString *)theUrlString
{

    
    if((self.alreadyLoading==YES) && [theUrlString isEqualToString:self.originalUrlString])
        return;

    [self resetImageView];

    self.originalUrlString=theUrlString;
    
    if(self.image)
    {
        self.image = nil;
    }
    
    self.image= [UIImageCache getCachedImage:self.originalUrlString];
    
    if(self.image){
        [self hiderSpinner];
        return ;
    }
    
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.originalUrlString]
											 cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
										 timeoutInterval:30.0];
	
	self.connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [self showSpinner];
}

- (void)loadImageFromURLStringNoCache:(NSString *)theUrlString{
    
    if((self.alreadyLoading==YES) && [theUrlString isEqualToString:self.originalUrlString])
        return;
    
    [self resetImageView];
    
    self.originalUrlString=theUrlString;
    
    if(self.image)
    {
        self.image = nil;
    }
    
   // self.image= [UIImageCache getCachedImage:self.originalUrlString];
    
    if(self.image){
        [self hiderSpinner];
        return ;
    }
    
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.originalUrlString]
											 cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
										 timeoutInterval:30.0];
	
	self.connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [self showSpinner];
    
}

- (void)connection:(NSURLConnection *)theConnection
	didReceiveData:(NSData *)incrementalData
{
    if (self.data == nil)
        self.data = [[[NSMutableData alloc] initWithCapacity:2048] autorelease];
	
    [self.data appendData:incrementalData];
 
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    
    self.image = [UIImage imageWithData:data];
    
    [UIImageCache cacheImage: self.originalUrlString   image: self.image];
    
    [data release], data = nil;
	[connection release], connection = nil;
    
    [self hiderSpinner];
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self hiderSpinner];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if([self.delegate respondsToSelector:@selector(asynchRoundedUIImageViewTapped:)]){
        
        [self.delegate asynchRoundedUIImageViewTapped:self];
    }
    
}


-(void)showSpinner{
    
    self.alreadyLoading=YES;
    
    //set up indicators
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    UIActivityIndicatorView *spinner= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    spinner.tag= 111;
    [spinner startAnimating];
    [self addSubview:spinner];
    [spinner release];
    
}
-(void)hiderSpinner{

    
    //set up indicators
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UIActivityIndicatorView *spinner=  (UIActivityIndicatorView *)[self viewWithTag:111];
    if([spinner isKindOfClass:[UIActivityIndicatorView class]]){
        
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        
    }
    
    self.alreadyLoading=NO;
    
    if(makeBlurred){
//        self.image= [self.image imageWithGaussianBlur:10.0f];
    }
    
}

- (void)resetImageView
{
    [[self viewWithTag:111] removeFromSuperview];
    self.image = nil;
    [data release];
    data=nil;
    [connection cancel];
    [connection release];
    connection=nil;

}


- (void)dealloc {

    [delegate release];
	[data release];
    [connection cancel];
	[connection release];
    [super dealloc];
}

@end
