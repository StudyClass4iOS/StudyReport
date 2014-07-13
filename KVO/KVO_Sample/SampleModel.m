//
//  SampleModel.m
//  KVO_Sample
//
//

#import "SampleModel.h"

@implementation SampleModel
@synthesize status;



- (instancetype)init
{
    self = [super init];
    self.status=@"first status";
    [self performSelectorInBackground:@selector(doBackgroundProcess) withObject:nil];
    return self;
}

- (void)doBackgroundProcess{
    // ５秒後に、ステータスを「第二ステータス」に更新
    [NSThread sleepForTimeInterval:5];
    self.status=@"secound status";
}

@end
