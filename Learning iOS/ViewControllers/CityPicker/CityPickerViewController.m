//
//  CityPickerViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/1/31.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "CityPickerViewController.h"

@interface CityPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSInteger _provinceIndex;   // 省份选择 记录
    NSInteger _cityIndex;       // 市选择 记录
    NSInteger _districtIndex;   // 区选择 记录
}
@property (nonatomic, strong) UIPickerView * pickerView;
@property (nonatomic,strong) UITextField * cityTextField;
@property (nonatomic,strong) NSArray * arrayDS;

@end

@implementation CityPickerViewController

-(UIPickerView *)pickerView {
    if(!_pickerView){
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-PICKER_HEIGHT, SCREEN_WIDTH, PICKER_HEIGHT)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

-(UITextField *) cityTextField{
    if(!_cityTextField){
        _cityTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 100, 250, 40)];
        _cityTextField.borderStyle = UITextBorderStyleLine;
        _cityTextField.textColor = [UIColor blackColor];
        _cityTextField.backgroundColor = [UIColor whiteColor];
    }
    return _cityTextField;
}

-(void)resetPickerSelectRow{
    [self.pickerView selectRow:_provinceIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:_cityIndex inComponent:1 animated:YES];
    [self.pickerView selectRow:_districtIndex inComponent:2 animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CityPicker";
    self.view.backgroundColor = [UIColor whiteColor];
    self.cityTextField.inputView = self.pickerView;
    [self.view addSubview:self.cityTextField];
    [self initData];
    [self resetPickerSelectRow];
}

-(void) initData{
    _provinceIndex = _cityIndex = _districtIndex = 0;
}

-(NSArray *)arrayDS {
    if(!_arrayDS){
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"province" ofType:@"plist"];
        _arrayDS =[[NSArray alloc]initWithContentsOfFile:filePath];
    }
    return _arrayDS;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma UIPickerViewDataSource
// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// 每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return self.arrayDS.count;
    }else if(component == 1){
        return [self.arrayDS[_provinceIndex][@"citys"] count];
    }else{
        return [self.arrayDS[_provinceIndex][@"citys"][_cityIndex][@"districts"] count];
    }
}

#pragma UIPickerViewDelegate
// 返回每一行的内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    if(component == 0){
        return self.arrayDS[row][@"province"];
    }else if(component == 1){
        return self.arrayDS[_provinceIndex][@"citys"][row][@"city"];
    }else {
        return self.arrayDS[_provinceIndex][@"citys"][_cityIndex][@"districts"][row];
    }
}
// 滑动或点击选择，确认pickerView选中结果
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    if(component == 0){
        _provinceIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
    }
    else if(component == 1){
        _cityIndex = row;
        _districtIndex = 0;
        
        [self.pickerView reloadComponent:2];
    }
    else{
        _districtIndex = row;
    }
    [self resetPickerSelectRow];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 NSString * address = [NSString stringWithFormat:@"%@-%@-%@",
                       self.arrayDS[_provinceIndex][@"province"],
                       self.arrayDS[_provinceIndex][@"citys"][_cityIndex][@"city"],
                       self.arrayDS[_provinceIndex][@"citys"][_cityIndex][@"districts"][_districtIndex]];
    self.cityTextField.text = address;
    [self.cityTextField resignFirstResponder];//失去焦点
}


@end
