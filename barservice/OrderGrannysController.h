//
//  OrderGrannysController.h
//  barservice
//
//  Created by Leonid Minderov on 07.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrannysController.h"
#import "gTextField.h"
#import "gLabel.h"
#import "gToolbar.h"
#import "gBarButtonItem.h"

@interface OrderGrannysController : GrannysController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    float content_height;
    
    gTextField *mansField;
    gTextField *phoneField;
    
    gToolbar *pickerToolbar;
    UIPickerView *monthPickerView;
    
     
}


@property (strong, nonatomic) NSArray *monthArray;
@property (nonatomic, retain)  gTextField *type_order;

@end
