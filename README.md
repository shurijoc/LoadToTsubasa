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
