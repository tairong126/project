//
//  WATextField.h
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    TextFieldCheckerTypeDefault,
    TextFieldCheckerTypeEmail,
} TextFieldCheckerType;

typedef enum
{
    TextFieldCheckStatusChecking,
    TextFieldCheckStatusMatch,
    TextFieldCheckStatusError,
} TextFieldCheckStatus;

@interface WATextField : UITextField

@property (nonatomic) uint maxLength;
@property (readonly) BOOL checker; // DEFAULT NO
@property int checkerMinLength;


@property WATextField *textFieldNext;
@property (nonatomic) UIView *checkerView;

@property (nonatomic) TextFieldCheckStatus checkStatus; // DEFAULT CHECKING
@property TextFieldCheckerType checkerType;

@property NSMutableArray *checkerData;

//Initialization
-(id) initWithFrame:(CGRect)frame font:(UIFont*)font maxLength:(uint)maxLength color:(UIColor*)color background:(UIImage*)background clearsOnBeginEditing:(BOOL)clearsOnBeginEditing returnKeyType:(UIReturnKeyType)returnKeyType leftViewBorder:(int)leftViewBorder;

//Utils
- (void) setPlaceholderWithText: (NSString*) strText font: (UIFont*) fontText color: (UIColor*) colorText;

-(void)drawTileBackground;

//TextField Input Data Checker
-(void)createChecker:(TextFieldCheckerType)type data:(NSMutableArray*)data minLength:(int)minLength;
-(void)removeChecker;
-(void)check;



@end
