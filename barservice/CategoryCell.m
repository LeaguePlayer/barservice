//
//  CategoryCell.m
//  barservice
//
//  Created by Leonid Minderov on 16.04.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell


- (void)awakeFromNib
{
    // Initialization code
    //self.backgroundColor = [UIColor clearColor];
    self.categoryName.textColor = [UIColor colorWithRed:0.255 green:0.255 blue:0.255 alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
