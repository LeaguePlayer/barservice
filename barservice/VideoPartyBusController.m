//
//  VideoPartyBusController.m
//  barservice
//
//  Created by Leonid Minderov on 15.05.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "VideoPartyBusController.h"
#import "XCDYouTubeVideoPlayerViewController.h"

#define heightCell 44
#define height_top_padding_table 18

@interface VideoPartyBusController ()

@end

@implementation VideoPartyBusController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.userInteractionEnabled = YES;
    
    self.photos = [NSMutableArray array];
    // [self.viewScroll removeFromSuperview];
    dataTable = [[NSMutableArray alloc] init];
    
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getvideos/site/partybus",domain_server_api];
    [self startAPI];
    
    
    
}

//-(void)resizeTable
//{
//    // теймбл сам
//    CGRect frame = tableMenu.frame;
//    frame.size.height = [dataTable count]*44+bottomPadding;
//    tableMenu.frame = frame;
//    backgroundPlace.frame = frame;
//
//
//
//    // теперь scrollView
//    self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, [dataTable count]*44+bottomPadding+bottomMargin);
//}

-(void)completeApi
{
    
    dataTable = [self.gotDataAPI objectForKey:@"response"];
    
    [self buildContent];
}

-(void)buildContent
{
    
    backgroundPlace= [self makeMainBackgroundwithBorder:NO andHeightIs:[dataTable count]*heightCell+height_top_padding_table+bottomPadding andSwitchType:@"partybus"];
    
    
    
    tableMenu = [[UITableView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [dataTable count]*heightCell+bottomPadding+height_top_padding_table)];
    tableMenu.backgroundColor = [UIColor clearColor];
    tableMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableMenu.dataSource = self;
    tableMenu.delegate = self;
    tableMenu.contentInset = UIEdgeInsetsMake(height_top_padding_table, 0, 0, 0);
    [tableMenu setBackgroundView:nil];
    [tableMenu setBackgroundColor:[UIColor clearColor]];
    
    // self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, 9999);
    
    [self.viewScroll setContentSize:CGSizeMake(self.viewScroll.frame.size.width, tableMenu.frame.size.height+bottomMargin)];
    [backgroundPlace addSubview:tableMenu];
    
    
    
    [self.viewScroll addSubview:backgroundPlace];
    
    
    
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [dataTable count];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightCell;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text = [[dataTable objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.286 green:0.259 blue:0.227 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:[[dataTable objectAtIndex:indexPath.row] objectForKey:@"video"]];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}




//-(void)showLeftMenu
//{
//    [super showLeftMenu];
//}

//-(CGFloat)heightForText:(NSString *)text
//{
//    NSInteger MAX_HEIGHT = 2000;
//    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, WIDTH_OF_TEXTVIEW, MAX_HEIGHT)];
//    textView.text = text;
//    textView.font = // your font
//    [textView sizeToFit];
//    return textView.frame.size.height;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
