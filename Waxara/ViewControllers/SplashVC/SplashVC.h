//
//  SplashVC.h
//  Waxara
//
//  Created by Passion on 6/13/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "BaseVC.h"

@interface SplashVC : BaseVC

@property (weak, nonatomic) IBOutlet UIView *viewStatus;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lblStepCollection;



+ (SplashVC*) splashVC;

@end
