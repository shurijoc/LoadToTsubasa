# LoadToTsubasa
インターネットの広さを可視化するサービス :ocean:

## Build Setup

```bash
# install dependencies
$ yarn install

# serve with hot reload at localhost:3000
$ yarn dev

# build for production and launch server
$ yarn build
$ yarn start

# generate static project
$ yarn generate
```

### deploy
```
# all functions
serverless deploy

# per function
serverless deploy function -f <yourfunction>
```

## サービス情報

### 理由
- インターネットってどれくらい広いか知りたい

### 機能一覧
- 現在のクローリング進捗を表示する
  - クローリングsleep中は次の開始時間を表示する
  - クローリング中はsitemapを元に進捗%を表示する
- 合計クローリングページ数
- 現在の東京ドームを表示
- クローリングしたサイト一覧も載せる
- クローリングはデフォルト10秒間sleepを入れる
- Twitterのハッシュタグ検索結果を表示する
- 直近のtwitterのhash tag数に応じてクローリングの速さが変わる仕組み
  - 流行らなかったらsleep入れない
  - tweet監視機能
  - 毎日0時と12時にtweet数を監視
  - 100 tweetsでsleepなしとか

### その他
- 1pxは0.3mmとする
- ページの大きさランキングとか国の広さと比較とか入れる？

### lambda
#### クローリング機能
- TLD一覧用意
- TLDと文字列incrementの組み合わせでurlを作る
- urlのsitemapにあるページ一覧にアクセス
- jsでサイトの高さと幅を取得
- dbにサイトタイトル・ドメイン・高さ・幅を保存

#### Twitterのハッシュタグ検索（後で）
WIP

#### 現在クローリング中のサイト表示 api
- /api/v1/current_site
- url: string
- title: string

#### 累計クローリングサイト数 api
- /api/v1/total_site
- num: integer

#### 探索したサイト履歴 api
- /api/v1/sites
- response
  - title: string
  - url: string
  - page_num: integer
  - size: integer
- request
  - page: integer

### Resource

#### DynamoDB
- crawled_sites
  - title
  - url
  - page_num
  - size
  - created_at
- current_status
  - letter
  - tlds_index
- twitter_status （あとで）
  - tweet_num
  - updated_at
