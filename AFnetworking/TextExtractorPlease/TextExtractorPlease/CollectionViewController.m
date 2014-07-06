//
//  CollectionViewController.m
//  TextExtractorPlease
//
//  Created by 石井賢二 on 2014/04/20.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import "ThumbnailImageData.h"
#import "MBProgressHUD.h"
#import <AFNetworking.h>

@interface CollectionViewController ()
@property (nonatomic, strong) NSArray *images; // UIImageViewの配列
@property (nonatomic, strong) NSArray *urlArray; // NSString(URL)の配列

@end

@implementation CollectionViewController

// Viewが表示されるタイミングで実行 viewDidAppear でデータ取得を行うため、このタイミングでProgressを表示する
- (void)viewDidLoad
{
    NSLog(@"CollectionViewController viewDidLoad");
    [super viewDidLoad];
        
    // contentViewにcellのクラスを登録
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"MY_CELL"];
}

// Viewの表示完了後に呼ばれる
- (void)viewDidAppear:(BOOL)animated
{    
    
    // URL から画像を取得（UIImage）、取得したデータ配列を self.images に詰める
    //self.images = @[[self loadImageData]];
    self.images = @[[[ThumbnailImageData alloc] getImageArray]];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.images = nil;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark UICollectionViewDataSource
// セクションの数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.images objectAtIndex:section] count];
}

// セクション内のデータの数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.images count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"cellFOrItemAtIndexPath");
    
    // セル情報の取得
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    
    // セルイメージのセット
    //cell.imageView.image = [[self.images objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];

    MBProgressHUD *prog = [MBProgressHUD showHUDAddedTo:cell animated:YES];

    [self loadImageData_async: cell indexPath: indexPath progress: prog];
    
    return cell;
}

// セルを選択した場合の処理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *messageURL = [self.urlArray objectAtIndex:indexPath.item];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"URL"
                                                        message:[NSString stringWithFormat:@"%@" , messageURL]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    [alertView show];
}

#pragma mark UICollectionViewDelegateFlowLayout
/*
 セルのサイズをアイテムごとに可変とするためのdelegateメソッド
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(99, 99);
}


/*
 // URLからデータを取得し、取得したデータ配列を返却する 同期で処理を行う（同期でイメージを全部落とした後に次の処理をする）
 - (NSMutableArray *)loadImageData
 {
 NSMutableArray *muArray = [NSMutableArray array];
 self.urlArray = [[ThumbnailImageData alloc] getImageArray];
 for (int i=0; i<self.urlArray.count; i++) {
 NSData *dt = [NSData dataWithContentsOfURL: [NSURL URLWithString:[self.urlArray objectAtIndex:i]]];
 [muArray addObject:[[UIImage alloc] initWithData:dt]];
 }
 return muArray;
 }
 */


- (NSMutableArray *)loadImageData_async: (CollectionCell *) cell indexPath:(NSIndexPath *)indexPath progress:(MBProgressHUD *)progress
{
    NSLog(@"load async");
    NSMutableArray *muArray = [NSMutableArray array];
    NSArray *urlArray = [[ThumbnailImageData alloc] getImageArray];
    
        // iOS7 ではAFHTTPSessionManager を利用する。 iOS6ではAFHTTPOperationManagerを利用するようです。
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        // レスポンスデータは既定ではJSONとして解析する
        // なので、画像として解析したい場合は、ResponseSerializer に画像であることを指定する必要がある。
        [manager setResponseSerializer:[AFImageResponseSerializer serializer]];
    
        // GET/POST もちろんどちらも使えます。
        // GETの場合の例
        // [manager
        //   GET:リクエストURL
        //   parameters:パラメータ
        //   success:成功時のCallBack
        //   failure:失敗時のCallBack
        // ]
        [manager GET:[urlArray objectAtIndex:indexPath.item]
           parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 // 通信に成功した場合の処理
                 NSLog(@"responseObject: %@", responseObject);

                 [progress hide:YES];
                 cell.imageView.image = (UIImage *)responseObject;

             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 // エラーの場合はエラーの内容をコンソールに出力する
                 NSLog(@"Error: %@", error);
             }];
    return muArray;
}

@end
