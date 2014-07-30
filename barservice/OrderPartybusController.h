//
//  OrderPartybusController.h
//  barservice
//
//  Created by Leonid Minderov on 27.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartyBusController.h"
#import "gTextField.h"
#import "gLabel.h"
#import "gToolbar.h"
#import "gBarButtonItem.h"


@interface OrderPartybusController : PartyBusController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>
{
    float content_height;
    
    gTextField *HoursField;
    gTextField *phoneField;
    
    gTextField *reasonField;
    
    gToolbar *pickerToolbar;
    
    
    
    
    
    UIPickerView *monthPickerView;
    UIPickerView *reasonPickerView;
    
    //category picker
    gTextField *categoryField;
    UIPickerView *categoryPickerView;
    
    //ИТОГО
    gLabel *itogo;
    
}

@property (strong, nonatomic) NSArray *monthArray;
@property (strong, nonatomic) NSArray *reasonArray;
@property (strong, nonatomic) NSArray *categoryArray;
@property (nonatomic, retain)  gTextField *type_order;

@end
