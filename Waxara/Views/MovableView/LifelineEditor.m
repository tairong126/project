//
//  LifelineEditor.m
//  Grid
//
//  Created by LinO_dska on 16.06.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import "LifelineEditor.h"
#import "LifelineFragment.h"
#import "Profile.h"
#import "InterfaceUtil.h"
#import "Satellite.h"
#define TOPBUTTONX 80
#define TOPBUTTONWIDTH 120
#define TOPBUTTONHEIGHT 40
#define BUTTONOFFSET 50
#define YEAROFFSET 200.0

@implementation LifelineEditor

- (instancetype)initWithFrame:(CGRect)frame profile:(Profile*)profile icons:(NSArray*)icons
{
    self = [super initWithFrame:frame];
    if (self) {
        self.icons = icons;
        self.profile = profile;
        
        
        UIColor *whiteColor = [UIColor whiteColor];
        UIFont *topButtonFont = [UIFont fontWithName:@"HelveticaNeue" size:14];
        
        self.lifeLineLabel = createLabel(CGRectMake(TOPBUTTONX, 0, TOPBUTTONWIDTH, TOPBUTTONHEIGHT), topButtonFont, whiteColor, @"LIFELINE");
        self.lifeLineLabel.layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1].CGColor;
        self.lifeLineLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lifeLineLabel];
        
        self.expListLabel = createLabel(CGRectMake(TOPBUTTONX+TOPBUTTONWIDTH, 0, TOPBUTTONWIDTH, TOPBUTTONHEIGHT), topButtonFont, whiteColor, @"EXP. LIST");
        self.expListLabel.textAlignment = NSTextAlignmentCenter;
        self.expListLabel.alpha = 0.5f;
        self.expListLabel.tag = 0;
        [self addSubview:self.expListLabel];
        
        UIView *guideLine = [[UIView alloc]initWithFrame:CGRectMake(0, TOPBUTTONHEIGHT + 2, frame.size.width, 1.0)];
        guideLine.backgroundColor = BLUECOLOR;
        [self addSubview:guideLine];
        
        self.buttonAdd = [[UIImageView alloc]initWithImage:[[icons objectAtIndex:satIconAdd] objectAtIndex:satIconTypeDefault]];
        self.buttonAdd.frame = CGRectOffset(self.buttonAdd.frame, TOPBUTTONX, TOPBUTTONHEIGHT + 20);
        [self addSubview:self.buttonAdd];
        self.buttonAddCache = [[UIImageView alloc]initWithImage:[[icons objectAtIndex:satIconAdd] objectAtIndex:satIconTypeOpened]];
        self.buttonAddCache.frame = self.buttonAdd.frame;
        self.buttonAddCache.alpha = 0;
        [self addSubview:self.buttonAddCache];
        
        self.buttonEdit = [[UIImageView alloc]initWithImage:[[icons objectAtIndex:satIconEdit] objectAtIndex:satIconTypeDefault]];
        self.buttonEdit.frame = CGRectOffset(self.buttonEdit.frame, TOPBUTTONX+BUTTONOFFSET, TOPBUTTONHEIGHT + 20);
        [self addSubview:self.buttonEdit];
        self.buttonEditCache = [[UIImageView alloc]initWithImage:[[icons objectAtIndex:satIconEdit] objectAtIndex:satIconTypeOpened]];
        self.buttonEditCache.frame = self.buttonEdit.frame;
        self.buttonEditCache.alpha = 0;
        [self addSubview:self.buttonEditCache];
        
        self.buttonTrash = [[UIImageView alloc]initWithImage:[[icons objectAtIndex:satIconTrash] objectAtIndex:satIconTypeDefault]];
        self.buttonTrash.frame = CGRectOffset(self.buttonTrash.frame, TOPBUTTONX+BUTTONOFFSET+BUTTONOFFSET, TOPBUTTONHEIGHT + 20);
        [self addSubview:self.buttonTrash];
        self.buttonTrashCache = [[UIImageView alloc]initWithImage:[[icons objectAtIndex:satIconTrash] objectAtIndex:satIconTypeOpened]];
        self.buttonTrashCache.frame = self.buttonTrash.frame;
        self.buttonTrashCache.alpha = 0;
        [self addSubview:self.buttonTrashCache];
        
        self.lifelineScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, frame.size.width, 50)];
        self.lifelineScrollView.contentSize = CGSizeMake(YEAROFFSET*100, 50);
        self.lifelineScrollView.contentOffset = CGPointMake(YEAROFFSET*100 - self.lifelineScrollView.frame.size.width,0);
        self.lifelineScrollView.bounces = NO;
        self.lifelineScrollView.showsHorizontalScrollIndicator = NO;
        self.lifelineScrollView.showsVerticalScrollIndicator = YES;
        UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerTapOnLifeline:)];
        twoFingerTap.numberOfTouchesRequired = 2;
        [self.lifelineScrollView addGestureRecognizer:twoFingerTap];
        
        [self addSubview:self.lifelineScrollView];
        
        LifelineFragment *fragment = [LifelineFragment new];
        fragment.type = LifelineFragmentTypeEducation;
        fragment.name = @"Some school";
        fragment.position = @"Mathematic";
        fragment.personToVerify = @"Bruce Li";
        fragment.startYear = 2000; fragment.startMonth = 6;
        fragment.endYear = 2002; fragment.endMonth = 2;
        
        LifelineFragment *fragment2 = [LifelineFragment new];
        fragment2.type = LifelineFragmentTypeWork;
        fragment2.name = @"Apple Inc.";
        fragment2.position = @"Designer";
        fragment2.personToVerify = @"Steve Jobs";
        fragment2.startYear = 1984; fragment2.startMonth = 4;
        fragment2.endYear = 1990; fragment2.endMonth = 7;
        
        LifelineFragment *fragment3 = [LifelineFragment new];
        fragment3.type = LifelineFragmentTypeWork;
        fragment3.name = @"Audi AG";
        fragment3.position = @"Tester";
        fragment3.personToVerify = @"August Horch";
        fragment3.startYear = 2004; fragment3.startMonth = 1;
        fragment3.endYear = 2007; fragment3.endMonth = 8;
        
        LifelineFragment *fragment4 = [LifelineFragment new];
        fragment4.type = LifelineFragmentTypeEducation;
        fragment4.name = @"Harvard University";
        fragment4.position = @"Professor";
        fragment4.personToVerify = @"John Harvard";
        fragment4.startYear = 2008; fragment4.startMonth = 2;
        fragment4.endYear = 2012; fragment4.endMonth = 9;
        
        self.data = [[NSArray alloc]initWithObjects:fragment,fragment2,fragment3,fragment4, nil];
    }
    return self;
}
- (void)twoFingerTapOnLifeline:(UITapGestureRecognizer *)gesture
{
    CGPoint firstPoint=[gesture locationOfTouch:0 inView:self.lifelineScrollView];
    CGPoint secondPoint=[gesture locationOfTouch:1 inView:self.lifelineScrollView];
    CGPoint start = firstPoint.x < secondPoint.x ? firstPoint : secondPoint;
    CGPoint end = firstPoint.x >= secondPoint.x ? firstPoint : secondPoint;
    
    [self startFragmentEditorAt:start end:end];
}

-(void)showFragmentEditor {
    
}
-(void)hideFragmentEditor {
    
}
-(void)startFragmentEditorAt:(CGPoint)start end:(CGPoint)end {
    [self showFragmentEditor];
}
-(void)saveFragmentEditor {
    
}

-(void)setData:(NSArray *)data {
    _data = data;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:[NSDate date]];
    UIImage *fragmentIcon = [self drawFragmentIcon];
    
    int currentYear = (int)[components year];
    [[self.lifelineScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(int i=1;i<100;i++) {
        UILabel *yearLabel = createLabel(rectToCenter(CGRectMake(0, 0, 50, 16), CGPointMake(i*YEAROFFSET, 10)), [UIFont fontWithName:@"HelveticaNeue" size:16], [UIColor whiteColor], [NSString stringWithFormat:@"%d",currentYear - 99 + i]);
        yearLabel.textAlignment = NSTextAlignmentCenter;
        [self.lifelineScrollView addSubview:yearLabel];
    }
    for(LifelineFragment *fragment in data) {
        float startYear = fragment.startYear - currentYear + fragment.startMonth / 12.0;
        float endYear = fragment.endYear - currentYear + fragment.endMonth / 12.0;
        
        UIImageView *startView = [[UIImageView alloc]initWithImage:fragmentIcon];
        startView.frame = rectToCenter(startView.frame, CGPointMake(self.lifelineScrollView.contentSize.width + startYear*YEAROFFSET, 10));
        [self.lifelineScrollView addSubview:startView];
        
        UIImageView *endView = [[UIImageView alloc]initWithImage:fragmentIcon];
        endView.frame = rectToCenter(endView.frame, CGPointMake(self.lifelineScrollView.contentSize.width + endYear*YEAROFFSET, 10));
        [self.lifelineScrollView addSubview:endView];
    }
}

-(UIImage *)drawFragmentIcon {
    int circleSize = 15;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleSize, circleSize), NO, RETINA);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:1 alpha:1].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1 alpha:1].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake(1,1, circleSize-2, circleSize-2));
    CGContextDrawPath(context, kCGPathStroke);
    CGContextFillRect(context, CGRectMake(circleSize/2, circleSize/2, 1, 1));
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Tap");
    for(UITouch*touch in touches) {
        CGPoint pos = [touch locationInView:self];
        if(CGRectContainsPoint(self.lifeLineLabel.frame, pos)) {
            if(self.lifeLineLabel.alpha == 0.5) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.lifeLineLabel.alpha = 1.0;
                    self.expListLabel.alpha = .5;
                    self.lifeLineLabel.layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1].CGColor;
                    self.expListLabel.layer.backgroundColor = [UIColor clearColor].CGColor;
                }];
            }
        }
        else if(CGRectContainsPoint(self.expListLabel.frame, pos)) {
            if(self.expListLabel.alpha == 0.5) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.lifeLineLabel.alpha = .5;
                    self.expListLabel.alpha = 1.0;
                    self.lifeLineLabel.layer.backgroundColor = [UIColor clearColor].CGColor;
                    self.expListLabel.layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1].CGColor;
                }];
            }
        }
        else if(CGRectContainsPoint(self.buttonAdd.frame, pos)) {
            if(self.buttonAddCache.alpha == 1.0) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.buttonAddCache.alpha = 0.0;
                }];
            }
            else if(self.buttonAddCache.alpha == 0.0) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.buttonAddCache.alpha = 1.0;
                }];
            }
        }
        else if(CGRectContainsPoint(self.buttonEdit.frame, pos)) {
            if(self.buttonEditCache.alpha == 1.0) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.buttonEditCache.alpha = 0.0;
                }];
            }
            else if(self.buttonEditCache.alpha == 0.0) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.buttonEditCache.alpha = 1.0;
                }];
            }
        }
        else if(CGRectContainsPoint(self.buttonTrash.frame, pos)) {
            if(self.buttonTrashCache.alpha == 1.0) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.buttonTrashCache.alpha = 0.0;
                }];
            }
            else if(self.buttonTrashCache.alpha == 0.0) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.buttonTrashCache.alpha = 1.0;
                }];
            }
        }
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    for(UITouch*touch in touches) {
        CGPoint pos = [touch locationInView:self];
        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    for(UITouch*touch in touches) {
        CGPoint pos = [touch locationInView:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
