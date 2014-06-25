//
//  SearchView.m
//  Waxara
//
//  Created by Passion on 6/18/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "SearchView.h"

#import "SearchCommand.h"
#import "InterfaceUtil.h"
#import "StringUtil.h"
#import "SearchData.h"
#import "MainMotherVC.h"

#define STANDARD_SHOW_COUNT 6

@implementation SearchView

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if ((self = [super initWithCoder:aDecoder]))
    {
        // Initialization code
        [self setWithFrame:self.frame background:nil nShowCnt:STANDARD_SHOW_COUNT];
        
    }
    return self;
    
}

-(id)initWithFrame:(CGRect)frame background:(UIImage*)background data:(NSMutableArray*)data labels:(int)labels owner:(UIViewController*)owner
{
    self = [super init];
    
    if (self) {
        [self setWithFrame:frame background:background nShowCnt:6];
        self.vcSuper = owner;
        self.allData = data;
    }
    
    return self;
}

-(void) setWithFrame:(CGRect)frame background:(UIImage*)background nShowCnt:(int)nShowCnt
{
    UIFont *hn_20 =[UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    UIFont *hn_14 =[UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    UIColor *whiteColor = [UIColor whiteColor];

    self.viewLabels = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.viewLabels.alpha = 0;
    [self addSubview:self.viewLabels];
    
    
    self.sortedData = [NSMutableArray new];
    self.commands = [NSMutableArray new];
    self.currentCommand = [SearchCommand new];
    
    //Add Search TextField
    int heightTF = 32;
    self.tfSearch = createTextField(CGRectMake(0, frame.size.height - heightTF, frame.size.width, heightTF), hn_20, whiteColor, background, YES, UIReturnKeyDefault, 0, 0);
    
    self.tfSearch.placeholder = @"Action";
    self.tfSearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Action" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor],NSFontAttributeName : hn_14}];
    
    [self.tfSearch addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tfSearch addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfSearch addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    [self addSubview:self.tfSearch];
    
    NSMutableArray *labelArray = [NSMutableArray new];
    for(int i = 0; i < nShowCnt; i++) {
        UILabel *label = createLabel(CGRectMake(0, frame.size.height - heightTF - 30 * (i+1), frame.size.width, 16), hn_14, whiteColor, [self.data objectAtIndex:i]);
        [self.viewLabels addSubview:label];
        [labelArray addObject:label];
        if(nShowCnt - i < 4) {
            float alpha = .25f * (float)(nShowCnt - i);
            label.alpha = alpha;
        }
    }
    self.arrLabels = labelArray;
}


#pragma mark - Textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.sortedData = [[NSMutableArray alloc]initWithArray:self.data];
    [self updateLabels];
    self.opened = YES;
    [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
        self.viewLabels.alpha = 1;
    } completion:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.opened = NO;
    self.tfSearch.text = @"";
    self.tfSearch.textColor = WHITECOLOR;

    [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^{
        self.viewLabels.alpha = 0;
    } completion:nil];
}

-(void)textFieldDidChange:(UITextField *)textField
{
    NSString *text = textField.text;
    
    BOOL backspaceClicked = self.prevString.length > textField.text.length;
    
    char newChar = [text characterAtIndex:text.length-1];
    char previousChar = text.length > 2 ? [text characterAtIndex:text.length - 2] : 0;

    if(backspaceClicked)
    {
        // Backspace clicked
        if ((text.length <= self.commandsRange) && (text.length != 0))
        {
            self.commandError = NO;
            
            if ([self lastCommand])
            {
                self.currentCommand = [self lastCommand];
                self.page = self.currentCommand.page;
                self.commandsRange = self.currentCommand.start - 1;
                
                if(self.commandsRange < 0) self.commandsRange = 0;
                
                if(text.length <= self.highlightedRange)
                    self.highlightedRange = self.commandsRange;
                
                [self removeLastCommand];
                
            }
            else
            {
                self.currentCommand = [SearchCommand new];
                self.page = 0;
                self.currentCommand.page = 0;
                self.commandsRange = 0;
            }
            
            if(self.commands.count == 0) self.search = NO;
        }
        else
        {
            if (self.currentCommand.length > 0)
            {
                self.currentCommand.length--;
            }
            
            self.currentCommand.text = stringRemoveLastCharacter(self.currentCommand.text);
        }
    }
    else
    {
        if(!self.search)
        {
            if(newChar == 32)
            { // Space clicked
                if(text.length == 1 || previousChar == 32)
                {
                    textField.text = stringRemoveLastCharacter(textField.text);
                    return;
                } // Prevent clicking space in clear field
                
                int nSelectedIndex = [self stringIsCommand:self.currentCommand.text];
                if(nSelectedIndex != -1) //its command is valid
                {
                    if(!self.commandError) {
                        self.highlightedRange = text.length - 1;
                        self.currentCommand.index = nSelectedIndex;
                        [self changeSearchListByCommand:self.currentCommand];
                    }
                    else
                    {
                        if(self.commands.count == 0) self.search = YES;
                        self.commandError = YES;
                    }
                    [self addCommand:self.currentCommand];
                    self.currentCommand.start = text.length;
                    self.commandsRange = text.length - 1;
                }
                else
                {
                    self.currentCommand.length++;
                    self.currentCommand.text = [textField.text substringWithRange:NSMakeRange(self.currentCommand.start, self.currentCommand.length)];
                }
            }
            else
            {
                self.currentCommand.length++;
                self.currentCommand.text = [textField.text substringWithRange:NSMakeRange(self.currentCommand.start, self.currentCommand.length)];
            }
        }
    }
    
    if(!self.search)
    {
        if(self.commandError)
        {
            NSLog(@"Met command Error");
            NSString *fullCommand = [textField.text substringWithRange:NSMakeRange(self.highlightedRange+1, text.length - self.highlightedRange-2)];
            NSLog(@"%@",fullCommand);
            
            [self searchFor:fullCommand];
        }
        else
        {
            [self searchFor:self.currentCommand.text];
        }
    }
    
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:textField.text];
    [attstring addAttribute:NSForegroundColorAttributeName value:BLUECOLOR range:NSMakeRange(0,self.highlightedRange)];
 
    textField.attributedText=attstring;
    self.prevString = textField.text;
}

#pragma mark - UI Utility

-(int)stringIsCommand:(NSString*)string
{
    for (int i = 0; i < self.data.count; i++)
    {
        if([[string lowercaseString] hasPrefix:[[self.data objectAtIndex:i] lowercaseString]]) {
            return i;
        }
        
    }

    return -1;
}

-(void)searchFor:(NSString*)text
{
    if(text == nil)
    {
        self.sortedData = [[NSMutableArray alloc]initWithArray:self.data];
        [self updateLabels];
        return;
    }
    
    NSMutableArray *newFiltered = [NSMutableArray new];
    for(NSString *string in self.data) {
        if([[string lowercaseString] hasPrefix:[text lowercaseString]]) {
            [newFiltered addObject:string];
        }
    }
    int length = (int)text.length;
    if(length == 0) {
        self.sortedData = [[NSMutableArray alloc]initWithArray:self.data];
    }
    else {
        if(newFiltered.count == 0) {
            [newFiltered addObject:@"Search"];
        }
        self.sortedData = newFiltered;
    }
    [self updateLabels];
}

-(void)updateLabels
{
    int i = 0;
    for(UILabel *label in self.arrLabels) {
        if(i<self.sortedData.count) {
            label.text = [self.sortedData objectAtIndex:i];
        }
        else {
            label.text = @"";
        }
        i++;
    }
}

#pragma mark - Data Utility
-(SearchCommand*)lastCommand
{
    SearchCommand* lastCommand = nil;
    
    if (self.commands.count > 0)
    {
        lastCommand = [self.commands objectAtIndex:self.commands.count - 1];
    }
    
    return lastCommand;
}

-(void)removeLastCommand
{
    if (self.commands.count > 0)
    {
        SearchCommand *command = [self.commands objectAtIndex:self.commands.count-1];
        [self.commands removeObject:command];
    }
}

-(void)addCommand:(SearchCommand *)command
{
    [self.commands addObject:command];
    self.currentCommand = [SearchCommand new];
    self.currentCommand.page = self.page;
}

-(void)changeCurrentCommandToString:(NSString*)string
{
    NSString *noCommandString = [self.tfSearch.text substringWithRange:NSMakeRange(0, self.currentCommand.start)];
    self.tfSearch.text = [NSString stringWithFormat:@"%@%@ ", noCommandString, string];
    self.currentCommand.text = string;
    self.currentCommand.length = (int)string.length-1;
}

-(void)deallocCommand
{
    self.highlightedRange = 0;
    self.page = 0;
    self.currentCommand = [SearchCommand new];
    self.currentCommand.page = self.page;
    [self.commands removeAllObjects];
    self.search = NO;
    self.commandError = NO;
    self.prevString = @"";
}

#pragma mark - Touch Processing
-(BOOL)touchDown:(CGPoint)pos {
    NSLog(@"frame width: %f, Touch pos x: %f y: %f", self.frame.size.width, pos.x, pos.y);
    
    float fPosY = -pos.y;
    
    
    if(pos.x > 0 && pos.x < self.frame.size.width
       && fPosY > 0 && fPosY < 30 * self.arrLabels.count)
    {
        int nStringIndex = fPosY / 30.0f;
        NSString *strSelected = [[self.arrLabels objectAtIndex:nStringIndex] text];
        [self changeCurrentCommandToString:strSelected];
        [self textFieldDidChange:self.tfSearch];

        if(self.page == -1)
        {
            [self.tfSearch resignFirstResponder];
            [self returnClick];
        }
        /*
         [self addCommand:self.currentCommand];
         self.highlightedRange = (int)self.searchField.text.length-1;
         [self highlightText];
         [self searchFor:nil];
         */
        return YES;
    }
    return NO;
}

#pragma mark - Utility
- (NSMutableArray*) arrayAspectList
{
    NSMutableArray* arrAspects = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.allData.count; i++)
    {
        SearchData* dataSel = [self.allData objectAtIndex:i];
        NSString* strAspect = dataSel.searchAspect;
        
        [arrAspects addObject:strAspect];
    }
    
    return arrAspects;
}

- (void) setAllData:(NSMutableArray *)data
{
    _allData = data;
    self.page = 0;
    self.currentCommand.page = self.page;
    
}

- (void) setVcSuper:(UIViewController *)vcSuper
{
    _vcSuper = vcSuper;
    self.tfSearch.delegate = vcSuper;
}

-(void)setSearch:(BOOL)search
{
    if(_search != search) {
        _search = search;
        if(search) {
            self.sortedData = [[NSMutableArray alloc]initWithObjects:@"Search", nil];
            [self updateLabels];
        }
    }
}

-(void)highlightText
{
    NSMutableAttributedString * attstring = [[NSMutableAttributedString alloc] initWithString:self.tfSearch.text];
    [attstring addAttribute:NSForegroundColorAttributeName value:BLUECOLOR range:NSMakeRange(0,self.highlightedRange)];
    self.tfSearch.attributedText=attstring;
}

-(void)setPage:(int)page
{
    _page = page;
    if(page == -1) {
        self.data = [[NSMutableArray alloc]initWithObjects:@"Search", nil];
    }
    else if (page == 0)
    {
        self.data = [self arrayAspectList];
    }
    else
    {
        self.data = ((SearchData*)[self.allData objectAtIndex:self.currentCommand.index]).arrSubData;
    }
}

-(void)changeSearchListByCommand:(SearchCommand*)command
{
    NSString *text = [command.text lowercaseString];
    if(self.page == searchPageCommands) { //if it is Page search
        self.page = 1;
        return;
    }
    self.page = -1;
}

-(BOOL)checkTextField:(UITextField*)textField
{
    return (textField == self.tfSearch);
}

-(void)returnClick
{
    int nSelectedIndex = [self stringIsCommand:self.currentCommand.text];
    if(nSelectedIndex != -1) {
        [self addCommand:self.currentCommand];
    }
    
    if(self.commandError) NSLog(@"Command error");
    if(self.search) NSLog(@"Search");
    if(self.commands.count == 0) NSLog(@"No commands");
    if(self.commandError || self.search)
    {
        return;
    }
    
    if(self.commands.count == 0)
    {
        return;
    }
    
    if(self.commands && self.currentCommand.text.length>0)
    {
        
    }
    
    SearchCommand *firstCommand = [self.commands objectAtIndex:0];
    
    NSLog(@"First Command: %@", firstCommand.text);
    
    if([[firstCommand.text lowercaseString] isEqualToString:@"log off"])
    {
        [(MainMotherVC*)(self.vcSuper) logOut];
    }
    
    if(self.commands.count == 2)
    {
        SearchCommand *secondCommand = [self.commands objectAtIndex:1];

        NSLog(@"Second Command: %@", secondCommand.text);
        [(MainMotherVC*)self.vcSuper showCoreWithToolName:[secondCommand.text uppercaseString]];
    }

    [self deallocCommand];
    
    [self.tfSearch resignFirstResponder];
}

@end
