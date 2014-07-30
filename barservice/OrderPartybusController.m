//
//  OrderPartybusController.m
//  barservice
//
//  Created by Leonid Minderov on 27.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "OrderPartybusController.h"

@interface OrderPartybusController ()

@end

@implementation OrderPartybusController
@synthesize monthArray;
@synthesize reasonArray;
@synthesize categoryArray;
@synthesize type_order;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.type_order = [[gTextField alloc] init];
    self.type_order.text = @"Заказ PartyBus";
    
    
    // Do any additional setup after loading the view.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    content_height+=space_Y;
    
    self.monthArray=[[NSArray alloc] initWithObjects:@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    self.reasonArray = [[NSArray alloc] initWithObjects:@"День рождение", @"Выпускной", @"Свадьба", @"Мальчишник", @"Девичник", @"Baby born", @"Goodbye my love", nil];
    self.categoryArray = [[NSArray alloc] initWithObjects:@"Все свое", @"Мохито Пати", @"Show Time Party", @"Men’s Party", @"Безалкоголь Party", @"Spumante party", @"VIva mix!", nil];
    
       //name
    
    gLabel *nameLabel = [[gLabel alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 14)];
    nameLabel.text=@"Как Вас зовут?";
    content_height+=nameLabel.frame.size.height + space_Y;
    
    
    gTextField *nameField = [[gTextField alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 45)];
    nameField.delegate = self;
    nameField.text = ([[userDefaults objectForKey:@"name"] length]) ? [userDefaults objectForKey:@"name"] : @"";
    
    
    content_height+=nameField.frame.size.height + space_Y;
    
    
    //ПОВОД
    
    gLabel *reasonLabel = [[gLabel alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 14)];
    reasonLabel.text=@"Какой у Вас повод?";
    content_height+=nameLabel.frame.size.height + space_Y;
    
    
    reasonField = [[gTextField alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 45)];
    reasonField.delegate = self;
    reasonField.text = [self.reasonArray objectAtIndex:0];
    [reasonField makeDownArrow];
    content_height+=reasonField.frame.size.height + space_Y;
    
    //Категория вечеринки
    
    gLabel *categoryLabel = [[gLabel alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 14)];
    categoryLabel.text=@"Категория вечеринки";
    content_height+=categoryLabel.frame.size.height + space_Y;
    
    
    categoryField = [[gTextField alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 45)];
    categoryField.delegate = self;
    categoryField.text = [self.categoryArray objectAtIndex:0];
    [categoryField makeDownArrow];
    content_height+=categoryField.frame.size.height + space_Y;
    
   
    
    
    //phone
    
    gLabel *phoneLabel = [[gLabel alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 14)];
    phoneLabel.text=@"Ваш номер телефона?";
    content_height+=phoneLabel.frame.size.height + space_Y;
    
    
    phoneField = [[gTextField alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 45)];
    phoneField.delegate = self;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.text = ([[userDefaults objectForKey:@"phone"] length]) ? [userDefaults objectForKey:@"phone"] : @"";
    content_height+=phoneField.frame.size.height + space_Y;
    
    
    // Hours
    gLabel *HoursLabel = [[gLabel alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 14)];
    HoursLabel.text=@"Количество часов?";
    content_height+=HoursLabel.frame.size.height + space_Y;
    
    
    HoursField = [[gTextField alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 45)];
    HoursField.delegate = self;
    HoursField.text=[monthArray objectAtIndex:0];
    [HoursField makeDownArrow];
    content_height+=HoursField.frame.size.height + paddingBottom;
    
    
    // ИТОГО
    itogo = [[gLabel alloc] initWithFrame:CGRectMake(paddingLeft, content_height, self.viewScroll.frame.size.width-(2*paddingLeft), 18)];
    itogo.font = [UIFont boldSystemFontOfSize:15.0f];
    
    content_height+=itogo.frame.size.height + space_Y;
    [self calculateSum];
    
    
    
    [self.fieldsForSend setDictionary:@{@"name": nameField, @"phone": phoneField, @"params[hours]": HoursField, @"params[reason]": reasonField, @"params[category]":categoryField, @"service_name": type_order}];
    //  fieldArray = [NSArray arrayWithObjects: nameField, phoneField, HoursField, nil];
    
    
    
    UIView *backgroundPlace= [self makeMainBackgroundwithBorder:NO andHeightIs:content_height andSwitchType:@"partybus"];
    [backgroundPlace addSubview:nameLabel];
    [backgroundPlace addSubview:nameField];
    [backgroundPlace addSubview:reasonLabel];
    [backgroundPlace addSubview:reasonField];
    [backgroundPlace addSubview:categoryLabel];
    [backgroundPlace addSubview:categoryField];
    [backgroundPlace addSubview:phoneLabel];
    [backgroundPlace addSubview:phoneField];
    [backgroundPlace addSubview:HoursLabel];
    [backgroundPlace addSubview:HoursField];
    [backgroundPlace addSubview:itogo];
    
    
    [self.fieldsForSend allValues];
    UIView *buttonReserve = [self makeReserveButtonByPositionAtY:backgroundPlace.frame.size.height-50 andAction:@"goToReserveWithSendData" withTitle:@"Заказать Party Bus"];
    
    //    for(id subview in buttonReserve.subviews)
    //    {
    //        if([subview isKindOfClass:[UIButton class]])
    //        {
    //            UIButton *tmpButton = subview;
    //            tmpButton
    //        }
    //    }
    
    
    self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, content_height+buttonReserve.frame.size.height);
    
    [self.viewScroll addSubview:buttonReserve];
    [self.viewScroll addSubview:backgroundPlace];
    
    
    
    
	// Do any additional setup after loading the view.
}

-(void)calculateSum
{
    int sum = 0;
    
    sum = (int)[HoursField.text integerValue]*(int)PRICE_OF_PARTYBUS;
    
    itogo.text=[NSString stringWithFormat:@"Стоимость услуги %i руб.", sum];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self resizeContentWithKeyboard:YES];
}





-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self calculateSum];
    [self resizeContentWithKeyboard:NO];
}

-(void)goToReserveWithSendData
{
    // делаем валидацию
    
    if(![self validateFields])
        [super goToReserveWithSendData];
}

#pragma mark - UITextField



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([textField isEqual:HoursField])
    {
        [self showPicker:textField];
        if(HoursField.text.length>=1){
            [monthPickerView selectRow:[self.monthArray indexOfObject:HoursField.text] inComponent:0 animated:NO];
        }
    }
    else if([textField isEqual:categoryField])
    {
        [self showPicker:textField];
        if(categoryField.text.length>=1){
            [categoryPickerView selectRow:[self.categoryArray indexOfObject:categoryField.text] inComponent:0 animated:NO];
        }
    }
    else if([textField isEqual:reasonField])
    {
        [self showPicker:textField];
        if(reasonField.text.length>=1){
            [reasonPickerView selectRow:[self.reasonArray indexOfObject:reasonField.text] inComponent:0 animated:NO];
        }
    }
    return YES;
}


- (void)showPicker:(id)sender {
    
    UITextField *tmp_field = (UITextField *)sender;
    
    if(tmp_field == reasonField)
    {
        reasonPickerView = [[UIPickerView alloc] init];
        reasonPickerView.showsSelectionIndicator = YES;
        reasonPickerView.dataSource = self;
        reasonPickerView.delegate = self;
        
        reasonField.inputView = reasonPickerView;
        
    }
    else if(tmp_field == categoryField)
    {
        categoryPickerView = [[UIPickerView alloc] init];
        categoryPickerView.showsSelectionIndicator = YES;
        categoryPickerView.dataSource = self;
        categoryPickerView.delegate = self;
        
        categoryField.inputView = categoryPickerView;
    }
    else
    {
        monthPickerView = [[UIPickerView alloc] init];
        monthPickerView.showsSelectionIndicator = YES;
        monthPickerView.dataSource = self;
        monthPickerView.delegate = self;
        
        
        
        
        //set picker view inside the input view of the textfield
        HoursField.inputView = monthPickerView;
        // HoursField.inputAccessoryView = pickerToolbar;
    }
    
   
}

-(void)doneClicked:(id) sender
{
    
    [HoursField resignFirstResponder];
}


- (BOOL) textFieldShouldReturn:(UITextField *) textField {
    [self calculateSum];
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign)
    {
        return NO;
    }
    
    NSUInteger index = [[self.fieldsForSend allValues] indexOfObject:textField];
    
    
    
    
    
    
    id nextField = [[self.fieldsForSend allValues] objectAtIndex:index + 1];
    //activeField = nextField;
    [nextField becomeFirstResponder];
   // [self resizeContentWithKeyboard:NO];
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView == reasonPickerView)
        reasonField.text = [reasonArray objectAtIndex:row];
    else if(pickerView == categoryPickerView)
        categoryField.text = [categoryArray objectAtIndex:row];
    else
        HoursField.text = [monthArray objectAtIndex:row];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if(pickerView == reasonPickerView)
        return [reasonArray count];
    else if(pickerView == categoryPickerView)
        return [categoryArray count];
    else
        return [monthArray count];
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if(pickerView == reasonPickerView)
        return [reasonArray objectAtIndex:row];
    else if(pickerView == categoryPickerView)
        return [categoryArray objectAtIndex:row];
    else
        return [monthArray objectAtIndex:row];
    
}



@end
