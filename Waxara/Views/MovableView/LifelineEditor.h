//
//  LifelineEditor.h
//  Grid
//
//  Created by LinO_dska on 16.06.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Lifeline;
@class Profile;
@class BoxView;
@class TextField;
@interface LifelineEditor : UIView

//getted information
@property Profile *profile;
@property NSArray *icons;

//profile lifeline data
@property (nonatomic) NSArray *data;
@property UIScrollView *lifelineScrollView;

//Lifeline
@property Lifeline *lifeline;

//Fragment Editor
@property UIImageView *startView;
@property UIImageView *endView;
@property BoxView *box;


//VIEWS
//top buttons
@property UILabel *lifeLineLabel;
@property UILabel *expListLabel;

//edit buttons
@property UIImageView *buttonAdd; @property UIImageView *buttonAddCache;
@property UIImageView *buttonEdit; @property UIImageView *buttonEditCache;
@property UIImageView *buttonTrash; @property UIImageView *buttonTrashCache;

@property BoxView *addFragmentView;
@property UILabel *work;
@property UILabel *education;
@property UILabel *startDate;
@property UILabel *endDate;
@property TextField *companyField;
@property UILabel *companyLabel;
@property TextField *positionField;
@property UILabel *positionLabel;
@property TextField *personField;
@property UILabel *personLabel;

@property NSString *workCompany;
@property NSString *workPosition;
@property NSString *workPersonToVerify;

@property NSString *educationSchool;
@property NSString *educationPosition;
@property NSString *educationPersonToVerify;

- (instancetype)initWithFrame:(CGRect)frame profile:(Profile*)profile icons:(NSArray*)icons;
@end
