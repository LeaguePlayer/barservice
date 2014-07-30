//
//  OrderBarserviceController.m
//  barservice
//
//  Created by Leonid Minderov on 13.05.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "OrderBarserviceController.h"

@interface OrderBarserviceController ()

@end

@implementation OrderBarserviceController
@synthesize type_order;

-(id)init
{
    self = [super init];
    type_order = [[gTextField alloc] init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_IPAD)
    {
        CGRect frame = self.viewScroll.frame;
        frame.origin.y -=65.0;
        self.viewScroll.frame = frame;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    content_height+=space_Y;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // self.monthArray=[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8 и более", nil];
    
    
    //name
    
    gLabel *nameLabel = [[gLabel alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 14)];
    nameLabel.text=@"Как Вас зовут?";
    nameLabel.textColor = [UIColor colorWithRed:0.286 green:0.259 blue:0.227 alpha:1];
    content_height+=nameLabel.frame.size.height + space_Y;
    
    
    gTextField *nameField = [[gTextField alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 45)];
    nameField.delegate = self;
    nameField.text = ([[userDefaults objectForKey:@"name"] length]) ? [userDefaults objectForKey:@"name"] : @"";
    
    
    content_height+=nameField.frame.size.height + space_Y;
    
    
    
    //phone
    
    gLabel *phoneLabel = [[gLabel alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 14)];
    phoneLabel.text=@"Ваш номер телефона?";
    phoneLabel.textColor = [UIColor colorWithRed:0.286 green:0.259 blue:0.227 alpha:1];
    content_height+=phoneLabel.frame.size.height + space_Y;
    
    
    phoneField = [[gTextField alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 45)];
    phoneField.delegate = self;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.text = ([[userDefaults objectForKey:@"phone"] length]) ? [userDefaults objectForKey:@"phone"] : @"";
    content_height+=phoneField.frame.size.height + space_Y;
    
    
    // mans
    gLabel *mansLabel = [[gLabel alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 14)];
    mansLabel.text=@"Комментарий";
    mansLabel.textColor = [UIColor colorWithRed:0.286 green:0.259 blue:0.227 alpha:1];
    content_height+=mansLabel.frame.size.height + space_Y;
    
    
    commentArea = [[gTextView alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 131)];
    commentArea.delegate = self;
    
    
    content_height+=commentArea.frame.size.height + paddingBottom;
    
    [self.fieldsForSend setDictionary:@{@"name": nameField, @"phone": phoneField, @"params[comment]": commentArea, @"service_name": type_order}];
    //  fieldArray = [NSArray arrayWithObjects: nameField, phoneField, mansField, nil];
    
    UIView *backgroundPlace= [self makeMainBackgroundwithBorder:NO andHeightIs:content_height andSwitchType:@"barservice_order"];
    [backgroundPlace addSubview:nameLabel];
    [backgroundPlace addSubview:nameField];
    [backgroundPlace addSubview:phoneLabel];
    [backgroundPlace addSubview:phoneField];
    [backgroundPlace addSubview:mansLabel];
    [backgroundPlace addSubview:commentArea];
    
    
    [self.fieldsForSend allValues];
    UIView *buttonReserve = [self makeReserveButtonByPositionAtY:backgroundPlace.frame.size.height-50 andAction:@"goToReserveWithSendData" withTitle:@"Отправить заявку"];
    
    //    for(id subview in buttonReserve.subviews)
    //    {
    //        if([subview isKindOfClass:[UIButton class]])
    //        {
    //            UIButton *tmpButton = subview;
    //            tmpButton
    //        }
    //    }
    
    [self.viewScroll addSubview:buttonReserve];
    [self.viewScroll addSubview:backgroundPlace];
    
	// Do any additional setup after loading the view.
}

-(void)goToReserveWithSendData
{
    // делаем валидацию
    
    if(![self validateFields])
        [super goToReserveWithSendData];
}

#pragma mark - UITextField



//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if([textField isEqual:mansField])
//    {
//        [self showPicker:textField];
//        if(commentArea.text.length>=1){
//            [monthPickerView selectRow:[self.monthArray indexOfObject:mansField.text] inComponent:0 animated:NO];
//        }
//    }
//    return YES;
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self resizeContentWithKeyboard:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self resizeContentWithKeyboard:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self resizeContentWithKeyboard:NO];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resizeContentWithKeyboard:NO];
}



- (void)showPicker:(id)sender {
    monthPickerView = [[UIPickerView alloc] init];
    monthPickerView.showsSelectionIndicator = YES;
    monthPickerView.dataSource = self;
    monthPickerView.delegate = self;
    
    
    
    
    //set picker view inside the input view of the textfield
    commentArea.inputView = monthPickerView;
    // mansField.inputAccessoryView = pickerToolbar;
}

-(void)doneClicked:(id) sender
{
    
    [commentArea resignFirstResponder];
}


- (BOOL) textFieldShouldReturn:(UITextField *) textField {
    
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign)
    {
        return NO;
    }
    
    NSUInteger index = [[self.fieldsForSend allValues] indexOfObject:textField];
    
    
    
    
    
    
    id nextField = [[self.fieldsForSend allValues] objectAtIndex:index + 1];
    //activeField = nextField;
    [nextField becomeFirstResponder];
    [self resizeContentWithKeyboard:NO];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if([textField isEqual:phoneField])
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        
        
        
        if(newLength == 11)
        {
            textField.text = [NSString stringWithFormat:@"%@%@",textField.text, string];
            [self textFieldShouldReturn:textField];
            return NO;
        }
        else if(newLength > 11)
        {
            
            // id nextField = [fieldArray objectAtIndex:index + 1];
            [self textFieldShouldReturn:textField];
            
            return NO;
            // return YES;
        }
    }
    
    
    
    
    
    return YES;
}


#pragma mark - UIPickerView

//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
//{
//    return 1;
//}
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    mansField.text = [monthArray objectAtIndex:row];
//}
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
//{
//    return [monthArray count];
//}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
//{
//    return [monthArray objectAtIndex:row];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
