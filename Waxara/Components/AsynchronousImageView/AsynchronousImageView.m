//
//  AsynchronousImageView.m
//  GLOSS
//
//  Created by Jameel Khan on 9/30/11
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsynchronousImageView.h"
#import "UIImageCache.h"
#define _BORDER_GAP 15




@interface AsynchronousImageView()
    


-(void)showSpinner;
-(void)hiderSpinner;
    
@property (nonatomic, retain) UIImageView *innerImageView;    
@end




@implementation AsynchronousImageView
@synthesize delegate=_delegate;
@synthesize innerImageView=_innerImageView;
@synthesize image=_image;
@synthesize originalUrlString;
@synthesize ContentMode;
@synthesize defaultImage;


- (void)loadImageFromURLString:(NSString *)theUrlString
{
    self.originalUrlString=theUrlString;
    
    self.image= [UIImageCache getCachedImage:theUrlString];    
    if(self.image){
        //[self.image release], self.image = nil;
        [self hiderSpinner];
        return ;
    }
    
    
    
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:theUrlString] 
											 cachePolicy:NSURLRequestReloadIgnoringCacheData 
										 timeoutInterval:30.0];
	
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self showSpinner];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{
    
    
    NSString *directedUrl= [[request URL] description];

    //if this is a final facebook URL
    if([directedUrl hasSuffix:@"_q.jpg"]){
        
        NSString *cutUrl= [directedUrl substringToIndex:directedUrl.length -6];
        NSString *newUrl= [NSString stringWithFormat:@"%@%@",cutUrl, @"_o.jpg"];
        
        //hijack the redirection
        request= [NSURLRequest requestWithURL:[NSURL URLWithString:newUrl]];
        
    }
    
    
    return request;
}



- (void)connection:(NSURLConnection *)theConnection  didReceiveData:(NSData *)incrementalData 
{
    if (data == nil)
        data = [[NSMutableData alloc] initWithCapacity:2048];
	
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection 
{
    self.image = [UIImage imageWithData:data];
 
    
    /*if image NOT loeaded load default*/
    if(self.image){
        [UIImageCache cacheImage: self.originalUrlString   image: self.image];
    }
    else{
        
        self.image= self.defaultImage;
    }
    
    [data release], data = nil;
	[connection release], connection = nil;
    
    [self hiderSpinner];
   
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(self.image && [self.delegate respondsToSelector:@selector(asychronousImageViewTapped:)]){
        
        [self.delegate asychronousImageViewTapped:self];
    }
    
}





-(void)showSpinner{
    
    
    
    //set up indicators
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    UIActivityIndicatorView *spinner= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    spinner.tag= 111;
    [spinner startAnimating];
    [self addSubview:spinner];

}
-(void)hiderSpinner{
    
   
    
    //set up indicators
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UIActivityIndicatorView *spinner=  (UIActivityIndicatorView *)[self viewWithTag:111];
    if([spinner isKindOfClass:[UIActivityIndicatorView class]]){
    
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        
        
    }
    
    
    
    if(!_innerImageView){
        
        self.innerImageView= [[[UIImageView alloc] initWithImage:self.image] autorelease];
        self.innerImageView.frame= CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        self.innerImageView.contentMode= self.ContentMode;
        [self.innerImageView setClipsToBounds:YES];
        [self addSubview:self.innerImageView];
    }

    
}


- (void)dealloc {
    [_innerImageView release];
    [_delegate release];
	[data release];
    [connection cancel];
	[connection release];
    [super dealloc];
}

@end