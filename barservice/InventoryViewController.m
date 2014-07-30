//
//  InventoryViewController.m
//  barservice
//
//  Created by Leonid Minderov on 25.04.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "InventoryViewController.h"
#import "BarshopCell.h"
#import "UIImageView+AFNetworking.h"

#define cellHeight 70.0f

@interface InventoryViewController ()

@end

@implementation InventoryViewController
@synthesize tableView;
@synthesize id_category;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_IPAD)
    {
        CGRect frame = self.viewScroll.frame;
        frame.origin.y -=65.0;
        self.viewScroll.frame = frame;
    }
    
    
    // Do any additional setup after loading the view.
    dataRows = [[NSMutableArray alloc] init];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.photos = [NSMutableArray array];
    
    
    
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getbarshop/id_category/%@",domain_server_api,id_category];
    NSLog(@"%@",self.apiString);
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
    
    
    [self resizeTable];
    
    [self.viewScroll addSubview:bgView];
    [self.viewScroll addSubview:tableView];
}


-(void)resizeTable
{
    int rows = (int)[[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"rows"] integerValue];
    int sections = (int)[dataRows count];
    // теймбл сам
    CGRect frame = self.tableView.frame;
    frame.size.height = sections*44+rows*cellHeight+topPadding+bottomPadding;
    self.tableView.frame = frame;
    
    
    
    // теперь scrollView
    self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, sections*44+rows*cellHeight+topPadding+bottomPadding+bottomMargin);
}

-(void)completeApi
{
   
    
    dataRows = [[self.gotDataAPI objectForKey:@"response"] objectForKey:@"menu"];
      for(NSDictionary *image in [[self.gotDataAPI objectForKey:@"response"] objectForKey:@"image"])
    {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[image objectForKey:@"url"]]];
        photo.caption = [image objectForKey:@"title"];
        [self.photos addObject:photo];
    }
    
    [self.tableView reloadData];
    
    [self resizeTable];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [dataRows count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
   
    
    return [[dataRows objectAtIndex:section] count]; // добавляем два, за самую верхнею и нижнею плашку
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return cellHeight;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *CellName;
    if(IS_IPAD)
    {
        CellName = @"BarshopCellipad";
    }
    else
    {
        CellName = @"BarshopCell";
    }
    
    NSString *CellIdentifier = CellName;
    BarshopCell *cell = (BarshopCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellName owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    
   
    cell.titleCell.text = [[[dataRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.priceCell.text = [[[dataRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"price"];
   
    
    
    NSLog(@"image is %@",[[[dataRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"preview"]);
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[[[dataRows objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"preview"]]];
    
    [cell.imageCell setImageWithURLRequest:urlRequest placeholderImage:[UIImage imageNamed:@"holder_bar"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.imageCell.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Request failed with error: %@", error);
    }];
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red_arrow"]];
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:0.906 green:0.902 blue:0.902 alpha:0.6];
    
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"section"] objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int current_image = 0;
    
    if(indexPath.section > 0)
    {
        for(int i=0;i<indexPath.section;i++)
        {
            current_image += (int)[[dataRows objectAtIndex:i] count];
        }
        current_image += indexPath.row;
    }
    else current_image = (int)indexPath.row;
    
    
    NSLog(@"%i",current_image);
        
        // Create browser (must be done each time photo browser is
        // displayed. Photo browser objects cannot be re-used)
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        
        // Set options
        browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
        browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
        browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
        browser.zoomPhotosToFill = NO; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
        browser.alwaysShowControls = YES; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
        browser.enableGrid = NO; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
        browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
        
        // Optionally set the current visible photo before displaying
        [browser setCurrentPhotoIndex:current_image];
        
        // Present
        self.navigationController.navigationItem.leftBarButtonItem.title = @"Назад";
        [self.navigationController pushViewController:browser animated:YES];
        
        // Manipulate
        [browser showNextPhotoAnimated:YES];
        [browser showPreviousPhotoAnimated:YES];
        //[browser setCurrentPhotoIndex:10];
    
}

@end
