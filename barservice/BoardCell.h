//
//  BoardCell.h
//  barservice
//
//  Created by Leonid Minderov on 31.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageMenu;
@property (strong, nonatomic) IBOutlet UILabel *nameMenu;
@property (strong, nonatomic) IBOutlet UILabel *compositionMenu;
@property (strong, nonatomic) IBOutlet UILabel *priceMenu;

@end
