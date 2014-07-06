//
//  AFnetworkingTestViewController.m
//  TextExtractorPlease
//
//  Created by 石井賢二 on 2014/07/02.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "AFnetworkingTestViewController.h"
#import <AFNetworking.h>

static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";

@interface AFnetworkingTestViewController ()
- (IBAction)getxml:(id)sender;
- (IBAction)getjson:(id)sender;
- (IBAction)getJson2:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textview;

@end

@implementation AFnetworkingTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tapped_get:(NSString *)url key:(int)key
{
    self.textview.text = @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if(key == 1){
        manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        // 許可するContentTypeの設定が必要
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/xml"];
    }
    [manager GET:url
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             //self.textview.text = responseObject;
             NSLog(@"%@", responseObject);
             self.textview.text = [NSString stringWithFormat:@"%@", responseObject];
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             // エラーの場合はエラーの内容をコンソールに出力する
             self.textview.text = [NSString stringWithFormat:@"%@", error];
             NSLog(@"Error: %@", error);
         }];
}

- (IBAction)getxml:(id)sender {
    [self tapped_get:@"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=xml" key:1];
}

- (IBAction)getjson:(id)sender {
    //[self tapped:@"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json" key:0];
    [self tapped_get:@"https://qiita.com/api/v1/users/KenjiI" key:0];
}

- (IBAction)getJson2:(id)sender {
    self.textview.text = @"";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:@"https://qiita.com/api/v1/auth"
      parameters:@{@"url_name": @"KenjiI",@"password": @"xxx"}
         success:^(NSURLSessionDataTask *task, id responseObject) {
             //self.textview.text = responseObject;
             NSLog(@"%@", responseObject);
             self.textview.text = [NSString stringWithFormat:@"%@", responseObject];
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             // エラーの場合はエラーの内容をコンソールに出力する
             self.textview.text = [NSString stringWithFormat:@"%@", error];
             NSLog(@"Error: %@", error);
         }];
}
@end
