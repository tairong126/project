//
//  NewsViewController.m
//  Waxara
//
//  Created by PWC on 6/25/14.
//  Copyright (c) 2014 Passion. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

@synthesize tblFeedView, tblNewsView;

@synthesize lblCategoryName;

@synthesize lblItemTitle, itemImage, lblItemDesc;

@synthesize txtSearchNews;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    itemArray = [[NSMutableArray alloc] init];
    [itemArray addObject:@"Technology"];
    [itemArray addObject:@"Sports"];
    [itemArray addObject:@"Business"];
    [itemArray addObject:@"Finance"];
    [itemArray addObject:@"Social Media"];
    [itemArray addObject:@"Politics"];
    [itemArray addObject:@"Entertainment"];
    [itemArray addObject:@"International"];
    [itemArray addObject:@"Cars"];
    
    itemImageArray = [[NSMutableArray alloc] init];
    [itemImageArray addObject:@"topic-1.png"];
    [itemImageArray addObject:@"topic-2.png"];
    [itemImageArray addObject:@"topic-3.png"];
    [itemImageArray addObject:@"topic-4.png"];
    [itemImageArray addObject:@"topic-5.png"];
    [itemImageArray addObject:@"topic-6.png"];
    [itemImageArray addObject:@"topic-7.png"];
    [itemImageArray addObject:@"topic-8.png"];
    [itemImageArray addObject:@"topic-9.png"];
    
    itemCnt = [itemArray count];
    
    newsArray = [[NSMutableArray alloc] init];
    [newsArray addObject:@"item-1.png"];
    [newsArray addObject:@"item-2.png"];
    [newsArray addObject:@"item-3.png"];
    
    newsTitleArray = [[NSMutableArray alloc] init];
    [newsTitleArray addObject:@"Apple prove everyone wrong with new iPhone operating system"];
    [newsTitleArray addObject:@"Garmin Launches new and cheap Navigation app for iOS and Android"];
    [newsTitleArray addObject:@"Look Out, Apple: Google May Launch a Health-Data App"];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10) {
        return itemCnt;
    }else{
        return [newsArray count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.backgroundColor = [UIColor clearColor];
    tableView.layer.borderWidth = 0;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    //[cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.borderWidth = 0;
    //UIColor *sectionBackgroundColor = [UIColor colorWithRed:0.03f green:0.41f blue:0.35f alpha:1.0];
    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //cell.backgroundColor = sectionBackgroundColor;
    
    if(tableView.tag == 10){
        
        UIImageView *topicImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 50, 50)];
        [topicImage setTag:100];
        [topicImage setImage:[UIImage imageNamed:[itemImageArray objectAtIndex:indexPath.row]]];
        CALayer * l = [topicImage layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:10.0];
        [cell.contentView addSubview:topicImage];
        
        UILabel * topicName = [[UILabel alloc] initWithFrame:CGRectMake(58, 10, 105, 30)];
        [topicName setBackgroundColor:[UIColor clearColor]];
        [topicName setTextColor:[UIColor whiteColor]];
        [topicName setFont:[UIFont fontWithName:@"Helvetica Neue" size:17]];
        
        topicName.adjustsFontSizeToFitWidth = NO ;
        topicName.numberOfLines = 0;
        [topicName setText:[itemArray objectAtIndex:indexPath.row]];
        [cell.contentView addSubview:topicName];
        
        UILabel * topicStory = [[UILabel alloc] initWithFrame:CGRectMake(58, 48, 105, 21)];
        [topicStory setBackgroundColor:[UIColor clearColor]];
        [topicStory setTextColor:[UIColor whiteColor]];
        [topicStory setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
        
        topicStory.adjustsFontSizeToFitWidth = NO ;
        topicStory.numberOfLines = 0;
        [topicStory setText:@"33 News Story"];
        [cell.contentView addSubview:topicStory];
        
        UIImageView *topicIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(161, 25, 13, 20)];
        [topicIconImage setTag:100];
        [topicIconImage setImage:[UIImage imageNamed:@"categoryIcon.png"]];
        [cell.contentView addSubview:topicIconImage];
        
    }else {
        
        UIImageView *newsImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 297, 240)];
        [newsImage setTag:100];
        [newsImage setImage:[UIImage imageNamed:[newsArray objectAtIndex:indexPath.row]]];
        [cell.contentView addSubview:newsImage];
        
        UIImageView * newsView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160, 297, 70)];
        //[newsView setBackgroundColor:[UIColor lightGrayColor]];
        [newsView setBackgroundColor:[UIColor colorWithRed:170/255 green:170/255 blue:170/255 alpha:0.3]];
        [cell.contentView addSubview:newsView];
        
        UILabel * productTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 168, 257, 53)];
        [productTitle setBackgroundColor:[UIColor clearColor]];
        [productTitle setTextColor:[UIColor whiteColor]];
        [UIFont fontWithName:@"Helvetica Neue" size:15];
        productTitle.adjustsFontSizeToFitWidth = NO ;
        productTitle.numberOfLines = 0;
        [productTitle setText:[newsTitleArray objectAtIndex:indexPath.row]];
        [cell.contentView addSubview:productTitle];
        
        UIImageView * newsBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 235, 297, 5)];
        //[newsView setBackgroundColor:[UIColor lightGrayColor]];
        //[newsView setBackgroundColor:[UIColor colorWithRed:170/255 green:170/255 blue:170/255 alpha:0.3]];
        [newsBarView setImage:[UIImage imageNamed:@"item_bar.png"]];
        [cell.contentView addSubview:newsBarView];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[cell setBackgroundColor:[UIColor clearColor]];
    cell.backgroundColor = [UIColor clearColor];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView.tag == 10){
        
        lblCategoryName.text = [itemArray objectAtIndex:indexPath.row];
    }else{
        [itemImage setImage:[UIImage imageNamed:[newsArray objectAtIndex:indexPath.row]]];
        lblItemTitle.text = [newsTitleArray objectAtIndex:indexPath.row];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
