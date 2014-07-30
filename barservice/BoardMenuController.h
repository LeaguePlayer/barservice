//
//  BoardMenuController.h
//  barservice
//
//  Created by Leonid Minderov on 31.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrannysController.h"
#import "TopViewMenu.h"


@interface BoardMenuController : GrannysController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableMenu;
    UITableView *tableCategory;
    
    NSMutableArray *dataTable;
     NSMutableDictionary *categoryTable;
    
    UIView *backgroundPlace;
    TopViewMenu *topView;
    
    float heightAllRows;
}

@property (nonatomic,retain) NSMutableArray *photos;



@end
