//
//  WATextField.m
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "WATextField.h"

#import "InterfaceUtil.h"
#import "StringUtil.h"

@implementation WATextField
-(id) initWithFrame:(CGRect)frame font:(UIFont*)font maxLength:(uint)maxLength color:(UIColor*)color background:(UIImage*)background clearsOnBeginEditing:(BOOL)clearsOnBeginEditing returnKeyType:(UIReturnKeyType)returnKeyType leftViewBorder:(int)leftViewBorder
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = font;
        self.textColor = color;
        self.background = background;
        self.clearsOnBeginEditing = clearsOnBeginEditing;
        self.returnKeyType = returnKeyType;
        
        if(leftViewBorder > 0) {
            self.leftViewMode = UITextFieldViewModeAlways;
            self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftViewBorder, frame.size.height)];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self defaultInit];
    }
    return self;
}

- (id) init
{
    if (self = [super init])
    {
        [self defaultInit];
    }
    
    return self;

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self defaultInit];
    }
    return self;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Utility
-(void) defaultInit
{
    // Initialization code
    [self drawTileBackground];
    
    self.clearsOnBeginEditing = NO;
    self.returnKeyType = UIReturnKeyDone;

}

-(void)drawTileBackground
{
    UIImage *tile = [UIImage imageNamed:@"BoxTile"];
    UIImage *tiledBackground = tileImage(tile, self.frame.size, 0.4);
    self.background = tiledBackground;
}

- (void) setPlaceholderWithText: (NSString*) strText font: (UIFont*) fontText color: (UIColor*) colorText
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:strText
                                                                       attributes:@{NSForegroundColorAttributeName: colorText,
                                                                                    NSFontAttributeName : fontText,}];

}

#pragma mark - Data Checker
-(void)createChecker:(TextFieldCheckerType)type data:(NSMutableArray*)data minLength:(int)minLength
{
    if(_checker) [self removeChecker];
    _checker = YES;
    self.checkerType = type;
    self.checkerData = data;
    self.checkerMinLength = minLength;
    self.checkerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    self.checkStatus = TextFieldCheckStatusChecking;
    [self addSubview:self.checkerView];
}

-(void)removeChecker
{
    if(!_checker) {
        _checker = NO;
        [self.checkerView removeFromSuperview];
        self.checkerView = nil;
    }
}

-(void)setCheckStatus:(TextFieldCheckStatus)checkStatus
{
    _checkStatus = checkStatus;
    UIColor *bgColor;
    
    switch (checkStatus) {
        case TextFieldCheckStatusChecking:
            bgColor = BLUECOLOR;
            break;
        case TextFieldCheckStatusError:
            bgColor = REDCOLOR;
            break;
        case TextFieldCheckStatusMatch:
            bgColor = GREENCOLOR;
            break;
        default:
            break;
    }
    self.checkerView.backgroundColor = bgColor;
}

-(void)check
{
    if(self.checkerType == TextFieldCheckerTypeDefault)
    {
        BOOL check = YES;
        if(self.checkerMinLength != 0 && self.text.length < self.checkerMinLength) check = NO;
        
        if(check) {
            self.checkStatus = TextFieldCheckStatusMatch;
        }
        else {
            self.checkStatus = TextFieldCheckStatusError;
        }
    }
    else if(self.checkerType == TextFieldCheckerTypeEmail) {
        BOOL check = stringIsMail(self.text);
        if(check) {
            self.checkStatus = TextFieldCheckStatusMatch;
        }
        else {
            self.checkStatus = TextFieldCheckStatusError;
        }
    }
}




@end
