//
//  NewsViewController.h
//  Waxara
//
//  Created by PWC on 6/25/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    NSMutableArray * itemArray ;
    NSMutableArray * itemImageArray;
    int itemCnt;
    
    NSMutableArray * newsArray;
    NSMutableArray * newsTitleArray;
    
    NSArray * getNewsData;
    int countData;
}

@property (nonatomic, retain) IBOutlet UITableView * tblFeedView;
@property (nonatomic, retain) IBOutlet UITableView * tblNewsView;

@property (nonatomic, retain) IBOutlet UILabel * lblCategoryName;

@property (nonatomic, retain) IBOutlet UILabel * lblItemTitle;
@property (nonatomic, retain) IBOutlet UIImageView * itemImage;
@property (nonatomic, retain) IBOutlet UILabel * lblItemDesc;

@property (nonatomic, retain) IBOutlet UITextField * txtSearchNews;

@end
