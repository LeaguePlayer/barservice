//
//  OrderBarserviceController.h
//  barservice
//
//  Created by Leonid Minderov on 13.05.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "ViewController.h"
#import "BarserviceViewController.h"
#import "gTextField.h"
#import "gLabel.h"
#import "gToolbar.h"
#import "gBarButtonItem.h"
#import "gTextView.h"

@interface OrderBarserviceController : BarserviceViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>
{
    float content_height;
    
    gTextView *commentArea;
    gTextField *phoneField;
    
    gToolbar *pickerToolbar;
    UIPickerView *monthPickerView;
    
   
    
}

@property (nonatomic, retain)  gTextField *type_order;

@end
