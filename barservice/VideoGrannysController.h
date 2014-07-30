//
//  VideoGrannysController.h
//  barservice
//
//  Created by Leonid Minderov on 15.05.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "ViewController.h"
#import "GrannysController.h"

@interface VideoGrannysController : GrannysController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableMenu;
    
    NSMutableArray *dataTable;
    
    UIView *backgroundPlace;
   
    
    
}

@end
