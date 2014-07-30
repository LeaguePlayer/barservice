//
//  BoardMenuController.m
//  barservice
//
//  Created by Leonid Minderov on 31.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "BoardMenuController.h"
#import "BoardCell.h"
#import "CategoryCell.h"
#import "NavigrationController.h"

#define heightCell 68
#define height_top_padding_table 70

@interface BoardMenuController ()

@end

@implementation BoardMenuController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.userInteractionEnabled = YES;
    
    heightAllRows = 0;
 
    self.photos = [NSMutableArray array];
   // [self.viewScroll removeFromSuperview];
    dataTable = [[NSMutableArray alloc] init];
    categoryTable = [[NSMutableDictionary alloc ] init];
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getmenu/",domain_server_api];
 //   NSLog(@"%@",self.apiString);
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
    
    dataTable = [[self.gotDataAPI objectForKey:@"response"] objectForKey:@"menu"];
    categoryTable = [[self.gotDataAPI objectForKey:@"response"] objectForKey:@"category"];
    
    
    
    
    
    
    for(NSDictionary *image in [[self.gotDataAPI objectForKey:@"response"] objectForKey:@"image"])
    {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[image objectForKey:@"url"]]];
        photo.caption = [image objectForKey:@"title"];
        [self.photos addObject:photo];
    }
    
    
    
    
    
   // [tableMenu reloadData];
  //  [self resizeTable];
    [self buildContent];
}



-(void)buildContent
{
    
   
    
    int rows = (int)[[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"rows"] integerValue];
    int sections = (int)[dataTable count];
    // теймбл сам
    
     backgroundPlace= [self makeMainBackgroundwithBorder:YES andHeightIs:sections*44+rows*heightCell+height_top_padding_table+bottomPadding andSwitchType:@"grannys"];
    
    float size_of_height = sections*44+rows*heightCell+topPadding+bottomPadding+3+20;
    
    tableMenu = [[UITableView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, size_of_height)];
    
    tableMenu.backgroundColor = [UIColor clearColor];
    tableMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableMenu.dataSource = self;
    tableMenu.delegate = self;
    tableMenu.contentInset = UIEdgeInsetsMake(height_top_padding_table, 0, 0, 0);
    tableMenu.scrollEnabled = NO;
    [tableMenu setBackgroundView:nil];
    [tableMenu setBackgroundColor:[UIColor clearColor]];
    
   // self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, 9999);
    
    
    [self.viewScroll setContentSize:CGSizeMake(self.viewScroll.frame.size.width, tableMenu.frame.size.height+bottomMargin+height_top_padding_table)];
    [backgroundPlace addSubview:tableMenu];
    
    
    
    [self.viewScroll addSubview:backgroundPlace];
    
    
    topView = [[TopViewMenu alloc] initWithFrame:CGRectMake(0, 0, self.viewScroll.frame.size.width, 37)];
    
    topView.max_height = [[categoryTable objectForKey:@"category"] count] * 34.0f + topView.frame.size.height;
    
    
    float offset_y = ([[categoryTable objectForKey:@"category"] count]*34)*-1.0f;
    
    tableCategory = [[UITableView alloc ]initWithFrame:CGRectMake(0, offset_y, self.view.frame.size.width, [[categoryTable objectForKey:@"category"] count]*34)];
    
//    NSLog(@"start with %f vs %f",offset_y, tableCategory.frame.origin.y);
    tableCategory.backgroundColor = [UIColor clearColor];
    tableCategory.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableCategory.dataSource = self;
    tableCategory.delegate = self;
    [topView addSubview:tableCategory];
    
    [topView retagsViews];
    
    [self.viewScroll addSubview:topView];
    
    NSLog(@"all rows is %f", heightAllRows);
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == tableMenu)
    {
        return [dataTable count];
    }
    else
    {
        return 1;
    }
    
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(tableView == tableMenu)
    {
        return [[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"section"] objectAtIndex:section];
    }
    else return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(tableView == tableMenu)
    {
        return 44;
    }
    else
        return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == tableMenu)
    {
        return [[dataTable objectAtIndex:section] count];
        
    }
    else
    {
        return [[categoryTable objectForKey:@"category"] count];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableMenu)
    {
//        float actualHeightText = [self returnHeightByString:[[[dataTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"composition"]];
//        
//        float result = heightCell;
//        
//        if( actualHeightText > 21.0f ) result = result + (actualHeightText - 21.0f);
//        
//        
//        
//        
//        heightAllRows += result;
       
        
        
        
        
        return heightCell;
    }
    else
    {
        return 34.0f;
    }
    
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 22.0)];
    customView.backgroundColor = [UIColor clearColor];
    
  
    
    // create the button object
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor colorWithRed:0.757 green:0.216 blue:0.11 alpha:1.0];
 //   headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    headerLabel.frame = CGRectMake(20.0, 0.0, 280.0, 44);
    
    headerLabel.text = [[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"section"] objectAtIndex:section]; // i.e. array element
    
    
    [customView addSubview:headerLabel];
    
    return customView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableMenu)
    {
        NSString *CellName;
        if(IS_IPAD)
        {
            CellName = @"BoardCellpad";
        }
        else
        {
            CellName = @"BoardCell";
        }
        
        NSString *CellIdentifier = CellName;
        BoardCell *cell = (BoardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellName owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        int id_category_value = (int)[[[[dataTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"id_category"] integerValue];
        
        
        
      
        cell.imageMenu.image = [UIImage imageNamed:[categoryImages objectAtIndex:id_category_value]];
        
        cell.imageMenu.clipsToBounds = YES;
        cell.imageMenu.contentMode = UIViewContentModeCenter;
        
       
        
        cell.nameMenu.text = [[[dataTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
        
        
        cell.priceMenu.text = [NSString stringWithFormat:@"%@ руб",[[[dataTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"price"]];
     
        cell.compositionMenu.text = [[[dataTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"composition"];
        
        float actualHeightText = [self returnHeightByString:[[[dataTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"composition"]];
        
        
      //  cell.compositionMenu.backgroundColor = [UIColor yellowColor];
        
        CGRect frame = cell.compositionMenu.frame;
        frame.size.height = actualHeightText;
        frame.size.width = (IS_IPAD) ? 678 : 190;
        cell.compositionMenu.frame = frame;
        
     //   NSLog(@"%f",cell.compositionMenu.frame.size.width);
        
        cell.backgroundColor = [UIColor clearColor];
        
        
        
       // NSLog(@"height compositionMenu is %f",[self returnHeightByString:cell.compositionMenu.text]);
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"CategoryCell";
        CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CategoryCell"owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
    //    NSArray *a = [categoryTable objectForKey:@"category"];
    //    NSLog(@"%@",a.description);
        
        cell.categoryName.text = [[categoryTable objectForKey:@"category"] objectAtIndex:indexPath.row];
        cell.categoryImage.image = [UIImage imageNamed:[categoryImages objectAtIndex:indexPath.row]];
        cell.categoryImage.clipsToBounds = YES;
        cell.categoryImage.contentMode = UIViewContentModeCenter;
        
        
        cell.backgroundColor = (indexPath.row%2==0) ? [UIColor colorWithRed:0.957 green:0.949 blue:0.933 alpha:1.0] : [UIColor clearColor];
     
        
        return cell;
    }
    
    
   
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableCategory)
    {
        [self.hud show:YES];
      //  NSLog(@"%@",[[categoryTable objectForKey:@"id"] objectAtIndex:indexPath.row]);
        int id_category = (int)[[[categoryTable objectForKey:@"id"] objectAtIndex:indexPath.row] integerValue];
        
        NSString *urlInString =[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@/json/getmenu/id_category/%i",domain_server_api, id_category]];
        
      //  NSLog(@"%@",urlInString);
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:urlInString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
            //NSLog(@"JSON: %@", responseObject);
            
            if([[responseObject objectForKey:@"result"] integerValue] == 1)
            {
                self.gotDataAPI = responseObject;
                dataTable = [[responseObject objectForKey:@"response"] objectForKey:@"menu"];
               // NSLog(@"%i",[dataTable count]);
                
                [self.photos removeAllObjects];
                
                for(NSDictionary *image in [[responseObject objectForKey:@"response"] objectForKey:@"image"])
                {
                    MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[image objectForKey:@"url"]]];
                    photo.caption = [image objectForKey:@"title"];
                    [self.photos addObject:photo];
                }
                
                int rows = (int)[[[responseObject objectForKey:@"response"] objectForKey:@"rows"] integerValue];
                int sections = (int)[dataTable count];
                
                CGRect frame = backgroundPlace.frame;
                frame.size.height = sections*44+rows*heightCell+height_top_padding_table+bottomPadding;
                backgroundPlace.frame = frame;
                
                
                // теймбл сам
                
                
                float size_of_height = sections*44+rows*heightCell+topPadding+bottomPadding+3 + 20;
                
                CGRect t_frame = tableMenu.frame;
                t_frame.size.height = size_of_height;
                tableMenu.frame = t_frame;
                self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, t_frame.size.height+bottomMargin+height_top_padding_table);
                
                for (UIView *view in [backgroundPlace subviews])
                {
                    if(view.tag == 99999)
                    {
                        CGRect tmp_frame = view.frame;
                        tmp_frame.origin.y = backgroundPlace.frame.size.height;
                        view.frame = tmp_frame;
                    }
                    
                }
                topView.selectedCategory.text = [[categoryTable objectForKey:@"category"] objectAtIndex:indexPath.row];
                [tableMenu reloadData];
                
                
            }
            else
            {
                [self.hud hide:YES];
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelText = [responseObject objectForKey:@"error"];
                hud.margin = 10.f;
                hud.yOffset = 150.f;
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:2];
            }
            
            
            
            [topView slideUp];
            
           // tableMenu.contentInset = UIEdgeInsetsMake(height_top_padding_table, 0, 0, 0);
            
           // [self completeApi];
            [self.hud hide:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [self.hud hide:YES];
        }];
    }
    else
    {
       
        
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
        int current_index = (int)[[[[dataTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"serial_number"] integerValue];
        
        [browser setCurrentPhotoIndex:current_index];
        
        // Present
        [self.navigationController pushViewController:browser animated:YES];
        
        // Manipulate
        [browser showNextPhotoAnimated:YES];
        [browser showPreviousPhotoAnimated:YES];
        //[browser setCurrentPhotoIndex:10];
    }
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    NavigrationController *navCon = (NavigrationController *)self.navigationController;
//    
//   
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 21, 21);
//    [btn setImage:[UIImage imageNamed:@"black_home"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
//    [navCon.rightBarButtonItem setCustomView:btn];
//    
//    // работаем с кнопкой МЕНЮ
//    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnMenu.frame = CGRectMake(0, 0, 22, 18);
//    [btnMenu setImage:[UIImage imageNamed:@"menu_button"] forState:UIControlStateNormal];
//    [btnMenu addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
//    [navCon.leftBarButtonItem setCustomView:btnMenu];
//}



-(void)viewWillAppear:(BOOL)animated
{
   // [super viewWillAppear:animated];
    
    NavigrationController *navCon = (NavigrationController *)self.navigationController;
    UIButton *btnMenu = (UIButton*)[navCon.rightBarButtonItem customView];
    UIImageView *ivv = (UIImageView*)[btnMenu imageView];
    [ivv setImage:[UIImage imageNamed:@"black_home"]];
    
    
    
    // работаем с кнопкой МЕНЮ
    UIButton *btnMenu2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu2.frame = CGRectMake(0, 0, 22, 18);
    [btnMenu2 setImage:[UIImage imageNamed:@"menu_button"] forState:UIControlStateNormal];
    [btnMenu2 addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    [navCon.leftBarButtonItem setCustomView:btnMenu2];
    
}

-(void)showLeftMenu
{
    [super showLeftMenu];
}

//-(CGFloat)heightForText:(NSString *)text
//{
//    NSInteger MAX_HEIGHT = 2000;
//    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, WIDTH_OF_TEXTVIEW, MAX_HEIGHT)];
//    textView.text = text;
//    textView.font = // your font
//    [textView sizeToFit];
//    return textView.frame.size.height;
//}

- (CGFloat)returnHeightByString:(NSString*)string
{
    
    CGSize maximumLabelSize = (IS_IPAD) ? CGSizeMake(687, FLT_MAX) : CGSizeMake(190, FLT_MAX);
    
    CGSize sizeLabel = [string sizeWithFont:[UIFont systemFontOfSize:10.0] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    return sizeLabel.height;
    
   
}

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
