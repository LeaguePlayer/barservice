//
//  MenuViewController.m
//  barservice
//
//  Created by Leonid Minderov on 26.02.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "NavigrationController.h"
#import "MenuCell.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize menuNames;
@synthesize menuLinks;
@synthesize menuImages;
- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue { }



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  //  self.tableView.separatorColor = [UIColor colorWithRed:0.427 green:0.408 blue:0.38 alpha:1.0];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.286 green:0.259 blue:0.227 alpha:1.0]];
    
    menuNames = [[NSMutableArray alloc] init];
    menuLinks = [[NSMutableArray alloc] init];
    menuImages = [[NSMutableArray alloc] init];
    
  
    
    
    
   
    menuItems = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:menuNames,menuLinks, menuImages, nil] forKeys:[NSArray arrayWithObjects:@"names", @"links",@"images", nil]];
    
   
    
 //   [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return [[menuItems objectForKey:@"names"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   

    static NSString *CellIdentifier = @"Cell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // More initializations if needed.
    }
    // Configure the cell...
    cell.cellTitle.text = [[menuItems objectForKey:@"names"] objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor colorWithRed:0.286 green:0.259 blue:0.227 alpha:1.0]];
    
    // состояние при клике - меняем фон
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:0.114 green:0.102 blue:0.09 alpha:1.0]];
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.imageCell.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageCell.image = [UIImage imageNamed:[[menuItems objectForKey:@"images"] objectAtIndex:indexPath.row]];
    
    // cкрываем последнюю line
    if([[menuItems objectForKey:@"names"] count] == indexPath.row+1) cell.cellLine.alpha = 0;
    else cell.cellLine.alpha = 1;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
     NSString *identifier = [NSString stringWithFormat:@"%@", [[menuItems objectForKey:@"links"] objectAtIndex:indexPath.row]];
        
    
   
      
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
 
        
    NavigrationController *tVC = ((NavigrationController *)self.slidingViewController.topViewController);
    NSArray * viewControllers = [tVC viewControllers];
    NSArray * newViewControllers = [NSArray arrayWithObjects:[viewControllers objectAtIndex:0],
                                    newTopViewController,nil];
    [tVC setViewControllers:newViewControllers animated:NO];
    
   
    
        [self.slidingViewController resetTopViewAnimated:YES];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */



@end
