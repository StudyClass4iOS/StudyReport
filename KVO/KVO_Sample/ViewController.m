//
//  ViewController.m
//  KVO_Sample
//
//

#import "ViewController.h"
#import "SampleModel.h"
@interface ViewController ()
{
    SampleModel *model;
}

@end

@implementation ViewController
@synthesize textField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    model = [[SampleModel alloc] init];
   
    
    	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [model addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionOld |
                                                        NSKeyValueObservingOptionNew) context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
					 ofObject:(id)object
					   change:(NSDictionary *)change
					  context:(void *)context
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"KVO Sample" message:[NSString stringWithFormat:@"%@ has changed.\nchange:\n %@",keyPath,change] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)method:(id)sender
{
    model.status = textField.text;
    NSLog(@"button clicked");
    NSLog(@"model property value %@",model.status);
}
@end
