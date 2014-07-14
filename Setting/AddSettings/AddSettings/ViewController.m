//
//  ViewController.m
//  AddSettings
//
//  Created by necst on 2014/06/22.
//  Copyright (c) 2014年 necst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *multi_value;
@property (weak, nonatomic) IBOutlet UILabel *slider_value;
@property (weak, nonatomic) IBOutlet UILabel *text_value;
@property (weak, nonatomic) IBOutlet UILabel *switch_value;
@property (weak, nonatomic) IBOutlet UILabel *label_value;
@property (weak, nonatomic) IBOutlet UITextField *setting_label;
@property (weak, nonatomic) IBOutlet UITextField *setting_text;
@property (weak, nonatomic) IBOutlet UITextField *setting_multi;
@property (weak, nonatomic) IBOutlet UISlider *setting_slider;
@property (weak, nonatomic) IBOutlet UISwitch *setting_switch;
- (IBAction)save_setting:(id)sender;
- (IBAction)tap_screen:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setting_refer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//アプリ起動時と復帰時によばれる、設定画面の設定内容の反映メソッド(初回起動は反映できないよう)
- (void)setting_refer
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    _multi_value.text  = [userDefaults stringForKey:@"setting_multi"];
    _slider_value.text = [userDefaults stringForKey:@"setting_slider"];
    _label_value.text  = [userDefaults stringForKey:@"setting_title"];
    _text_value.text   = [userDefaults stringForKey:@"setting_text"];
    _switch_value.text = [userDefaults stringForKey:@"setting_switch"];
}

- (IBAction)save_setting:(id)sender {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_setting_multi.text forKey:@"setting_multi"];
    [userDefaults setFloat:_setting_slider.value forKey:@"setting_slider"];
    [userDefaults setObject:_setting_label.text forKey:@"setting_title"];
    [userDefaults setObject:_setting_text.text forKey:@"setting_text"];
    [userDefaults setBool:_setting_switch.on forKey:@"setting_switch"];


}

- (IBAction)tap_screen:(id)sender {
    [self.view endEditing:YES];
}
@end
