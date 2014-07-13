//
//  ViewController.h
//  KVO_Sample
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)method:(id)sender;


@end
