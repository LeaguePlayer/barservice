//
//  ListTableBarserviceViewController.m
//  barservice
//
//  Created by Leonid Minderov on 26.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "ListTableBarserviceViewController.h"
#import "PageViewController.h"
#import "InventoryViewController.h"
#import "OrderBarserviceController.h"

// стандартные настройки бар сервис вью вынесены barservice-Prefix.pch

#define cellHeight 44



@interface ListTableBarserviceViewController ()

@end

@implementation ListTableBarserviceViewController
@synthesize tableView;
@synthesize apiValue;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataRows = [[NSMutableArray alloc] init];
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getpage/page/%@",domain_server_api, apiValue];
    [self startAPI];
    
    
    // получаем доступ к меню контроллеру и меняем пунты меню
    MenuViewController *tVC = ((MenuViewController *)self.slidingViewController.underLeftViewController);
    [tVC.menuNames setArray:menuBarservice];
    [tVC.menuLinks setArray:menuBarserviceLinks];
    [tVC.menuImages setArray:menuBarserviceImages];
    [tVC.tableView reloadData];
    
    
    
    
    
    // меняем навигационный бар
    [self.navigationController.navigationBar setBackgroundImage:[Functions imageWithColor:[UIColor colorWithRed:0.824 green:0.337 blue:0.322 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0], NSFontAttributeName : [UIFont systemFontOfSize:21.0]};
    
    // работаем с табличным меню
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(leftPadding, -borderRadius, self.view.frame.size.width-(leftPadding*2), [dataRows count]*cellHeight+topPadding+bottomPadding) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   // tableView.backgroundColor = [UIColor whiteColor];
    tableView.bounces = NO;
    tableView.scrollEnabled = NO;
    tableView.layer.cornerRadius = borderRadius;
    
   
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(topPadding+borderRadius, 0, 0, bottomPadding);
  
    
    NSString *backgroundTableView;
    
    if(IS_IPAD)
    {
        backgroundTableView=@"ray3";
    }
    else
    {
        backgroundTableView=@"rays_l";
    }
    
    // добавляем фон на таблицу
    for( id view in self.tableView.subviews)
    {
        UIImageView *bgTable = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundTableView]];
        CGRect frame = bgTable.frame;
        frame.origin.x = leftPadding*2*-1;
        frame.origin.y = -topPadding;
        bgTable.frame = frame;
        [view addSubview:bgTable];
    }
    
    // добавляем фон на вью
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundTableView]];
    CGRect frame = bgView.frame;
    frame.origin.x = leftPadding*-1;
    bgView.frame = frame;
    
  
    
    [self.viewScroll addSubview:bgView];
    [self.viewScroll addSubview:tableView];
    
    
 

    
  //  self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, [dataRows count]*cellHeight+topPadding+bottomPadding+bottomMargin);
    
    //NSLog(@"%@",tableView.subviews.description);
}

- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(8.0, 8.0)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}

-(void)resizeTable
{
    // теймбл сам
    CGRect frame = self.tableView.frame;
    frame.size.height = [dataRows count]*cellHeight+topPadding+bottomPadding;
    self.tableView.frame = frame;
    
    // теперь scrollView
     self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, [dataRows count]*cellHeight+topPadding+bottomPadding+bottomMargin);
}

-(void)completeApi
{
  //   NSLog(@"%@",[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"childs"]);
    //dataRows = ;
    
    dataRows = [[self.gotDataAPI objectForKey:@"response"] objectForKey:@"childs"];
    
    
    
    [self.tableView reloadData];
    
    [self resizeTable];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [dataRows count]; // добавляем два, за самую верхнею и нижнею плашку
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return cellHeight;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // More initializations if needed.
    }
    
  
        // ячейки с контентом
       cell.textLabel.text = [[dataRows objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.textLabel.textColor = [UIColor colorWithRed:0.647 green:0.647 blue:0.647 alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = [UIColor clearColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red_arrow"]];
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:0.906 green:0.902 blue:0.902 alpha:0.6];
    
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    
//    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"rls3u7RMI0Y"];
//    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
    
  
    
    id page_id = [[dataRows objectAtIndex:indexPath.row] objectForKey:@"id_page"];
    id page_type = [[dataRows objectAtIndex:indexPath.row] objectForKey:@"type"];
    
    if ([page_type isEqualToString:@"order_view"]) // этот тип открывает order view
    {
        OrderBarserviceController *orderView = [[OrderBarserviceController alloc] init];
        orderView.type_order.text = [[dataRows objectAtIndex:indexPath.row] objectForKey:@"service_name"];
        [self.navigationController pushViewController:orderView animated:YES];
    }
    else if([page_type isEqualToString:@"inventory"]) // это ID барный инвентарь
    {
        InventoryViewController *inventory = [[InventoryViewController alloc] init];
        inventory.id_category = [[dataRows objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self.navigationController pushViewController:inventory animated:YES];
    }
    else
    {
        PageViewController *newPage = [[PageViewController alloc] init];
        
        newPage.id_page = page_id;
        
        [self.navigationController pushViewController:newPage animated:YES];
    }
    
    
    
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
