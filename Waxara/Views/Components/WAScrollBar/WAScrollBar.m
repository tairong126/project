//
//  WAScrollBar.m
//  Waxara
//
//  Created by Passion on 6/22/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "WAScrollBar.h"

@interface WAScrollBar ()

@end

@implementation WAScrollBar

@synthesize delegate;
#pragma mark - View Life Cycle

+ (WAScrollBar*) scrollBarWithFrame: (CGRect) rectScrollBar
{
    return [[WAScrollBar alloc] initWithFrame:rectScrollBar];
}

- (id) initWithFrame: (CGRect) rectScrollBar
{
    self = [super initWithNibName:@"WAScrollBar" bundle:[NSBundle mainBundle]];
    
    if (self) {
        self.view.frame = rectScrollBar;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.bScrollStart = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Initialize
    
}

#pragma mark - Get and Set
- (void) setFRatio:(float)fRatio
{
    _fRatio = fRatio;
    
    float fYPos = (self.viewInner.frame.size.height - self.ivScroll.frame.size.height) * fRatio;
    
    self.ivScroll.frame = CGRectMake(self.ivScroll.frame.origin.x, fYPos, self.ivScroll.frame.size.width, self.ivScroll.frame.size.height);
    
}



#pragma mark - Touch Events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    NSLog(@"Scroll touch began");
    
    
    CGPoint posTouchBegan = [touch locationInView:self.viewInner];
    
    if (CGRectContainsPoint(self.ivScroll.frame, posTouchBegan))
    {
        self.bScrollStart = YES;
        self.pointTouch = posTouchBegan;
    }
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.bScrollStart)
    {
        return;
    }
    
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint touchMoved = [touch locationInView:self.view];
    
    // delta x, y
    float dy = touchMoved.y - self.pointTouch.y;

    self.pointTouch = touchMoved;
    
    float fOriginY = self.ivScroll.frame.origin.y + dy;
    
    if (fOriginY < 0)
    {
        fOriginY = 0;
    }
    else if (fOriginY > self.viewInner.frame.size.height - self.ivScroll.frame.size.height)
    {
        fOriginY = self.viewInner.frame.size.height - self.ivScroll.frame.size.height;
    }
    
    //move scroll bar
    self.ivScroll.frame = CGRectMake(self.ivScroll.frame.origin.x, fOriginY, self.ivScroll.frame.size.width, self.ivScroll.frame.size.height);
    
    float fRatio = fOriginY / (self.viewInner.frame.size.height - self.ivScroll.frame.size.height);
    
    if([delegate respondsToSelector:@selector(scrollBarDidScroll:toRatio:)])
    {
        [delegate scrollBarDidScroll:self toRatio:fRatio];
    }

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    self.bScrollStart = NO;

}


@end
