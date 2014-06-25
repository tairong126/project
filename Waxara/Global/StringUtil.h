//
//  StringUtil.h
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//
//  Todo Here:
//      Define All String Utility Functions
//

#ifndef Waxara_StringUtil_h
#define Waxara_StringUtil_h

static BOOL stringIsMail(NSString* string) {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}
static BOOL stringIsName(NSString *string) {
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ "] invertedSet];
    if ([string rangeOfCharacterFromSet:set].location != NSNotFound) {
        return YES;
    }
    return NO;
}
static NSString* stringRemoveLastCharacter(NSString *string) {
    if ([string length] > 0) {
        return [string substringToIndex:string.length - 1];
    }
    return nil;
}

static NSString *stringBeforeFirstChar(NSString*string, char firstChar) {
    NSString *lowerCase = [string lowercaseString];
    const char *c = [lowerCase UTF8String];
    for(int i=0;i<string.length;i++) {
        if(c[i] == firstChar) {
            return [string substringWithRange:NSMakeRange(0,i)];
        }
    }
    return nil;
}

static NSString *stringBeforeLastChar(NSString*string, char lastChar) {
    int length = 0;
    NSString *lowerCase = [string lowercaseString];
    const char *c = [lowerCase UTF8String];
    for(int i=0;i<string.length;i++) {
        if(c[i] == lastChar) {
            length = i;
        }
    }
    if(length) return [string substringWithRange:NSMakeRange(0,length)];
    return nil;
}

static NSString *stringAfterFirstChar(NSString*string, char firstChar) {
    int sLength = string.length-1;
    int start = sLength;
    int length = 0;
    NSString *lowerCase = [string lowercaseString];
    const char *c = [lowerCase UTF8String];
    for(int i = string.length - 1; i>=0; i--) {
        if(c[i] == firstChar) {
            start = i+1;
            length = sLength - i;
        }
    }
    if(start != sLength) return [string substringWithRange:NSMakeRange(start,length)];
    return nil;
}

static NSString *stringAfterLastChar(NSString*string, char lastChar) {
    int sLength = string.length-1;
    NSString *lowerCase = [string lowercaseString];
    const char *c = [lowerCase UTF8String];
    for(int i = string.length - 1; i>=0; i--) {
        if(c[i] == lastChar) {
            return [string substringWithRange:NSMakeRange(i+1,sLength - i)];
        }
    }
    return nil;
}
static NSString *numberToString(int number) {
    NSString *string = [NSString stringWithFormat:@"%d",number];
    return string;
}

static NSString* currencyString(int nMoney, NSString* strSmallCurrecyName){
    NSString *strResult = @"";
    
    if ([strSmallCurrecyName isEqualToString:@"pound"])
    {
        strResult = @"£";
    }
    else if ([strSmallCurrecyName isEqualToString:@"dollar"])
    {
        strResult = @"$";
    }
    else if ([strSmallCurrecyName isEqualToString:@"euro"])
    {
        strResult = @"€";
    }
    
    NSString* strTempString = [NSString stringWithFormat:@"%d", nMoney];
    int nTopLen = strTempString.length % 3;
    
    strResult = [NSString stringWithFormat:@"%@ %@", strResult, [strTempString substringToIndex:nTopLen]];
    
    
    strTempString = [strTempString substringFromIndex:nTopLen];
    
    for (int i = 0; i < strTempString.length / 3; i++)
    {
        strResult = [NSString stringWithFormat:@" %@ %@", strResult, [strTempString substringToIndex:3]];
        
        
        strTempString = [strTempString substringFromIndex:3];
    }
    

    
    return strResult;
}


#endif
