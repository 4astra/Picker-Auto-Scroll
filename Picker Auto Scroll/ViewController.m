//
//  ViewController.m
//  Picker Auto Scroll
//
//  Created by Minh Dat Giap on 9/24/15.
//  Copyright © 2015 Hoat Ha Van. All rights reserved.
//

#import "ViewController.h"

static NSString *const kDictValue = @"value";
static NSString *const kDictBoldFont = @"boldFont";
static NSString *const kDictNoMin = @"No Min";
static NSString *const kDictNoMax = @"No Max";
static NSString *const kDictAny = @"Any";
//NSMutableDictionary
@implementation NSMutableDictionary (Utils)
+(NSMutableDictionary*)dictWithValue:(NSString*)value boldFont:(BOOL)boldFont{
    return [NSMutableDictionary dictionaryWithObjects:@[value, @(boldFont)] forKeys:@[kDictValue, kDictBoldFont]];
}
-(BOOL)isBoldFont{
    NSNumber *num = [self valueForKey:kDictBoldFont];
    if ([num isEqualToNumber:@1]) {
        return YES;
    }
    return NO;
}

-(void)setBoldFont:(BOOL)boldFont{
    [self setValue:@(boldFont) forKey:kDictBoldFont];
}

-(BOOL)isNoMinOrNoMaxNoAnyValue{
    NSString *value = [self getValue];
    if ([value isEqualToString:kDictNoMin] || [value isEqualToString:kDictNoMax] || [value isEqualToString:kDictAny] ) {
        return YES;
    }
    return NO;
}
-(NSString*)getValue{
    return [self valueForKey:kDictValue];
}
@end


//ViewController
@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation ViewController

-(void)setUp{
    _arrPickerDatas = @[
                       
                        @[[NSMutableDictionary dictWithValue:@"Any" boldFont:NO], [NSMutableDictionary dictWithValue:@"Any" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"No Min" boldFont:NO], [NSMutableDictionary dictWithValue:@"No Max" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 10,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 10,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 20,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 20,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 30,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 30,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 50,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 50,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 100,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 100,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 130,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 130,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 150,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 150,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 200,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 200,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 250,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 250,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 300,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 300,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 350,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 350,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 400,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 400,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 450,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 450,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 500,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 500,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 550,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 550,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 600,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 600,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 650,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 650,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 700,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 700,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 750,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 750,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 800,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 800,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 850,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 850,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 900,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 900,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 950,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 950,000" boldFont:NO]],
                        @[[NSMutableDictionary dictWithValue:@"$ 1,000,000" boldFont:NO], [NSMutableDictionary dictWithValue:@"$ 1,000,000" boldFont:NO]]
                        ];
    
    [_ibValuePickerView reloadAllComponents];
}

-(void)scrollToCurrentValue:(NSString*)stringInfo{
    NSArray *arrayTemp = [stringInfo componentsSeparatedByString:@" - "];
    if ([arrayTemp count]) {
        NSLog(@"Temp: %@", arrayTemp);
        NSString *stringLeft = [arrayTemp firstObject];
        NSString *stringRight = [arrayTemp lastObject];
        NSInteger indexLeft = [self indexOfValue:stringLeft inComponent:0];
        NSInteger indexRight = [self indexOfValue:stringRight inComponent:1];
        [_ibValuePickerView selectRow:indexLeft inComponent:0 animated:NO];
        [_ibValuePickerView selectRow:indexRight inComponent:1 animated:NO];
    }
}

//Find the index of value in Picker at component {0;1}
-(NSInteger)indexOfValue:(NSString*)value inComponent:(NSInteger)component{
    for (NSInteger index = 0; index < [_arrPickerDatas count]; index ++) {
        NSMutableDictionary *dict = [[_arrPickerDatas objectAtIndex:index] objectAtIndex:component];
        NSString *stringCurrent = [dict getValue];
        if ([stringCurrent isEqualToString:value]) {
            return index;
        }
    }
    return 0;
}


#pragma mark Picker View Datasource and Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_arrPickerDatas count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_ibValuePickerView.frame)/2, 30)];
    
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    NSMutableDictionary *dict = [[_arrPickerDatas objectAtIndex:row] objectAtIndex:component];
    BOOL isBoldFont = [dict isBoldFont];
    if (isBoldFont) {
        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    }else{
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    }
    label.text = [dict getValue];
    
    
    [label sizeToFit];
    return label;
}

//replace some special keys with space
-(void)replaceSpecialKeysByWhiteSpace:(NSString**)stringReplace{
    *stringReplace = [*stringReplace stringByReplacingOccurrencesOfString:@"$" withString:@""];
    *stringReplace = [*stringReplace stringByReplacingOccurrencesOfString:@"," withString:@""];
    *stringReplace = [*stringReplace stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(void)checkValueInLeftSide:(NSInteger *)selectedRowA selectedRowB:(NSInteger*)selectedRowB{
    
    NSInteger numItem = [_arrPickerDatas count];
    NSMutableDictionary *dict1Left = [[_arrPickerDatas objectAtIndex:*selectedRowA] objectAtIndex:0];
    NSMutableDictionary *dict2Left = [[_arrPickerDatas objectAtIndex:*selectedRowB] objectAtIndex:1];
    
    NSString *value1Left = [dict1Left getValue];
    NSString *value2Left = [dict2Left getValue];
    
    if (![value1Left isEqualToString:kDictNoMin] && ![value1Left isEqualToString:kDictAny] ) {
        
        if (![value2Left isEqualToString:kDictNoMax] && ![value2Left isEqualToString:kDictAny]) {

            [self replaceSpecialKeysByWhiteSpace:&value1Left];

            [self replaceSpecialKeysByWhiteSpace:&value2Left];
            
            NSUInteger numLeft = [value1Left integerValue];
            NSUInteger numRight = [value2Left integerValue];
            
            if (numLeft >= numRight) {
                NSLog(@"Need change value of right");
                
                NSUInteger willToIndex = *selectedRowA;
                willToIndex++;
                if (willToIndex > numItem - 1) {
                    willToIndex = 0;
                }
                [_ibValuePickerView selectRow:willToIndex inComponent:1 animated:YES];
                *selectedRowB = willToIndex;
                
                //update Bold font
                for (NSInteger index = 0; index < numItem; index ++) {
                    NSMutableDictionary *dict1 = [[_arrPickerDatas objectAtIndex:index] objectAtIndex:1];
                    [dict1 setBoldFont:NO];
                }
                dict2Left = [[_arrPickerDatas objectAtIndex:*selectedRowB] objectAtIndex:1];
                [dict2Left setBoldFont:YES];
            }
        }
        
        for (NSInteger index = 0; index < numItem; index ++) {
            NSMutableDictionary *dict1 = [[_arrPickerDatas objectAtIndex:index] objectAtIndex:0];
            [dict1 setBoldFont:NO];
        }
        
        [dict1Left setBoldFont:YES];
        
    }
    else{
        
        for (NSInteger index = 0; index < numItem; index ++) {
            NSMutableDictionary *dict1 = [[_arrPickerDatas objectAtIndex:index] objectAtIndex:0];
            [dict1 setBoldFont:NO];
        }
        
        [dict1Left setBoldFont:YES];
    }
}


-(void)checkValueInRightSide:(NSInteger*)selectedRowA selectedRowB:(NSInteger*)selectedRowB{
    NSInteger numItem = [_arrPickerDatas count];
    NSMutableDictionary *dict1Left = [[_arrPickerDatas objectAtIndex:*selectedRowA] objectAtIndex:0];
    NSMutableDictionary *dict2Left = [[_arrPickerDatas objectAtIndex:*selectedRowB] objectAtIndex:1];
    
    NSString *value1Left = [dict1Left getValue];
    NSString *value2Left = [dict2Left getValue];
    
    if (![value2Left isEqualToString:kDictNoMax] && ![value2Left isEqualToString:kDictAny]) {
        
        if (![value1Left isEqualToString:kDictNoMin] && ![value1Left isEqualToString:kDictAny]) {
            
            [self replaceSpecialKeysByWhiteSpace:&value1Left];
            
            [self replaceSpecialKeysByWhiteSpace:&value2Left];
            
            NSUInteger numLeft = [value1Left integerValue];
            NSUInteger numRight = [value2Left integerValue];
            
            if (numLeft >= numRight) {
                NSLog(@"Need change value of left");
                
                NSInteger willToIndex = *selectedRowB;
                willToIndex--;
                if (willToIndex < 0) {
                    willToIndex = 0;
                }
                [_ibValuePickerView selectRow:willToIndex inComponent:0 animated:YES];
                *selectedRowA = willToIndex;
                for (NSInteger index = 0; index < numItem; index ++) {
                    NSMutableDictionary *dict1 = [[_arrPickerDatas objectAtIndex:index] objectAtIndex:0];
                    [dict1 setBoldFont:NO];
                }
                dict1Left = [[_arrPickerDatas objectAtIndex:*selectedRowA] objectAtIndex:0];
                [dict1Left setBoldFont:YES];
            }
        }
        
        for (NSInteger index = 0; index < numItem; index ++) {
            NSMutableDictionary *dict2 = [[_arrPickerDatas objectAtIndex:index] objectAtIndex:1];
            [dict2 setBoldFont:NO];
        }
        [dict2Left setBoldFont:YES];
        
    }
    else{
        
        for (NSInteger index = 0; index < numItem; index ++) {
            NSMutableDictionary *dict2 = [[_arrPickerDatas objectAtIndex:index] objectAtIndex:1];
            [dict2 setBoldFont:NO];
        }
        [dict2Left setBoldFont:YES];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSInteger selectedRowA = [_ibValuePickerView selectedRowInComponent:0];
    NSInteger selectedRowB = [_ibValuePickerView selectedRowInComponent:1];
    
    if (component == 0) {//---------------------------Left scroll
        
        [self checkValueInLeftSide:&selectedRowA selectedRowB:&selectedRowB];
        
        
    }else if(component == 1){//--------------------------Right scroll
        
        [self checkValueInRightSide:&selectedRowA selectedRowB:&selectedRowB];
    }
    NSMutableDictionary *dictLeft = [[_arrPickerDatas objectAtIndex:selectedRowA] objectAtIndex:0];
    NSMutableDictionary *dictRight = [[_arrPickerDatas objectAtIndex:selectedRowB] objectAtIndex:1];
    
    NSLog(@"Select at [Value 1: %@, Value 2 :%@]", [dictLeft getValue], [dictRight getValue]);
          
    //picker reload
    [_ibValuePickerView reloadAllComponents];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    
    [self scrollToCurrentValue:@"$ 30,000 - $ 100,000"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
