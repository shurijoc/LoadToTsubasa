# LoadToTsubasa
本田翼の電話番号を探し出すアプリ。他の芸能人も入れられます。

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

### 概要
080-0000-0000から090-9999-9999まで電話をかけるサービス
自動音声が「あなたは本田翼ですか？ハイの場合は1を、いいえの場合は2を、ピーっという発信音の後に押してください。」と訪ねて回る

### 進捗
リアルタイムで更新される架電状況を見てユーザーが進捗を知ることができる
現在の回答状況がわかる「はい・いいえ・教えたくない」
どんな電話をかけてるかわかる

### サーバサイド
#### 電話を掛けるlambda
- dynamoの現在電話中の電話番号があるか確認する
- あったらメソッド停止
- 最新の架電した番号をdynamoから呼び出す
- 番号に+1をする。9999-9999の場合は090にする
- dynamo上の現在電話中の電話番号を上記番号にする
- twilioから電話をする
- 返り値？をtotalYesに反映させる
- 電話した電話番号にも値を追加する
- currentTel の値を削除する

#### 架電中の電話番号を返すapi
- dynamoの現在電話中の電話番号を取得する
- {
    tel: '080-0000-0000',
    calling: true or false
  } を返す

#### totalYesを返すapi
- dynamoのtotalYesの数を取得する
- { total_yes: 100 } を返す

#### 電話した件数
- dynamoのprogressの数を取得する
- { total_tel: 100 } を返す
