
AFnetworking - GitHub
https://github.com/AFNetworking/AFNetworking

・iOS / Mac OS X 用 ネットワークライブラリ
   Cocoも標準で提供しているが、それを拡張し簡単に使えるようにしたもの。
   非同期通信・ファイルアップロード・ダウンロード

・導入は
  - AFnetworking のインストール
    podfile
    ---------------------------------
  　　platform :ios, '7.0'
  　　pod "AFNetworking", "~> 2.0"
    ---------------------------------
    >pod install

  - AFnetworking を import する
　　　#import <AFnetworking.h>

　だけ！

・有名なので日本語のサイトもいっぱいヒットします。

AFNetworking 2.0 のまとめ
http://qiita.com/asakahara/items/9cb68bef56ca70b505c6

ド定番OSS！AFNetworking 2.xの使い方
http://dev.classmethod.jp/smartphone/iphone/ios-afnetworking2/

iOS 7で一新された通信周り〜NSURLSessionってなに？〜
http://dev.classmethod.jp/references/ios-nsurlsession-1/

・CocoaDocsにReferenceもあります。

AFnetworking - CocoaDocs
http://cocoadocs.org/docsets/AFNetworking/2.0.0/Classes/AFHTTPSessionManager.html


・iOS6 用なら AFHTTPOperationManager（NSURLConnectionベース）
   iOS7 用なら AFHTTPSessionManager（NSURLSeesionベース）

・NSURLConnection, NSURLSeesion どちらも 
   CocoaFW のクラスで非同期通信を実現するためのもの。
　NSURLSeesion は iOS7 で登場。
　NSURLConnectionと比較して次のメリットがある。
　（NSURLConnectionの強化版的な位置づけ）
　・今までNSURLConnectionより簡単・便利
　・バックグラウンドでダウンロード・アップロード処理が行える

・通信処理はもちろん、
   - HTTPリスエストヘッダに任意のパラメータ設定が可能
　- 通信ログ
　- キャッシュポリシー
　- タイムアウトの設定
   - セキュリティポリシ
　などもサポート

・あとはサンプル　Get/Post - json, Get - xml, 画像非同期ロード　くらい
